// View+OnDrag.swift
// Copyright © VTB. All rights reserved.

import SwiftUI

extension View {
    @ViewBuilder
    func onDrag<V: View>(
        previewEnabled: Bool,
        data: @escaping () -> NSItemProvider,
        @ViewBuilder preview: () -> V
    ) -> some View {
        if previewEnabled, #available(iOS 15.0, *), #available(macOS 12.0, *) {
            onDrag(data, preview: preview)
        } else {
            onDrag(data)
        }
    }
}
