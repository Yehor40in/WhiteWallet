//
//  Route.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 06.07.24.
//

import Foundation

enum Route: Hashable {
    case login
    case home
    case setupPassword
    case createWallet
    case importWallet
    case verifyMnemonics
    case transaction
    case portfolio
    case assetOverview
    case settings
}
