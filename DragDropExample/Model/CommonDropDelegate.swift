// CommonDropDelegate.swift
// Copyright © Darkness Production. All rights reserved.

import SwiftUI

struct CommonDropDelegate<Item: Equatable>: DropDelegate {
    let currentItem: Item
    @Binding var items: [Item]
    @Binding var draggedItem: Item?
    var onEntered: ((Bool) -> ()) = { _ in }
    var onExit: (() -> ()) = {}
    var onPerform: (() -> ()) = {}

    func performDrop(info: DropInfo) -> Bool {
        onPerform()
        return true
    }

    func dropExited(info: DropInfo) { onExit() }

    func dropUpdated(info: DropInfo) -> DropProposal? { .init(operation: .move) }

    func validateDrop(info: DropInfo) -> Bool { true }

    func dropEntered(info: DropInfo) {
        guard
            let draggedItem = draggedItem,
            draggedItem != currentItem,
            let fromIndex = items.firstIndex(of: draggedItem),
            let toIndex = items.firstIndex(of: currentItem)
        else {
            onEntered(false)
            return
        }
        withAnimation {
            self.items.move(
                fromOffsets: IndexSet(integer: fromIndex),
                toOffset: toIndex > fromIndex ? toIndex + 1 : toIndex
            )
        }
        onEntered(true)
    }
}
