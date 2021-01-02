//
//  Environment.swift
//  
//
//  Created by Laurin Brandner on 02.01.21.
//

import SwiftUI

struct CurrentViewKey: EnvironmentKey {
    
    static let defaultValue: AnyView? = nil
    
}

typealias Push = (AnyView, Any?) -> ()
struct PushKey: EnvironmentKey {
    
    static let defaultValue: Push = { _, _ in }
    
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
    
}
