//
//  Constants.swift
//  DragSandbox
//
//  Created by Yusuke Hosonuma on 2023/08/19.
//

import SwiftUI

let presetSizes: [Int] = [
    60,
    80,
    100,
    150,
    200,
    300,
    400,
]

// Note:
// `fill`はダークモードで各色を opacity=0.3 でレンダリングした色。
let presetColors: [ThemeColor] = [
    .init(fill: Color(red: 0.38, green: 0.21, blue: 0.19, opacity: 1.00), border: .red),
    .init(fill: Color(red: 0.39, green: 0.30, blue: 0.18, opacity: 1.00), border: .orange),
    .init(fill: Color(red: 0.40, green: 0.36, blue: 0.20, opacity: 1.00), border: .yellow),
    .init(fill: Color(red: 0.24, green: 0.36, blue: 0.22, opacity: 1.00), border: .green),
    .init(fill: Color(red: 0.27, green: 0.38, blue: 0.38, opacity: 1.00), border: .mint),
    .init(fill: Color(red: 0.26, green: 0.34, blue: 0.36, opacity: 1.00), border: .teal),
    .init(fill: Color(red: 0.25, green: 0.34, blue: 0.39, opacity: 1.00), border: .cyan),
    .init(fill: Color(red: 0.18, green: 0.26, blue: 0.40, opacity: 1.00), border: .blue),
    .init(fill: Color(red: 0.22, green: 0.22, blue: 0.37, opacity: 1.00), border: .indigo),
    .init(fill: Color(red: 0.32, green: 0.22, blue: 0.38, opacity: 1.00), border: .purple),
    .init(fill: Color(red: 0.38, green: 0.20, blue: 0.22, opacity: 1.00), border: .pink),
    .init(fill: Color(red: 0.31, green: 0.28, blue: 0.24, opacity: 1.00), border: .brown),
    .init(fill: Color(red: 0.41, green: 0.41, blue: 0.41, opacity: 1.00), border: .white),
    .init(fill: Color(red: 0.29, green: 0.29, blue: 0.29, opacity: 1.00), border: .gray),
    .init(fill: Color(red: 0.29, green: 0.29, blue: 0.29, opacity: 1.00), border: .black),
]

struct ThemeColor: Hashable {
    var fill: Color
    var border: Color
}
