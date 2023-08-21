//
//  SizeForm.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/21.
//

import SwiftUI

struct ImageSizeForm: View {
    @Binding var width: Int
    @Binding var height: Int
    @Binding var isSquare: Bool

    var body: some View {
        TextField("Width:", value: $width, format: .number)
        TextField("Height:", value: $height, format: .number)
        Toggle("Square", isOn: $isSquare)
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
    }
}

#Preview {
    Form {
        ImageSizeForm(width: .constant(200), height: .constant(200), isSquare: .constant(true))
    }
    .padding()
}
