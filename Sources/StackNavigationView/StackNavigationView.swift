//
//  StackNavigationLink.swift
//
//
//  Created by Laurin Brandner on 02.01.21.
//

import SwiftUI
import Combine

public struct StackNavigationView<V: Hashable, Content: View>: View {
    
    private var content: () -> Content
    
    @State private var pushed: [(AnyView?, V?)]
    @State private var popped = [(AnyView?, V?)]()
    
    private var canGoBack: Bool { pushed.count > 1 }
    private var canGoForward: Bool { popped.count > 0 }
    private var selection: Binding<V?>?
    
    public var body: some View {
        return NavigationView(content: content)
            .environment(\.push, push)
            .environment(\.currentView, pushed.last?.0)
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button(action: goBack, label: {
                        Image(systemName: "chevron.left")
                    })
                    .disabled(!canGoBack)
                }
                ToolbarItem(placement: .navigation) {
                    Button(action: goForward, label: {
                        Image(systemName: "chevron.right")
                    })
                    .disabled(!canGoForward)
                }
            }
    }
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self._pushed = State(initialValue: [])
    }
    
    public init(selection: Binding<V?>, @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.selection = selection
        self._pushed = State(initialValue: [(nil, selection.wrappedValue)])
    }
    
    private func push(_ content: AnyView, tag: Any?) {
        guard let tag = tag as? V? else { preconditionFailure() }
        pushed.append((content, tag))
        popped.removeAll()
        if let tag = tag {
            selection?.wrappedValue = tag
        }
    }
    
    private func goBack() {
        guard let (content, tag) = pushed.popLast() else { preconditionFailure() }
        popped.append((content, tag))
        if let tag = pushed.last?.1 {
            selection?.wrappedValue = tag
        }
    }
    
    private func goForward() {
        guard let (content, tag) = popped.popLast() else { preconditionFailure() }
        pushed.append((content, tag))
        if let tag = tag {
            selection?.wrappedValue = tag
        }
    }
    
}
