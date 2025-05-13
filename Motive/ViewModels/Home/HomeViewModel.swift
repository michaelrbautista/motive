//
//  HomeViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

@Observable
final class HomeViewModel {
    
    var quote = ""
    var source = ""
    var image = Data()
    
    var entries = [CheckInEntry]()
    
    var isLoading = false
    
    // MARK: Schedule notification
    public func scheduleNotification() {
        var components = DateComponents()
        components.hour = 20
        components.minute = 0
        let reminderTime = Calendar.current.date(from: components) ?? Date()
        
        let content = UNMutableNotificationContent()
        content.title = "Daily Check In"
        content.body = "It's time to check in."
        content.sound = .default

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: reminderTime)
        let minute = calendar.component(.minute, from: reminderTime)
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                UserDefaults.standard.set(reminderTime, forKey: "reminderTime")
                print("Daily notification scheduled for \(hour):\(minute)")
            }
        }
    }
    
}
