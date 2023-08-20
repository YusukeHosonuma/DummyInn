//
//  ImageRenderer+.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/20.
//

import OSLog
import SwiftUI

private let logger: Logger = .file

@MainActor
extension ImageRenderer {
    func writeAsPNG(to fileURL: URL, size: CGSize) throws {
        // 1. NSImage を取得
        guard let image = nsImage else {
            logger.error("Failed to render NSImage")
            throw RuntimeError()
        }

        // 2. .png を作成
        guard let png = image.pngData(size: size) else {
            logger.error("Failed to create .png")
            throw RuntimeError()
        }

        // 3. ファイルへ書き込み
        do {
            try png.write(to: fileURL)
        } catch {
            logger.error("Failed to write: \(fileURL)")
        }
    }
}
