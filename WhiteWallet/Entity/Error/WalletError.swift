//
//  WalletError.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 06.07.24.
//

import Foundation

enum WalletError: Error {
    case creationError(String)
    case persistError(String)
    case importError(String)
    case networkError(String)
}
