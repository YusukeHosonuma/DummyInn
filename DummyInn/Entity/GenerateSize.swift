//
//  GenerateSize.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import Defaults

struct GenerateSize: Hashable, Identifiable, Comparable, Codable, Defaults.Serializable {
    var id: GenerateSize { self }

    var width: Int
    var height: Int

    static func < (lhs: GenerateSize, rhs: GenerateSize) -> Bool {
        lhs.width < rhs.width
    }
}

extension GenerateSize {
    var label: String {
        "\(width) x \(height)"
    }
}
