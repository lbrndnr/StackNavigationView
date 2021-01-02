//
//  ContentView.swift
//  Example
//
//  Created by Laurin Brandner on 02.01.21.
//

import SwiftUI
import StackNavigationView

struct ContentView: View {
    
    @State private var selection: Int? = 0
    
    var body: some View {
        func contentView(title: String) -> some View {
            VStack {
                Text("This is the root view")
                StackNavigationLink(destination: NextContentView(level: 1)) {
                    Text("next")
                }
            }
            .navigationTitle(title)
        }
        
        return StackNavigationView(selection: $selection) {
            List {
                SidebarNavigationLink("haha", destination: contentView(title: "haha"), tag: 0, selection: $selection)
                SidebarNavigationLink("hehe", destination: contentView(title: "hehe"), tag: 1, selection: $selection)
                SidebarNavigationLink("hihi", destination: contentView(title: "hihi"), tag: 2, selection: $selection)
            }
            Text("Empty Selection")
        }
    }
}

struct NextContentView: View {
    
    private var level: Int
    
    var body: some View {
        VStack {
            Text("This is the detail \(level)")
            StackNavigationLink(destination: NextContentView(level: level+1)) {
                Text("next")
            }
        }
        .navigationTitle("Detail \(level)")
    }
    
    init(level: Int) {
        self.level = level
    }
    
}
