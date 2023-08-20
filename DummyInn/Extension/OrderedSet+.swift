//
//  OrderedSet+.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import Collections

extension OrderedSet {
    mutating func removeAll(_ elements: Set<Element>) {
        removeAll { elements.contains($0) }
    }
}
