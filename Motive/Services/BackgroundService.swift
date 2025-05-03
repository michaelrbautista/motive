//
//  BackgroundService.swift
//  Motive
//
//  Created by Michael Bautista on 5/2/25.
//

import SwiftUI
import BackgroundTasks

final class BackgroundService: ObservableObject {
    
    public static let shared = BackgroundService()
    
    // MARK: Schedule app refresh
    public func scheduleAppRefresh() {
        let today = Calendar.current.startOfDay(for: .now)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let midnightComponent = DateComponents(hour: 0)
        let midnight = Calendar.current.date(byAdding: midnightComponent, to: tomorrow)
        
        let request = BGAppRefreshTaskRequest(identifier: "com.Michael-Bautista.motive.refresh")
        request.earliestBeginDate = midnight
        
        do {
            try BGTaskScheduler.shared.submit(request)
            print("Background task scheduled successfuly")
            UserDefaults.standard.set(Date(), forKey: "lastScheduledTime")
        } catch {
            print("Unable to submit task: \(error)")
        }
    }
}
