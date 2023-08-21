//
//  SettingsTabAppearance.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/21.
//

import SwiftUI
import Defaults

/// 設定ウィンドウ：外観タブ
struct SettingsTabAppearance: View {
    @Default(.preferredColorScheme) private var preferedColorScheme

    @State private var selection: PreferredColorScheme = .light

    var body: some View {
        Form {
            Picker("Color Scheme:", selection: $preferedColorScheme) {
                ForEach(PreferredColorScheme.allCases) { scheme in
                    Text(scheme.label)
                        .tag(scheme)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
        .frame(maxHeight: 200)
    }
}

#Preview {
    SettingsTabAppearance()
}
