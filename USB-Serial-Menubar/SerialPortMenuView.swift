import SwiftUI
import AppKit

/// メニューバーのメニューUI
struct SerialPortMenuView: View {
    @ObservedObject var monitor: SerialPortMonitor
    @State private var copiedPort: String?

    var body: some View {
        if monitor.ports.isEmpty {
            Text("接続されているポートがありません")
                .foregroundColor(.secondary)
        } else {
            ForEach(monitor.ports) { port in
                Button {
                    copyToClipboard(port.path)
                    copiedPort = port.path

                    // コピー表示を2秒後にリセット
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if copiedPort == port.path {
                            copiedPort = nil
                        }
                    }
                } label: {
                    HStack {
                        Text(port.name)
                        Spacer()
                        if copiedPort == port.path {
                            Text("コピーしました")
                                .foregroundColor(.secondary)
                                .font(.caption)
                        }
                    }
                }
            }
        }

        Divider()

        Button("更新") {
            monitor.refresh()
        }
        .keyboardShortcut("r", modifiers: .command)

        Divider()

        Button("終了") {
            NSApplication.shared.terminate(nil)
        }
        .keyboardShortcut("q", modifiers: .command)
    }

    /// クリップボードにテキストをコピー
    private func copyToClipboard(_ text: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
    }
}
