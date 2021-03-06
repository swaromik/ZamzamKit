//
//  Preferences.swift
//  ZamzamKit
//
//  Created by Basem Emara on 2019-05-09.
//  Copyright © 2019 Zamzam Inc. All rights reserved.
//

public struct Preferences: PreferencesType {
    private let store: PreferencesStore
    
    public init(store: PreferencesStore) {
        self.store = store
    }
}

public extension Preferences {
    
    /// Retrieves the value from user defaults that corresponds to the given key.
    ///
    /// - Parameter key: The key that is used to read the user defaults item.
    func get<T>(_ key: UserDefaults.Key<T?>) -> T? {
        return store.get(key)
    }
    
    /// Stores the value in the user defaults item under the given key.
    ///
    /// - Parameters:
    ///   - value: Value to be written to the user defaults.
    ///   - key: Key under which the value is stored in the user defaults.
    func set<T>(_ value: T?, forKey key: UserDefaults.Key<T?>) {
        store.set(value, forKey: key)
    }
    
    /// Deletes the single user defaults item specified by the key.
    ///
    /// - Parameter key: The key that is used to delete the user default item.
    /// - Returns: True if the item was successfully deleted.
    func remove<T>(_ key: UserDefaults.Key<T?>) {
        store.remove(key)
    }
}
