//
//  KeyboardDismissalHandler.swift
//  KeyboardDismissalHandler
//
//  Created by Kevin Ladan on 10/22/24.
//

import Foundation
import SwiftUI

@MainActor fileprivate var isResponderEnabled = true

public struct KeyboardDismissalHandler<Content: View>: View {
    private var content: (_ dismissKeyboard: @escaping (Any, @escaping () -> Void) -> Void, _ isResponderEnabled: @escaping () -> Bool) -> Content
    
    private let _dismissKeyboard: (Any, @escaping () -> Void) -> Void = { observer, block in
        isResponderEnabled = false
        NotificationCenter.default.single(observer, UIResponder.keyboardDidHideNotification, completion: block)
    }
    private let _isResponderEnabled: () -> Bool = { isResponderEnabled }
    
    public init(content: @escaping (_: @escaping (Any, @escaping () -> Void) -> Void, _: @escaping () -> Bool) -> Content) {
        self.content = content
    }
    
    public var body: some View {
        self.content(self._dismissKeyboard, self._isResponderEnabled)
            .onAppear { isResponderEnabled = true }
            .onDisappear { isResponderEnabled = false }
    }
}
