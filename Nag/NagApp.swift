import SwiftUI

@main
struct NagApp: App {
    @StateObject private var notificationManager = NotificationManager()
    
    init() {
        NotificationManager.requestAuthorization()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
        }
    }
}
