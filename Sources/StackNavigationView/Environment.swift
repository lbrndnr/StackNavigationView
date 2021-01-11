//
//  Environment.swift
//  
//
//  Created by Laurin Brandner on 02.01.21.
//

import SwiftUI

typealias Push = (AnyView, Any?) -> ()
struct PushKey: EnvironmentKey {
    
    static let defaultValue: Push = { _, _ in }
    
}

struct CurrentViewKey: EnvironmentKey {
    
    static let defaultValue: AnyView? = nil
    
}

struct ModalViewKey: EnvironmentKey {
    
    static let defaultValue: ModalView? = nil
    
}

extension EnvironmentValues {
    
    var push: Push {
        get { self[PushKey.self] }
        set { self[PushKey.self] = newValue }
    }
    
    var currentView: AnyView? {
        get { self[CurrentViewKey.self] }
        set { self[CurrentViewKey.self] = newValue }
    }
    
    var modalView: ModalView? {
        get { self[ModalViewKey.self] }
        set { self[ModalViewKey.self] = newValue }
    }
    
}
