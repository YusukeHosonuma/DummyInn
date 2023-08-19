//
//  DummyInnApp.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/19.
//

import SwiftUI

@main
struct DummyInnApp: App {
    var body: some Scene {
        // メニューアプリ
        MenuBarExtra("DummyInn", systemImage: "square.inset.filled") {
            ContentView()
                .frame(width: 220)
        }
        .menuBarExtraStyle(.window)

        // About
        Window("About", id: "about") {
            AboutView()
                .frame(width: 280, height: 190)
        }
        .windowResizability(.contentSize)
    }
}
