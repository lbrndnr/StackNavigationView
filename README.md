# StackNavigationView

[![Twitter: @lbrndnr](https://img.shields.io/badge/contact-@lbrndnr-blue.svg?style=flat)](https://twitter.com/lbrndnr)
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/lbrndnr/StackNavigationView/blob/master/LICENSE)

## About
As of SwiftUI v2, `NavigationView` only supports a simple sidebar selection. This makes it impossible to push new views onto the view hierarchy, as one could do e.g. with `UINavigationController`. This project is a workaround that builds upon `NavigationView` to support complex view hierarchies.

![Demo](https://raw.githubusercontent.com/lbrndnr/StackNavigationView/master/demo.gif)

## Usage
The interface of `StackNavigationView` is very similar to the one of `NavigationView`, just make sure not to use `NavigationLink` inside of `StackNavigationView` though, it will result in undefined behaviour. You'll find the full example [here](https://github.com/lbrndnr/StackNavigationView/tree/master/Example/Example). 

```swift
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
    .frame(minWidth: 600, minHeight: 400)
}

@ViewBuilder private func rootView(title: String) -> some View {
    VStack {
        Text("This is the root view of \(title)")
            .font(.system(size: 50))
            .bold()
        Spacer()
            .frame(height: 40)
        StackNavigationLink("Next", destination: ChildView(sidebar: title, level: 1))
    }
    .padding(20)
    .navigationTitle(title)
}
}
```

## Requirements
`StackNavigationView` is a SwiftUI component for macOS. macOS Big Sur is required.

## Author
I'm Laurin Brandner, I'm on [Twitter](https://twitter.com/lbrndnr).

## License
`StackNavigationView` is licensed under the [MIT License](http://opensource.org/licenses/mit-license.php).