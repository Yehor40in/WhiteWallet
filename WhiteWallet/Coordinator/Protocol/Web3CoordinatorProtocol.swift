//
//  Web3CoordinatorProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 05.07.24.
//

import Foundation
import web3swift
import Web3Core
import Combine

protocol Web3CoordinatorProtocol {
    var provider: Web3 { get }
    var walletPublisher: AnyPublisher<WalletInstance?, Never> { get }
    var walletEventPublisher: AnyPublisher<Void, Never> { get }
    var walletErrortPublisher: AnyPublisher<Void, Never> { get }
    
    func createHDWallet(with password: String) -> Void
    func importWallet(mnemonics: [String], password: String) -> Void
    func initializeExistingWallet() -> Void
    
    func getETHBalance() -> Void
    func sendETH() -> Void
}
