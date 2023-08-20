//
//  Presets.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import Collections
import Defaults
import SwiftUI

@Observable
final class Presets {
    /// サイズ一覧
    private(set) var sizes: OrderedSet<GenerateSize> = .init(Defaults[.sizePresets]) {
        didSet {
            Defaults[.sizePresets] = .init(sizes)
        }
    }

    func add(size: GenerateSize) {
        var newSizes = sizes
        newSizes.append(size)
        newSizes.sort()
        sizes = newSizes
    }

    func remove(sizes elements: Set<GenerateSize>) {
        sizes.removeAll(elements)
    }

    func reset() {
        sizes = .init(defaultSizePresets)
    }
}
