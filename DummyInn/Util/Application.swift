//
//  Application.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import AppKit

final class Application {
    private init() {}

    static func quit() {
        NSApp.terminate(nil)
    }
}
