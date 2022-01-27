// ListView.swift
// Copyright © Darkness Production. All rights reserved.

import SwiftUI

struct ListView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0.0) {
                Group {
                    HStack {
                        Text("Style")
                        Picker(selection: $listStyleTag, label: Text("List style")) {
                            Text("Default").tag(1)
                            Text("Plain").tag(2)
                            Text("Grouped").tag(3)
                            Text("Sidebar").tag(4)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    Toggle("Edit mode", isOn: $isEditMode)
                    Toggle("Selection mode", isOn: $isSelectionMode)
                }
                .padding(16.0)
                Group {
                    if isSelectionMode {
                        List(selection: $selectedUsersSet) { listContentView }
                    } else {
                        List { listContentView }
                    }
                }
                .if(listStyleTag == 1) { $0.listStyle(DefaultListStyle()) }
                .if(listStyleTag == 2) { $0.listStyle(PlainListStyle()) }
                .if(listStyleTag == 3) { $0.listStyle(GroupedListStyle()) }
                .if(listStyleTag == 4) { $0.listStyle(SidebarListStyle()) }
                .if(isEditMode) { $0.environment(\.editMode, .constant(.active)) }
            }
            .navigationBarItems(trailing: EditButton())
            .navigationBarTitle(Text("List"), displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    @ObservedObject private var storage = UserStorage.shared
    @State private var listStyleTag = 1
    @State private var isEditMode = false
    @State private var isSelectionMode = false
    @State private var selectedUsersSet: Set<String> = []
    
    private var listContentView: some View {
        ForEach(storage.users, id: \.self) { user in
            UserView(user: user)
        }
        .onMove {
            storage.users.move(fromOffsets: $0, toOffset: $1)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
