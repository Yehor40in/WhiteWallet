//
//  ImportWalletViewModelProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 21.07.24.
//

import Foundation

protocol ImportWalletViewModelProtocol: ObservableObject {
    var hasActivity: Bool { get set }
    var shouldEnterRecoveryPhrase: Bool { get set }
    var mnemonic: Array<String> { get set }
    var password: String { get set }
    
    func onImportWallet() -> Void
}
