//
//  Array+.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

extension Array where Element: Hashable {
    mutating func removeAll(_ elements: Set<Element>) {
        removeAll(where: { elements.contains($0) })
    }
}
