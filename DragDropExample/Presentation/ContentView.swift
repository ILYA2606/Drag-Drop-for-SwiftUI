// ContentView.swift
// Copyright © Darkness Production. All rights reserved.

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ListView().tabItem {
                Image(systemName: "list.dash")
                Text("List")
            }
            .tag(1)
            StackView().tabItem {
                Image(systemName: "square.stack.3d.down.right")
                Text("Stack")
            }
            .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
