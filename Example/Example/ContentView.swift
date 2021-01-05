//
//  ContentView.swift
//  Example
//
//  Created by Laurin Brandner on 05.01.21.
//

import SwiftUI
import StackNavigationView

struct ContentView: View {
    
    @State private var selection: Int? = 0
    
    var body: some View {
        
        return StackNavigationView(selection: $selection) {
            List {
                SidebarNavigationLink("Apples", destination: rootView(title: "Apples"), tag: 0, selection: $selection)
                SidebarNavigationLink("Bananas", destination: rootView(title: "Bananas"), tag: 1, selection: $selection)
                SidebarNavigationLink("Clementines", destination: rootView(title: "Clementines"), tag: 2, selection: $selection)
            }
            Text("Empty Selection")
        }
    }
    
    @ViewBuilder private func rootView(title: String) -> some View {
        VStack {
            Text("This is the root view of \(title)")
                .font(.system(size: 50))
                .bold()
            Spacer()
                .frame(height: 40)
            StackNavigationLink(destination: ChildView(sidebar: title, level: 1)) {
                Text("Next")
            }
        }
        .navigationTitle(title)
    }
}
