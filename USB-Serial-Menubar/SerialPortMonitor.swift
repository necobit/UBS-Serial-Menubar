import Foundation
import Combine

/// USB-Serialポートを検出・監視するクラス
@MainActor
class SerialPortMonitor: ObservableObject {
    @Published var ports: [SerialPort] = []

    private var timer: Timer?
    private let refreshInterval: TimeInterval = 5.0

    init() {
        refresh()
        startMonitoring()
    }

    /// ポートリストを更新
    func refresh() {
        ports = scanPorts()
    }

    /// 定期監視を開始
    private func startMonitoring() {
        timer = Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.refresh()
            }
        }
    }

    /// 定期監視を停止
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }

    /// /dev ディレクトリをスキャンしてUSB-Serialポートを検出
    private func scanPorts() -> [SerialPort] {
        let fileManager = FileManager.default
        let devPath = "/dev"

        guard let contents = try? fileManager.contentsOfDirectory(atPath: devPath) else {
            return []
        }

        let serialPatterns = ["cu.usbserial", "cu.usbmodem", "cu.wchusbserial"]

        return contents
            .filter { name in
                serialPatterns.contains { name.hasPrefix($0) }
            }
            .sorted()
            .map { name in
                SerialPort(name: name, path: "\(devPath)/\(name)")
            }
    }
}
