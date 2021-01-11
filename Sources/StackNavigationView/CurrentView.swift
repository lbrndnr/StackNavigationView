//
//  CurrentView.swift
//  
//
//  Created by Laurin Brandner on 02.01.21.
//

import SwiftUI

struct CurrentView: View {
    
    @Environment(\.currentView) private var currentView: AnyView?
    
    private var defaultView: AnyView
    
    var body: some View { currentView ?? defaultView }
    
    init<Content: View>(defaultView: Content) {
        self.defaultView = AnyView(defaultView)
    }
    
}
