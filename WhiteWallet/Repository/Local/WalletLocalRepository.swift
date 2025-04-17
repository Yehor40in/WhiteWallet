//
//  WalletLocalRepository.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 06.07.24.
//

import Foundation
import Combine
import web3swift
import Web3Core

struct WalletLocalRepository: WalletLocalRepositoryProtocol {
    var walletCreatedEventSubject: PassthroughSubject<Void, Never> = .init()
    var walletErrorEventSubject: PassthroughSubject<Void, Never> = .init()
    var walletSubject: CurrentValueSubject<WalletInstance?, Never> = .init(nil)
    
    func saveWalletPublisher(_ wallet: WalletInstance) -> AnyPublisher<Void, Never> {
        Deferred {
            Future { completion in
                walletSubject.value = wallet
                completion(.success(()))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func notifyWalletCreated() -> Void {
        walletCreatedEventSubject.send()
    }
    
    func notifyErrorOccured() -> Void {
        walletErrorEventSubject.send()
    }
}

extension Web3Coordinator {
    var walletPublisher: AnyPublisher<WalletInstance?, Never> {
        walletLocalRepository
            .walletSubject
            .eraseToAnyPublisher()
    }
    
    var walletEventPublisher: AnyPublisher<Void, Never> {
        walletLocalRepository
            .walletCreatedEventSubject
            .eraseToAnyPublisher()
    }
    
    var walletErrortPublisher: AnyPublisher<Void, Never> {
        walletLocalRepository
            .walletErrorEventSubject
            .eraseToAnyPublisher()
    }
}
