// StackView.swift
// Copyright © Darkness Production. All rights reserved.

import SwiftUI

struct StackView: View {
    var body: some View {
        VStack(spacing: 0.0) {
            Toggle("Custom preview", isOn: $isCustomPreview)
                .padding(16.0)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0.0) {
                    ForEach(storage.users, id: \.self) { user in
                        HStack {
                            Image(systemName: "line.3.horizontal")
                            UserView(user: user)
                        }
                        .contentShape(Rectangle())
                        .opacity(isDragging && draggedItem == user ? 0.2 : 1.0)
                        .if(isCustomPreview) {
                            $0.onDrag {
                                makeItemProvider(user: user)
                            } preview: {
                                Text("Drag it!")
                                    .frame(width: 200, height: 30)
                            }
                        }
                        .if(!isCustomPreview) {
                            $0.onDrag { makeItemProvider(user: user) }
                        }
                        .onDrop(of: [user], delegate: makeDropDelegate(user: user) )
                    }
                }
                .padding(.horizontal, 16.0)
                .padding(.vertical, 4.0)
            }
        }
    }
    
    @ObservedObject private var storage = UserStorage.shared
    @State private var draggedItem: String?
    @State private var isDragging = false
    @State private var isCustomPreview = false
    
    private func makeDropDelegate(user: String) -> DropDelegate {
        CommonDropDelegate(
            currentItem: user,
            items: $storage.users,
            draggedItem: $draggedItem,
            onEntered: { _ in
                withAnimation {
                    isDragging = true
                }
            },
            onExit: {
                withAnimation {
                    isDragging = false
                }
            },
            onPerform: {
                withAnimation {
                    isDragging = false
                    draggedItem = nil
                }
            }
        )
    }
    
    private func makeItemProvider(user: String) -> NSItemProvider {
        draggedItem = user
        return NSItemProvider(object: user as NSItemProviderWriting)
    }
}

struct StackView_Previews: PreviewProvider {
    static var previews: some View {
        StackView()
    }
}
