//
//  ContentView.swift
//  DragSandbox
//
//  Created by Yusuke Hosonuma on 2023/08/16.
//

import Algorithms
import Defaults
import OSLog
import SwiftUI
import UniformTypeIdentifiers

// メニューバーのルート
struct ContentView: View {
    @Environment(\.openWindow) private var openWindow

    @Default(.isPresentedTutorialPopover) private var isPresentedTutorialPopover

    private var presets = Presets.shared

    private var isDisplaySaveButton: Bool

    @State private var width: Int
    @State private var height: Int
    @State private var isSquare = true
    @State private var selectedSize: GenerateSize
    @State private var selectedColor: ThemeColor = presetColors[0]
    @State private var isPresentedFileExporter: Bool = false

    init(isDisplaySaveButton: Bool) {
        self.isDisplaySaveButton = isDisplaySaveButton

        let size = Presets.shared.sizes.first ?? .init(width: 200, height: 200)
        _width = .init(wrappedValue: size.width)
        _height = .init(wrappedValue: size.height)
        _selectedSize = .init(wrappedValue: size)
    }

    var body: some View {
        VStack(spacing: 16) {
            ViewThatFits(in: .horizontal) {
                HStack {
                    mainPanel()
                        .frame(maxWidth: .infinity)
                    VStack {
                        formPanel()
                        Spacer()
                        footer()
                    }
                    .frame(maxWidth: 180)
                }
                VStack {
                    formPanel()
                    mainPanel()
                    footer()
                }
            }
        }
        .padding()
        .fileExporter(
            isPresented: $isPresentedFileExporter,
            document: imageDocument,
            contentType: .png,
            defaultFilename: "\(width)x\(height).png",
            onCompletion: { result in
                switch result {
                case let .success(url):
                    Logger.file.info("Success to write from fileExporter: \(url)")
                case let .failure(error):
                    Logger.file.info("Failed to write from fileExporter: \(error.localizedDescription)")
                }
            }
        )
    }

    var imageDocument: ImageDocument {
        let render = ImageRenderer(content: output())
        render.isOpaque = true
        return ImageDocument(image: render.nsImage, size: .init(width: width, height: height))
    }

    func formPanel() -> some View {
        Form {
            Section {
                ImageSizeForm(
                    width: $width,
                    height: $height,
                    isSquare: $isSquare
                )
            }

            Section {
                Picker("Presets:", selection: $selectedSize) {
                    ForEach(presets.sizes, id: \.self) { size in
                        Text("\(size.label)")
                            .tag(size)
                    }
                }
            }
            .padding(.top)
        }
        .onChange(of: selectedSize, initial: true) { _, newValue in
            width = newValue.width
            height = newValue.height
        }
    }

    func mainPanel() -> some View {
        VStack(spacing: 16) {
            // プレビュー
            preview()
                .popover(isPresented: $isPresentedTutorialPopover, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
                    Text("Drag and drop to save")
                        .padding()
                }
                .onDrag {
                    // ref: https://stackoverflow.com/a/75425040
                    let fileName = "\(width)x\(height).png"
                    let fileURL = FileManager.default.homeDirectoryForCurrentUser.appending(component: fileName)

                    let render = ImageRenderer(content: output())
                    render.isOpaque = true

                    // Note:
                    // ファイル書き込みに失敗しても何もしない。（OSによってドラッグアイコンが禁止マークになる）
                    try? render.writeAsPNG(to: fileURL, size: .init(width: width, height: height))

                    return NSItemProvider(item: fileURL as NSSecureCoding, typeIdentifier: UTType.fileURL.identifier)
                }

            // カラーパレット
            Grid {
                ForEach(presetColors.chunks(ofCount: 5), id: \.self) { row in
                    GridRow {
                        ForEach(row, id: \.self) { color in
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
        .padding()
    }

    func footer() -> some View {
        HStack {
            if isDisplaySaveButton {
                Button("Save...") {
                    isPresentedFileExporter = true
                }
            }

            Spacer()

            // ⚙️
            Menu {
                Button("About") {
                    openWindow(id: "about")
                }
                SettingsLink {
                    Text("Settings...")
                }

                // --------
                Divider()

                Button("Quit") {
                    Application.quit()
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
                Text("\(width) x \(height)")
                    .lineLimit(1)
                    .foregroundStyle(.white)
            }
    }
}

#Preview("Main") {
    ContentView(isDisplaySaveButton: true)
        .frame(width: 430, height: 320)
}

#Preview("MenuBarExtra") {
    ContentView(isDisplaySaveButton: false)
        .frame(width: 220)
}
