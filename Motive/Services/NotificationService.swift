//
//  NotificationService.swift
//  Motive
//
//  Created by Michael Bautista on 5/12/25.
//

import SwiftUI

final class NotificationService {
    
    public static let shared = NotificationService()
    
    // MARK: Schedule notification
    public func scheduleNotification(date: Date?) {
        var components = DateComponents()
        components.hour = 20
        components.minute = 0
        let checkInTime = Calendar.current.date(from: components) ?? Date()
        
        let calendar = Calendar.current
        let hour = calendar.component(
            .hour,
            from: date != nil ? date! : checkInTime
        )
        let minute = calendar.component(
            .minute,
            from: date != nil ? date! : checkInTime
        )
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let content = UNMutableNotificationContent()
        content.title = "Daily Check In"
        content.body = "It's time to check in."
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                UserDefaults.standard.set(checkInTime, forKey: "checkInTime")
                print("Daily notification scheduled for \(hour):\(minute)")
            }
        }
    }
    
    // MARK: Request authorization
    public func requestNotificationAuth(completion: @escaping ((Bool) -> Void)) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
                completion(false)
            }
        
            if granted {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
