//
//  ChildView.swift
//  Example
//
//  Created by Laurin Brandner on 05.01.21.
//

import SwiftUI
import StackNavigationView

struct ChildView: View {
    
    private var sidebar: String
    private var level: Int
    
    var body: some View {
        VStack {
            Text("This is level \(level) in \(sidebar)")
                .font(.system(size: 50))
                .bold()
            Text("Hit next to proceed to level \(level+1)")
                .font(.system(size: 20))
            Spacer()
                .frame(height: 40)
            StackNavigationLink(destination: ChildView(sidebar: sidebar, level: level+1)) {
                Text("Next")
            }
        }
        .padding(20)
        .navigationTitle("Detail \(level)")
    }
    
    init(sidebar: String, level: Int) {
        self.sidebar = sidebar
        self.level = level
    }
    
}

struct ChildView_Previews: PreviewProvider {
    static var previews: some View {
        ChildView(sidebar: "AAA", level: 3)
    }
}

