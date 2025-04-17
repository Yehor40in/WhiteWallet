//
//  WalletCreationViewModel.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 21.07.24.
//

import Foundation
import Combine

/*
 TODO
    - Implement verify mnemonics logic + WalletLocalRepository.notifyWalletCreated
 */

final class WalletCreationViewModel: WalletCreationViewModelProtocol {
    @Published var hasActivity: Bool = false
    @Published var shouldDisplayRecoveryPhrase: Bool = false
    @Published var isRecoveryPhraseSaved: Bool = false
    @Published var password: String = ""
    @Published var passwordToVerify: String = ""
    @Published var shoudVerifyPassword: Bool = false
    @Published var mnemonics: Array<String> = []
    
    var expectedMnemonics: Array<String> = []
    
    private let w3coordinator: Web3CoordinatorProtocol
    private var cancellables: Array<AnyCancellable> = []
    
    init(w3coordinator: Web3CoordinatorProtocol) {
        self.w3coordinator = w3coordinator
        setupSubscriptions()
    }
    
    func setupSubscriptions() -> Void {
        w3coordinator
            .walletPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] wallet in
                guard let wallet = wallet, let self = self else {
                    print("Something went wrong. In sink(receiveValue: {})")
                    return
                }
                self.resultHandler(wallet)
            })
            .store(in: &cancellables)
    }
    
    private func onCreateWallet() -> Void {
        w3coordinator.createHDWallet(with: password)
    }
    
    private func resultHandler(_ wallet: WalletInstance) -> Void {
        switch wallet.type {
        case .normal:
            dump(wallet)
        case .hd(let mnemonics):
            dump(wallet) // For testing purposes. To be removed
            expectedMnemonics = mnemonics
            shouldDisplayRecoveryPhrase = true
        }
        hasActivity = false
    }
    
    func onPasswordVerify() {
        if password == passwordToVerify {
            hasActivity = true
            onCreateWallet()
        }
    }
    
    func goToVerifyPassword() {
        shoudVerifyPassword = true
    }
}
