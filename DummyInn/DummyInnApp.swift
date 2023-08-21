//
//  DummyInnApp.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/19.
//

import SwiftUI
import Defaults

@main
struct DummyInnApp: App {
    @Default(.preferredColorScheme) private var preferredColorScheme

    var body: some Scene {
        // Main
        WindowGroup {
            ContentView(isDisplaySaveButton: true)
                .frame(width: 430, height: 320)
                .preferredColorScheme(preferredColorScheme.value)
        }
        .windowResizability(.contentSize)

        // Menu
        MenuBarExtra("DummyInn", systemImage: "square.inset.filled") {
            // Note:
            // macOS 14 beta 5 において、ファイル保存ダイアログでディレクトリ変更時にダイアログが消え去る問題があるため、
            // メニューバー版では保存ボタンを表示しないようにしている。
            ContentView(isDisplaySaveButton: false)
                .frame(width: 220)
        }
        .menuBarExtraStyle(.window)

        // About
        Window("About", id: "about") {
            AboutView()
                .frame(width: 280, height: 190)
                .preferredColorScheme(preferredColorScheme.value)
        }
        .windowResizability(.contentSize)

        // Settings
        Settings {
            SettingsWindow()
                .frame(minWidth: 300, minHeight: 200)
                .preferredColorScheme(preferredColorScheme.value)
        }
        .windowResizability(.contentMinSize)
    }
}
