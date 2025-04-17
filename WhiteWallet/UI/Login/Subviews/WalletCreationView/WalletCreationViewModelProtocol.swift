//
//  WalletCreationViewModelProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 21.07.24.
//

import Foundation

protocol WalletCreationViewModelProtocol: ObservableObject {
    var hasActivity: Bool { get set }
    var shouldDisplayRecoveryPhrase: Bool { get set }
    var isRecoveryPhraseSaved: Bool { get set }
    var password: String { get set }
    var passwordToVerify: String { get set }
    var shoudVerifyPassword: Bool { get set }
    var mnemonics: Array<String> { get set }
    var expectedMnemonics: Array<String> { get }
    
    func onPasswordVerify() -> Void
    func goToVerifyPassword() -> Void
}
