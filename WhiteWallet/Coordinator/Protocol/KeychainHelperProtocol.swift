//
//  KeychainHelperProtocol.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 17.07.24.
//

import Foundation


protocol KeychainHelperProtocol {
    static func save(key: String, data: Data) -> OSStatus
    static func load(key: String) -> Data?
}
