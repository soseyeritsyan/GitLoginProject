//
//  KeychainService.swift
//  GitLoginProject
//
//  Created by sose yeritsyan on 19.01.26.
//

import Foundation

final class KeychainService {
    
    func save<T: Codable>(_ item: T, key: String) {
        let data = try! JSONEncoder().encode(item)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
        
    }
    
    
    func read(key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var data: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &data)
        return data as? Data
        
    }
    
    
    func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        SecItemDelete(query as CFDictionary)
    }
    
}

