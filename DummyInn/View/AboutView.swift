//
//  AboutView.swift
//  DragSandbox
//
//  Created by Yusuke Hosonuma on 2023/08/19.
//

import SwiftUI

private let repositoryURL = URL(string: "https://github.com/YusukeHosonuma/DummyInn")!

struct AboutView: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "square.inset.filled")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)

            Text("\(Bundle.main.appName)")
                .font(.headline)
                .textSelection(.enabled)
                .padding(4)

            Text("Version \(Bundle.main.version) (\(Bundle.main.buildVersion))")
                .textSelection(.enabled)

            Link(repositoryURL.absoluteString, destination: repositoryURL)

            Text(Bundle.main.copyright)
                .multilineTextAlignment(.center)
        }
        .font(.caption)
        .padding(20)
    }
}
