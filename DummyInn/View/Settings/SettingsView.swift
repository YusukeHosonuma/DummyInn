//
//  SettingsView.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import SwiftUI

/// 設定画面
struct SettingsView: View {
    private var presets = Presets.shared

    @State private var isPresentedSheet: Bool = false
    @State private var isPresentedConfirm = false
    @State private var selection: Set<GenerateSize> = []

    var body: some View {
        VStack(alignment: .leading) {
            // Sizes
            // - 100 x 100
            // - 200 x 200
            // ...
            Table(presets.sizes, selection: $selection) {
                TableColumn("Size", value: \.label)
            }

            // + / - / Reset...
            HStack {
                Button("Add", systemImage: "plus") {
                    isPresentedSheet = true
                }
                Button("Remove", systemImage: "minus") {
                    presets.remove(sizes: selection)

                    // Note: 明示的にクリアしないと残り続ける。（たぶんバグ）
                    selection = []
                }
                .disabled(selection.isEmpty)

                Spacer()

                Button("Reset...", role: .destructive) {
                    isPresentedConfirm = true
                }
            }
            .labelStyle(.iconOnly)
        }
        .sheet(isPresented: $isPresentedSheet) {
            SettingsAddSizeSheet()
        }
        .confirmationDialog("Reset", isPresented: $isPresentedConfirm) {
            Button("Reset", role: .destructive) {
                presets.reset()
            }
        } message: {
            Text("Do you want to reset to default?")
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
