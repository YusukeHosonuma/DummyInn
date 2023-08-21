//
//  PreferredColorScheme.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/22.
//

import Defaults
import SwiftUI

enum PreferredColorScheme: String, CaseIterable, Hashable, Identifiable, Codable, Defaults.Serializable {
    var id: String { rawValue }

    case system
    case light
    case dark

    var label: LocalizedStringKey {
        switch self {
        case .system:
            "System"
        case .light:
            "Light"
        case .dark:
            "Dark"
        }
    }

    var value: ColorScheme? {
        switch self {
        case .system:
            nil
        case .light:
            .light
        case .dark:
            .dark
        }
    }
}
