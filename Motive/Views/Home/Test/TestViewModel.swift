//
//  TestViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 5/12/25.
//

import SwiftUI

@Observable
final class TestViewModel {
    
    // MARK: Test notification
    public func testNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test."
        content.sound = .default

        // Trigger after 30 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            } else {
                print("Notification scheduled in 30 seconds.")
            }
        }
    }
    
}
