//
//  AppDelegate.swift
//  Motive
//
//  Created by Michael Bautista on 5/12/25.
//

import UIKit
import BackgroundTasks

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Register background task
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.Michael-Bautista.motive.refresh", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
        
        BackgroundService.shared.scheduleAppRefresh()
        
        return true
    }

    func handleAppRefresh(task: BGAppRefreshTask) {
        BackgroundService.shared.scheduleAppRefresh()

        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1

        let operation = MyBackgroundOperation()

        task.expirationHandler = {
            queue.cancelAllOperations()
        }

        operation.completionBlock = {
            task.setTaskCompleted(success: !operation.isCancelled)
        }

        queue.addOperation(operation)
    }
}

class MyBackgroundOperation: Operation, @unchecked Sendable {
    override func main() {
        if isCancelled { return }
        Task {
            await OpenAIService.shared.getQuoteBackground(
                topic: "Self improvement"
            ) { response in
                QuoteService.shared.saveQuote(quote: response.quote, source: response.source)
            }
        }
    }
}
