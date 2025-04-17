//
//  WalletInstance.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 06.07.24.
//

import Foundation
import web3swift
import Web3Core

struct WalletInstance: Hashable {
    enum WalletType: Hashable {
        case normal
        case hd(mnemonics: [String])
    }
    
    let address: String
    let keyData: Data
    let name: String?
    let type: WalletType
}
