//
//  KeychainHelper.swift
//  KeychainExample
//
//  Created by JULIAN OSORIO RAMIREZ on 26/12/24.
//

import Foundation
import Security

class KeychainHelper {

    static let shared = KeychainHelper()

    // MARK: - Save Data
    func save(key: String, value: String) -> Bool {
        if let data = value.data(using: .utf8) {
            let query: [CFString: Any] = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data
            ]

            // Delete any existing item before saving the new one
            SecItemDelete(query as CFDictionary)

            // Add new item to Keychain
            let status = SecItemAdd(query as CFDictionary, nil)
            return status == errSecSuccess
        }
        return false
    }

    // MARK: - Retrieve Data
    func retrieve(key: String) -> String? {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecSuccess, let data = result as? Data, let value = String(data: data, encoding: .utf8) {
            return value
        }

        return nil
    }

    // MARK: - Delete Data
    func delete(key: String) -> Bool {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}

