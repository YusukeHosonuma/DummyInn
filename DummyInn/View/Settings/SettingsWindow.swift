//
//  SettingsWindow.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/21.
//

import SwiftUI

/// 設定ウィンドウ
struct SettingsWindow: View {
    var body: some View {
        TabView {
            SettingsTabGeneral()
                .tabItem {
                    Label("General", systemImage: "gearshape")
                }
            SettingsTabAppearance()
                .tabItem {
                    Label("Appearance", systemImage: "paintpalette")
                }
        }
    }
}

#Preview {
    SettingsWindow()
}
