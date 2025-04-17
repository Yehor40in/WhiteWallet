//
//  KeychainHelper.swift
//  WhiteWallet
//
//  Created by Yehor Sorochin on 17.07.24.
//
import Security
import Foundation

class KeychainHelper: KeychainHelperProtocol {

    static func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String       : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String   : data ] as [String : Any]

        SecItemDelete(query as CFDictionary)

        return SecItemAdd(query as CFDictionary, nil)
    }

    static func load(key: String) -> Data? {
        let query = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String  : kCFBooleanTrue!,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef: AnyObject? = nil

        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == noErr {
            return dataTypeRef as! Data?
        } else {
            return nil
        }
    }

    static func createUniqueID() -> String {
        let uuid: CFUUID = CFUUIDCreate(nil)
        let cfStr: CFString = CFUUIDCreateString(nil, uuid)

        let swiftString: String = cfStr as String
        return swiftString
    }
}

extension KeychainHelper {
    static func storeMnemonicsInKeychain(forKey key: String, mnemonics: [String]) -> Bool {
        let data = Data(from: mnemonics)
        return KeychainHelper.save(key: key, data: data) == errSecSuccess 
    }
    
    static func fetchMnemonicsFromKeychain(usingKey key: String) -> [String]? {
        if let data = KeychainHelper.load(key: key) {
            return data.to(type: [String].self)
        }
        return nil
    }
}

extension Data {

    init<T>(from value: T) {
        var value = value
        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        self.withUnsafeBytes { $0.load(as: T.self) }
    }
}
