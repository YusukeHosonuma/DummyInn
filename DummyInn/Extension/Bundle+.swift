//
//  Bundle+.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/19.
//

import Foundation

extension Bundle {
    var appName: String {
        value(key: "CFBundleDisplayName")
    }

    var copyright: String {
        value(key: "NSHumanReadableCopyright")
    }

    var version: String {
        value(key: "CFBundleShortVersionString")
    }

    var buildVersion: String {
        value(key: "CFBundleVersion")
    }
}

private extension Bundle {
    private func value(key: String) -> String {
        infoDictionary?[key] as? String ?? ""
    }
}
