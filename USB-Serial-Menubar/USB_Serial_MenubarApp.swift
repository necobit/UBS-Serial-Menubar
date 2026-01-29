import SwiftUI

@main
struct USB_Serial_MenubarApp: App {
    @StateObject private var portMonitor = SerialPortMonitor()

    var body: some Scene {
        MenuBarExtra {
            SerialPortMenuView(monitor: portMonitor)
        } label: {
            Image(systemName: "cable.connector")
        }
        .menuBarExtraStyle(.menu)
    }
}
