//
//  AppDisplayable.swift
//  ZamzamKit iOS
//
//  Created by Basem Emara on 2018-02-04.
//  Copyright © 2018 Zamzam Inc. All rights reserved.
//

import UIKit

/// Super displayer for implementing global extensions.
public protocol AppDisplayable {
    
    /// Display error details.
    ///
    /// - Parameter error: The error details to present.
    func display(error: AppModels.Error)
    
    /// Hides spinners, loaders, and anything else
    func endRefreshing()
}

#if os(iOS)
extension AppDisplayable where Self: UIViewController {
    
    /// Display a native alert controller modally.
    ///
    /// - Parameter error: The error details to present.
    public func display(error: AppModels.Error) {
        endRefreshing()
        present(alert: error.title, message: error.message)
    }
}
#endif
