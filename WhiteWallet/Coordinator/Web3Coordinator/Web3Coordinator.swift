//
//  Web3Coordinator.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 06.07.24.
//

import Foundation
import Combine
import web3swift
import Web3Core

/*
 TODO:
    - Implement getETHBalance()
    - Implement sendETH()
 */

final class Web3Coordinator: Web3CoordinatorProtocol {
    //MARK: Properties
    static let shared: Web3CoordinatorProtocol = Web3Coordinator(walletLocalRepository: WalletLocalRepository())
    
    let walletLocalRepository: WalletLocalRepositoryProtocol
    let provider: Web3 = Web3(
        provider: Web3HttpProvider(
            url: URL(string: "https://mainnet.infura.io/v3/7dceffcc53cd44758cade607c3bf91da")!,
            network: .Mainnet
        )
    )
    
    private let documentsDirectory = URL.documentsDirectory
    private var cancellables: [AnyCancellable] = []
    
    //MARK: Init
    init(walletLocalRepository: WalletLocalRepositoryProtocol) {
        self.walletLocalRepository = walletLocalRepository
    }
    
    //MARK: Wallet create/import
    func createHDWallet(with password: String) -> Void {
        Deferred {
            Future<WalletInstance, WalletError> { completion in
                do {
                    let mnemonics = try! BIP39.generateMnemonics(bitsOfEntropy: 128)!
                    let keystore = try! BIP32Keystore(mnemonics: mnemonics, password: password, mnemonicsPassword: "")
                    let keydata = try JSONEncoder().encode(keystore?.keystoreParams)
                    
                    if let keystore = keystore,
                       let address = keystore.addresses?.first?.address,
                       self.storeMnemonicsInKeychain(forKey: address, mnemonics) {
                        completion(.success(
                            .init(
                                address: address,
                                keyData: keydata,
                                name: nil,
                                type: .hd(mnemonics: mnemonics.split(separator: " ").map(String.init))
                            )
                        ))
                    } else {
                        completion(.failure(.persistError("Could not persist wallet keydata")))
                    }
                } catch let error {
                    completion(.failure(.creationError("Could not create wallet: \(error.localizedDescription)")))
                }
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
        .flatMap { [weak self] wallet -> AnyPublisher<WalletInstance?, WalletError> in
            guard let self = self else {
                return Just(nil)
                    .setFailureType(to: WalletError.self)
                    .eraseToAnyPublisher()
            }
            return self.persistKeysorePublisher(of: wallet)
        }
        .flatMap { [walletLocalRepository] wallet -> AnyPublisher<Void, Never> in
            guard let wallet = wallet else {
                return Just(())
                    .eraseToAnyPublisher()
            }
            return walletLocalRepository.saveWalletPublisher(wallet)
        }
        .sink(
            receiveCompletion: { [walletLocalRepository] result in
                print("\n\n\nIn createHDWallet()\n")
                dump(result)
                walletLocalRepository.notifyErrorOccured()
            },
            receiveValue: { [walletLocalRepository] _ in
                walletLocalRepository.notifyWalletCreated()
            }
        )
        .store(in: &cancellables)
    }
    
    func importWallet(mnemonics: [String], password: String) -> Void {
        Deferred {
            Future<WalletInstance, WalletError> { completion in
                do {
                    let mnemonicsString = mnemonics.joined(separator: " ")
                    if let keystore = try BIP32Keystore(mnemonics: mnemonicsString, password: password, mnemonicsPassword: ""),
                       let address = keystore.addresses?.first?.address,
                       let keydata = try? JSONEncoder().encode(keystore.keystoreParams),
                       self.storeMnemonicsInKeychain(forKey: address, mnemonicsString) {
                        completion(.success(
                            .init(
                                address: address,
                                keyData: keydata,
                                name: nil,
                                type: .hd(mnemonics: mnemonics)
                            )
                        ))
                    } else {
                        completion(.failure(.importError("Could not import wallet")))
                    }
                } catch let error {
                    completion(.failure(.importError("Could not create wallet: \(error.localizedDescription)")))
                }
                    
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
        .flatMap { [weak self] wallet -> AnyPublisher<WalletInstance?, WalletError> in
            guard let self = self else {
                return Just(nil)
                    .setFailureType(to: WalletError.self)
                    .eraseToAnyPublisher()
            }
            return self.persistKeysorePublisher(of: wallet)
        }
        .flatMap { [walletLocalRepository] wallet -> AnyPublisher<Void, Never> in
            guard let wallet = wallet else {
                return Just(())
                    .eraseToAnyPublisher()
            }
            return walletLocalRepository.saveWalletPublisher(wallet)
        }
        .sink(
            receiveCompletion: { [walletLocalRepository] result in
                print("\n\n\nIn importWallet()\n")
                dump(result)
                walletLocalRepository.notifyErrorOccured()
            },
            receiveValue: { [walletLocalRepository] _ in
                walletLocalRepository.notifyWalletCreated()
            }
        )
        .store(in: &cancellables)
    }
    
    func initializeExistingWallet() -> Void {
        Deferred {
            Future<WalletInstance, WalletError> { [weak self] completion in
                if let keystoreManager = self?.keystoreManagerFromDirectory(),
                   let keystore = self?.fetchWallet(using: keystoreManager),
                   let address = keystore.addresses?.first?.address,
                   let keydata = try? JSONEncoder().encode(keystore.keystoreParams),
                   let mnemonics = self?.fetchMnemonicsFromKeychain(usingKey: address) {
                    completion(
                        .success(
                            .init(
                                address: address,
                                keyData: keydata,
                                name: nil,
                                type: .hd(mnemonics: mnemonics)
                            )
                    ))
                } else {
                    completion(.failure(.importError("Could not initialize wallet")))
                }
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
        .flatMap {
            self.walletLocalRepository.saveWalletPublisher($0)
        }
        .sink(
            receiveCompletion: { [walletLocalRepository] result in
                print("\n\n\nIn initializeExistingWallet()\n")
                dump(result)
                walletLocalRepository.notifyErrorOccured()
            },
            receiveValue: { [walletLocalRepository] _ in
                walletLocalRepository.notifyWalletCreated()
            }
        )
        .store(in: &cancellables)
    }
    
    //MARK: Send ETH + Get balance
    func getETHBalance() -> Void {
        walletPublisher
            .map { [weak self] wallet -> AnyPublisher<String, WalletError> in
                if let self = self,
                   let wallet = wallet,
                   let walletAdddress = EthereumAddress(wallet.address) {
                    self.provider.addKeystoreManager(self.keystoreManagerFromDirectory())
                    do {
                        /*
                         
                         !!! async called in non async environment problem here
                         
                        let balance = try self.provider.eth.getBalance(for: walletAdddress)
                        return Just(
                            Utilities.formatToPrecision(balance, units: .ether, formattingDecimals: 3)
                        )
                        .setFailureType(to: WalletError.self)
                        .eraseToAnyPublisher()
                         */
                        return Just("100")
                            .setFailureType(to: WalletError.self)
                            .eraseToAnyPublisher()
                    } /*catch let error {
                        return Fail(
                            outputType: String.self,
                            failure: WalletError.networkError("getETHBalance(): Could not fetch balance for wallet \(error)")
                        )
                        .eraseToAnyPublisher()
                    }
                    */
                } else {
                    return Fail(
                        outputType: String.self,
                        failure: WalletError.networkError("getETHBalance(): Could not fetch balance for wallet")
                    )
                    .eraseToAnyPublisher()
                }
            }
            .sink { balance in
                dump(balance)
            }
            .store(in: &cancellables)
    }
    
    func sendETH() -> Void{
        /*
          TODO: Implement
         */
    }
    
    //MARK: Private methods
    private func persistKeysorePublisher(of wallet: WalletInstance) -> AnyPublisher<WalletInstance?, WalletError> {
        Deferred { [documentsDirectory] in
            Future<WalletInstance?, WalletError> { completion in
                do {
                    let pathURL = documentsDirectory.appending(component: "WWKeydata.json")
                    try wallet.keyData.write(to: pathURL, options: [.atomic, .completeFileProtection])
                    if FileManager.default.fileExists(atPath: pathURL.path()) {
                        completion(.success(wallet))
                    } else {
                        completion(.failure(.persistError("In persistKeysore(of wallet: WalletInstance) can't persist keystore")))
                    }
                } catch let error {
                    completion(.failure(.persistError("In persistKeysore(keydata: Data) \(error.localizedDescription)")))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func keystoreManagerFromDirectory() -> KeystoreManager? {
        return KeystoreManager.managerForPath(
            documentsDirectory.path(),
            scanForHDwallets: true
        )
    }
    
    private func fetchWallet(using keystoreManager: KeystoreManager) -> BIP32Keystore? {
        guard let a = keystoreManager.addresses, let f = a.first else { return nil }
        return keystoreManager.walletForAddress(f) as? BIP32Keystore
    }
    
    private func fetchMnemonicsFromKeychain(usingKey key: String) -> [String]? {
        KeychainHelper.fetchMnemonicsFromKeychain(usingKey: key)
    }
    
    private func storeMnemonicsInKeychain(forKey key: String, _ mnemonics: String) -> Bool {
        let splitMenmonics = mnemonics.split(separator: " ").map(String.init)
        return KeychainHelper.storeMnemonicsInKeychain(forKey: key, mnemonics: splitMenmonics)
    }
}
