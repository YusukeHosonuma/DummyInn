//
//  Logger+.swift
//  DragSandbox
//
//  Created by Yusuke Hosonuma on 2023/08/19.
//

import OSLog

extension Logger {
    static let file: Self = .init(category: "file")

    init(type: (some Any).Type) {
        let typeName = String(describing: type)
        self.init(subsystem: Self.subsystem, category: typeName)
    }
}

private extension Logger {
    static let subsystem = Bundle.main.bundleIdentifier!

    init(category: String) {
        self.init(subsystem: Self.subsystem, category: category)
    }
}
