//
//  ContentView.swift
//  DragSandbox
//
//  Created by Yusuke Hosonuma on 2023/08/16.
//

import Algorithms
import Foundation
import OSLog
import SwiftUI
import UniformTypeIdentifiers

private let loggerFile: Logger = .file

struct ContentView: View {
    @Environment(\.openWindow) private var openWindow

    @AppStorage("isPresentedPopover") private var isPresentedPopover: Bool = true

    @State private var width: Int = 200
    @State private var height: Int = 200
    @State private var selectedSize: Int = 200
    @State private var selectedColor: ThemeColor = presetColors[0]

    var body: some View {
        VStack(spacing: 16) {
            // フォーム
            Form {
                TextField("Width:", value: $width, format: .number)
                TextField("Height:", value: $height, format: .number)

                Picker("Presets:", selection: $selectedSize) {
                    ForEach(presetSizes, id: \.self) { size in
                        Text("\(size) x \(size)")
                            .tag(size)
                    }
                }
            }
            .onChange(of: selectedSize, initial: true) { _, newValue in
                width = newValue
                height = newValue
            }

            // プレビュー
            preview()
                .popover(isPresented: $isPresentedPopover, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
                    Text("ドラッグ＆ドロップで保存できます")
                        .padding()
                }

                .onDrag {
                    // ref: https://stackoverflow.com/a/75425040

                    let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(component: "\(width)x\(height).png")
                    loggerFile.info("Output path: \(fileURL)")

                    let itemProvider = NSItemProvider(item: fileURL as NSSecureCoding, typeIdentifier: UTType.fileURL.identifier)

                    // 0. ImageRender を用意
                    let render = ImageRenderer(content: output())
                    render.isOpaque = true

                    // 1. NSImage を取得
                    guard let image = render.nsImage else {
                        loggerFile.error("Failed to render NSImage")
                        return itemProvider
                    }

                    // 2. .png を作成
                    guard let png = image.pngData(size: .init(width: width, height: height)) else {
                        loggerFile.error("Failed to create .png")
                        return itemProvider
                    }

                    // 3. ファイルへ書き込み
                    do {
                        try png.write(to: fileURL)
                    } catch {
                        loggerFile.error("Failed to write: \(fileURL)")
                    }

                    return itemProvider
                }

            // カラーパレット
            VStack {
                ForEach(presetColors.chunks(ofCount: 5), id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { color in
                            VStack {
                                color.fill
                                    .frame(width: 30, height: 30)
                                    .border(color.border)
                                    .onTapGesture {
                                        selectedColor = color
                                    }
                            }
                        }
                    }
                }
            }

            // フッター
            HStack {
                Spacer()

                // ⚙️
                Menu {
                    Button("About") {
                        openWindow(id: "about")
                    }
                    Button("Quit") {
                        NSApplication.shared.terminate(nil)
                    }
                } label: {
                    Label("Option", systemImage: "gearshape")
                        .labelStyle(.iconOnly)
                }
                // .menuStyle(.borderlessButton) // 非推奨だが使わない方法が分からない...
                .menuIndicator(.hidden)
                .fixedSize()
            }
        }
        .padding()
    }
}

private extension ContentView {
    func preview() -> some View {
        placeholder()
            .aspectRatio(CGFloat(width) / CGFloat(height), contentMode: .fit)
            .frame(width: 160, height: 160)
    }

    func output() -> some View {
        placeholder()
            .frame(width: CGFloat(width), height: CGFloat(height))
    }

    func placeholder() -> some View {
        selectedColor.fill
            .border(selectedColor.border, width: 2)
            .overlay {
                Text("\(self.width) x \(self.height)")
                    .lineLimit(1)
                    .foregroundStyle(.white)
            }
    }
}

#Preview {
    ContentView()
}
