//
//  StackNavigationLink.swift
//
//
//  Created by Laurin Brandner on 02.01.21.
//

import SwiftUI
import Combine

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

public struct StackNavigationView<V: Hashable, C1: View, C2: View>: View {
    
    private var content: () -> TupleView<(C1, C2)>
    
    @State private var pushed: [(AnyView?, V?)]
    @State private var popped = [(AnyView?, V?)]()
    
    var canGoBack: Bool { pushed.count > 1 }
    var canGoForward: Bool { popped.count > 0 }
    var selection: Binding<V?>?
    
    public var body: some View {
        let subviews = content().value
        
        return NavigationView {
            subviews.0
            subviews.1
        }
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
    
    public init(@ViewBuilder content: @escaping () -> TupleView<(C1, C2)>) {
        self.content = content
        self._pushed = State(initialValue: [])
    }
    
    public init(selection: Binding<V?>, @ViewBuilder content: @escaping () -> TupleView<(C1, C2)>) {
        self.content = content
        self.selection = selection
        self._pushed = State(initialValue: [(nil, selection.wrappedValue)])
    }
    
//    public init(@ViewBuilder content: @escaping () -> C1) where C2 == EmptyView {
//        self.content = { TupleView((content(), EmptyView())) }
//    }
    
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
