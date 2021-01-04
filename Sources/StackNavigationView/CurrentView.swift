//
//  CurrentView.swift
//  
//
//  Created by Laurin Brandner on 02.01.21.
//

import SwiftUI

struct CurrentView: View {
    
    @Environment(\.currentView) private var currentView: AnyView?
    @Environment(\.modalView) private var modalView: AnyView?
    
    private var defaultView: AnyView
    
    var body: some View { modalView ?? currentView ?? defaultView }
    
    init<Content: View>(defaultView: Content) {
        self.defaultView = AnyView(defaultView)
    }
    
}
