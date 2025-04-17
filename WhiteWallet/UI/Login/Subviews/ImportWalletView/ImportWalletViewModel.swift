//
//  ImportWalletViewModel.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 21.07.24.
//

/*
 TODO:
    - handle error
 */

import Foundation
import Combine

final class ImportWalletViewModel: ImportWalletViewModelProtocol {
    @Published var hasActivity: Bool = false
    @Published var shouldEnterRecoveryPhrase: Bool = false
    @Published var mnemonic: Array<String> = ["", "", "", "","", "", "", "","", "", "", ""]
    @Published var password: String = ""
    
    private var cancellables: [AnyCancellable] = []
    
    private let w3coordinator: Web3CoordinatorProtocol
    
    init(w3coordinator: Web3CoordinatorProtocol) {
        self.w3coordinator = w3coordinator
        
        setupSubscriptions()
    }
    
    private func setupSubscriptions() -> Void {
        w3coordinator
            .walletPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] wallet in
                guard let self = self, let wallet = wallet else {
                    print("Something went wrong. In sink(receiveValue: {})")
                    return
                }
                self.handleResult(wallet)
            })
            .store(in: &cancellables)
        
    }
    
    func onImportWallet() -> Void {
        hasActivity = true
        w3coordinator.importWallet(mnemonics: mnemonic, password: password)
    }
    
    private func handleResult(_ wallet: WalletInstance) -> Void {
        switch wallet.type {
        case .normal:
            dump(wallet)
        case let .hd(mnemonics: mnemonics):
            dump(wallet) // For testing purposes. To be removed
            /*
             TODO - implement logic
             */
        }
        hasActivity = false
    }
}
