//
//  SettingsAddSizeSheet.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import SwiftUI

/// 設定画面：サイズ追加シート
struct SettingsAddSizeSheet: View {
    @Binding var sizes: [GenerateSize]

    @Environment(\.dismiss) private var dismiss
    @State private var width: Int = 50
    @State private var height: Int = 50
    @State private var isSquare: Bool = true

    var body: some View {
        VStack {
            // フォーム
            Form {
                TextField("Width:", value: $width, format: .number)
                TextField("Height:", value: $height, format: .number)
                Toggle("Square", isOn: $isSquare)
            }
            .onChange(of: width) { _, newValue in
                if isSquare {
                    height = newValue
                }
            }
            .onChange(of: height) { _, newValue in
                if isSquare {
                    width = newValue
                }
            }
            .onChange(of: isSquare) { _, newValue in
                if newValue {
                    height = width
                }
            }
            .padding()

            // OK / Cancel
            HStack {
                Button("OK") {
                    sizes.append(.init(width: width, height: height))
                    sizes.sort(by: { $0.width < $1.width })

                    dismiss()
                }
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
            }
        }
        .padding()
        .frame(width: 200)
    }
}

#Preview {
    SettingsAddSizeSheet(sizes: .constant([]))
}
