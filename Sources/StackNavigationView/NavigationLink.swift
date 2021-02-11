//
//  NavigationLink.swift
//  
//
//  Created by Laurin Brandner on 02.01.21.
//

import SwiftUI

public struct SidebarNavigationLink<Label, Destination, V: Hashable> : View where Label : View, Destination : View {
    
    var label: String
    var destination: Destination
    var tag: V?
    var selection: Binding<V?>?
    
    @Environment(\.push) private var push
    
    public var body: some View {
        if let tag = tag, let selection = selection {
            let binding = Binding<V?>(get: { selection.wrappedValue }, set: { _ in
                push(AnyView(destination), tag)
            })
            
            NavigationLink(label, destination: CurrentView(defaultView: destination), tag: tag, selection: binding)
        }
    }

    /// Creates an instance that presents `destination`.
//    public init(destination: Destination, @ViewBuilder label: @escaping () -> Label) where V == Int {
//        self.label = label
//        self.destination = destination
//    }
//
//    public init(destination: Destination, isActive: Binding<Bool>, @ViewBuilder label: @escaping () -> Label) {
//        self.label = label
//        self.destination = destination
//    }
//
//    /// Creates an instance that presents `destination` when `selection` is set
//    /// to `tag`.
//    public init<V>(destination: Destination, tag: V, selection: Binding<V?>, @ViewBuilder label: @escaping () -> Label) where V : Hashable {
//        self.label = label
//        self.destination = destination
//    }
    
}

extension SidebarNavigationLink where Label == Text {
    
//    /// Creates an instance that presents `destination`, with a `Text` label
//    /// generated from a title string.
//    public init(_ titleKey: LocalizedStringKey, destination: Destination)
//
//    /// Creates an instance that presents `destination`, with a `Text` label
//    /// generated from a title string.
//    public init<S>(_ title: S, destination: Destination) where S : StringProtocol
//
//    /// Creates an instance that presents `destination` when active, with a
//    /// `Text` label generated from a title string.
//    public init(_ titleKey: LocalizedStringKey, destination: Destination, isActive: Binding<Bool>)
//
//    /// Creates an instance that presents `destination` when active, with a
//    /// `Text` label generated from a title string.
//    public init<S>(_ title: S, destination: Destination, isActive: Binding<Bool>) where S : StringProtocol
//
//    /// Creates an instance that presents `destination` when `selection` is set
//    /// to `tag`, with a `Text` label generated from a title string.
//    public init<V>(_ titleKey: LocalizedStringKey, destination: Destination, tag: V, selection: Binding<V?>) where V : Hashable

    /// Creates an instance that presents `destination` when `selection` is set
    /// to `tag`, with a `Text` label generated from a title string.
    public init<S>(_ title: S, destination: Destination, tag: V, selection: Binding<V?>) where S : StringProtocol {
        self.label = String(title)
        self.destination = destination
        self.tag = tag
        self.selection = selection
    }
    
}

public struct StackNavigationLink<Label: View, Destination: View>: View {
    
    private var label: Label
    private var destination: Destination
    private var wrapInButton = false
    
    @Environment(\.push) private var push
    
    public var body: some View {
        let action = {
            self.push(AnyView(destination), nil)
        }
        
        if wrapInButton {
            Button(action: action, label: { label })
        }
        else {
            label.onTapGesture(perform: action)
        }
    }

    /// Creates an instance that presents `destination`.
    public init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.label = label()
        self.destination = destination
    }
//
//    public init(destination: Destination, isActive: Binding<Bool>, @ViewBuilder label: @escaping () -> Label) {
//        self.label = label
//        self.destination = destination
//    }
//
//    /// Creates an instance that presents `destination` when `selection` is set
//    /// to `tag`.
//    public init<V>(destination: Destination, tag: V, selection: Binding<V?>, @ViewBuilder label: @escaping () -> Label) where V : Hashable {
//        self.label = label
//        self.destination = destination
//    }
    
}

extension StackNavigationLink where Label == Text {
    
//    /// Creates an instance that presents `destination`, with a `Text` label
//    /// generated from a title string.
//    public init(_ titleKey: LocalizedStringKey, destination: Destination)
//
//    /// Creates an instance that presents `destination`, with a `Text` label
//    /// generated from a title string.
//    public init<S>(_ title: S, destination: Destination) where S : StringProtocol
//
//    /// Creates an instance that presents `destination` when active, with a
//    /// `Text` label generated from a title string.
//    public init(_ titleKey: LocalizedStringKey, destination: Destination, isActive: Binding<Bool>)
//
//    /// Creates an instance that presents `destination` when active, with a
//    /// `Text` label generated from a title string.
//    public init<S>(_ title: S, destination: Destination, isActive: Binding<Bool>) where S : StringProtocol
//
//    /// Creates an instance that presents `destination` when `selection` is set
//    /// to `tag`, with a `Text` label generated from a title string.
//    public init<V>(_ titleKey: LocalizedStringKey, destination: Destination, tag: V, selection: Binding<V?>) where V : Hashable

    /// Creates an instance that presents `destination` when `selection` is set
    /// to `tag`, with a `Text` label generated from a title string.
    public init<S>(_ title: S, destination: Destination) where S : StringProtocol {
        self.label = Text(title)
        self.destination = destination
        self.wrapInButton = true
    }
    
}
