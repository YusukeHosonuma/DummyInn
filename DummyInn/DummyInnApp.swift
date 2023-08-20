//
//  DummyInnApp.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/19.
//

import SwiftUI

@main
struct DummyInnApp: App {
    @State private var presets = Presets()

    var body: some Scene {
        // メニューアプリ
        MenuBarExtra("DummyInn", systemImage: "square.inset.filled") {
            ContentView()
                .frame(width: 220)
                .environment(presets)
        }
        .menuBarExtraStyle(.window)

        // About
        Window("About", id: "about") {
            AboutView()
                .frame(width: 280, height: 190)
        }
        .windowResizability(.contentSize)

        // 設定
        Settings {
            SettingsView()
                .frame(minWidth: 300, minHeight: 200)
                .environment(presets)
        }
        .windowResizability(.contentMinSize)
    }
}
