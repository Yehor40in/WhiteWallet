//
//  Web3Coordinator+Factory.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 06.07.24.
//

import Foundation

extension Container {
    func createWeb3Coordinator() -> Web3CoordinatorProtocol {
        Web3Coordinator.shared
    }
}
