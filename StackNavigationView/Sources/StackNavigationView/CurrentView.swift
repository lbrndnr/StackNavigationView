//
//  CurrentView.swift
//  
//
//  Created by Laurin Brandner on 02.01.21.
//

import SwiftUI

struct CurrentView: View {
    
    var body: some View { currentView ?? defaultView }
    
    @Environment(\.currentView) private var currentView: AnyView?
    private var defaultView: AnyView
    
    init(defaultView: AnyView) {
        self.defaultView = defaultView
    }
    
}
