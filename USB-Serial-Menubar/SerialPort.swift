import Foundation

/// USB-Serialポートを表すモデル
struct SerialPort: Identifiable, Hashable {
    let id = UUID()
    let name: String    // "cu.usbserial-1420"
    let path: String    // "/dev/cu.usbserial-1420"

    func hash(into hasher: inout Hasher) {
        hasher.combine(path)
    }

    static func == (lhs: SerialPort, rhs: SerialPort) -> Bool {
        lhs.path == rhs.path
    }
}
