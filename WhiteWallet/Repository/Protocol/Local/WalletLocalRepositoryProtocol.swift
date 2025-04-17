//
//  WalletLocalRepositoryProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 06.07.24.
//

import Foundation
import Combine
import web3swift
import Web3Core

protocol WalletLocalRepositoryProtocol {
    var walletSubject: CurrentValueSubject<WalletInstance?, Never> { get }
    var walletCreatedEventSubject: PassthroughSubject<Void, Never> { get }
    var walletErrorEventSubject: PassthroughSubject<Void, Never> { get }
    
    func saveWalletPublisher(_ wallet: WalletInstance) -> AnyPublisher<Void, Never>
    
    func notifyWalletCreated() -> Void
    func notifyErrorOccured() -> Void
}
