//
//  NotificationCenter+Listener.swift
//  KeyboardDismissalHandler
//
//  Created by Kevin Ladan on 8/15/24.
//

import UIKit
import Foundation
import Combine

extension NotificationCenter {
    @MainActor func single(_ observer: Any, _ name: Notification.Name, object: AnyObject? = nil, completion: @escaping () -> Void) {
        var cancellable: AnyCancellable? = nil
        cancellable = NotificationCenter.default
            .publisher(for: name, object: object)
            .sink { notification in
                cancellable?.cancel()
                completion()
            }
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
