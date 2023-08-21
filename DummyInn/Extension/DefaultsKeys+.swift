//
//  DefaultsKeys+.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import Defaults

extension Defaults.Keys {
    static let sizePresets = Key<[GenerateSize]>("sizePresets", default: defaultSizePresets)
    static let isPresentedTutorialPopover = Key<Bool>("isPresentedTutorialPopover", default: true)
    static let preferredColorScheme = Key<PreferredColorScheme>("preferredColorScheme", default: .system)
}
