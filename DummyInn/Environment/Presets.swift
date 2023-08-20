//
//  Presets.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import SwiftUI
import Defaults

@Observable
final class Presets {
    /// サイズ一覧
    private(set) var sizes: [GenerateSize] {
        didSet {
            Defaults[.sizePresets] = sizes
        }
    }

    init() {
        sizes = Defaults[.sizePresets]
    }

    func add(size: GenerateSize) {
        var newSizes = sizes
        newSizes.append(size)
        newSizes.sort(by: { $0.width < $1.width })
        sizes = newSizes
    }

    func remove(sizes: Set<GenerateSize>) {
        self.sizes.removeAll(sizes)
    }

    func reset() {
        sizes = defaultSizePresets
    }
}
