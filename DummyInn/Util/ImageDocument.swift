//
//  ImageDocument.swift
//  DummyInn
//
//  Created by Yusuke Hosonuma on 2023/08/21.
//

import SwiftUI
import UniformTypeIdentifiers

struct ImageDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.png] }

    private var image: NSImage
    private var size: CGSize

    init(
        image: NSImage?,
        size: CGSize?
    ) {
        self.image = image ?? NSImage()
        self.size = size ?? .zero
    }

    init(configuration: ReadConfiguration) throws {
        throw RuntimeError()
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        guard let png = image.pngData(size: size) else { throw RuntimeError() }
        return FileWrapper(regularFileWithContents: png)
    }
}
