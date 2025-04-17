//
//  LoginViewModelProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 05.07.24.
//

import Foundation
import web3swift
import Web3Core

enum LoginViewModelActionType {
    case creatingWallet
    case importingWallet
}

protocol LoginViewModelProtocol: ObservableObject {
    var hasActivity: Bool { get set }
    var actionType: LoginViewModelActionType? { get }
    var showsWalletSetupSheet: Bool { get set }
    var shouldShowErrorMessage: Bool { get set }
    var shouldTryFetchingWallet: Bool { get set }
    var password: String { get set }
    var mnemonic: [String] { get set }
    
    func onInitExisitngWallet() -> Void
    func showSheet(_ state: LoginViewModelActionType) -> Void
}
