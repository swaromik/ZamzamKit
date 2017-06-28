//
//  Localizable.swift
//  ZamzamKit
//
//  Created by Basem Emara on 6/27/17.
//  Copyright © 2017 Zamzam. All rights reserved.
//

import Foundation

public struct Localizable {
    fileprivate let contents: String
    
    fileprivate init(_ value: String) {
        self.contents = value
    }
}

public extension Localizable {
    static let pullToRefresh = Localizable(NSLocalizedString("Pull to refresh", comment: "For tables"))
    static let ok = Localizable(NSLocalizedString("OK", comment: "For dialogs"))
    static let cancel = Localizable(NSLocalizedString("Cancel", comment: "For dialogs"))
}

public extension String {
    
    /// A string initialized by using format as a template into which values in argList are substituted according the current locale information.
    private static var vaListHandler: (_ key: String, _ arguments: CVaListPointer, _ locale: Locale?) -> String {
        // https://stackoverflow.com/questions/42428504/swift-3-issue-with-cvararg-being-passed-multiple-times
        return { return NSString(format: $0.0, locale: $0.2, arguments: $0.1) as String }
    }

    /// Returns a localized string.
    static func localized(_ key: Localizable) -> String {
        return key.contents
    }

    /// Returns a string created by using a given format string as a template into which the remaining argument values are substituted.
    static func localizedFormat(_ key: Localizable, _ arguments: CVarArg...) -> String {
        return withVaList(arguments) { vaListHandler(key.contents, $0, nil) } as String
    }

    /// Returns a string created by using a given format string as a template into which the
    /// remaining argument values are substituted according to the user’s default locale.
    static func localizedLocale(_ key: Localizable, _ arguments: CVarArg...) -> String {
        return withVaList(arguments) { vaListHandler(key.contents, $0, .current) } as String
    }
}
