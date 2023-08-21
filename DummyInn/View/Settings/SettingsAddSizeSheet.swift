//
//  SettingsAddSizeSheet.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import SwiftUI

/// 設定画面：サイズ追加シート
struct SettingsAddSizeSheet: View {
    @Environment(\.dismiss) private var dismiss

    private var presets = Presets.shared

    @State private var width: Int = 50
    @State private var height: Int = 50
    @State private var isSquare: Bool = true

    var body: some View {
        VStack {
            Form {
                ImageSizeForm(
                    width: $width,
                    height: $height,
                    isSquare: $isSquare
                )
            }
            .padding()
            .onSubmit(decide)

            // Add / Cancel
            HStack {
                Button("Add", action: decide)
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
        }
        .padding()
        .frame(width: 200)
    }

    // MARK: Event

    func decide() {
        presets.add(size: GenerateSize(width: width, height: height))
        dismiss()
    }
}

#Preview {
    SettingsAddSizeSheet()
}
