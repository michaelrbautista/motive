//
//  BackgroundService.swift
//  Motive
//
//  Created by Michael Bautista on 5/2/25.
//

import SwiftUI
import BackgroundTasks
import WidgetKit

final class BackgroundService {
    
    public static let shared = BackgroundService()
    
    // MARK: Schedule app refresh
    public func scheduleAppRefresh() {
        #if DEBUG
        let time = Calendar.current.date(byAdding: .hour, value: 1, to: Date.now)!
        #else
        let today = Calendar.current.startOfDay(for: .now)
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
        let timeComponent = DateComponents(hour: 0)
        let time = Calendar.current.date(byAdding: timeComponent, to: tomorrow)
        #endif
        
        let request = BGAppRefreshTaskRequest(identifier: "com.Michael-Bautista.motive.refresh")
        request.earliestBeginDate = time
        
        do {
            try BGTaskScheduler.shared.submit(request)
            
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            #if DEBUG
            print("Background task scheduled at \(formatter.string(from: time))")
            #endif
            
            UserDefaults.standard.set(time, forKey: "nextQuote")
        } catch {
            print("(BackgroundService) Could not schedule app refresh.")
            print("Error: \(error)")
        }
    }
    
    // MARK: Get quote in background
    public func getQuoteBackground() async {
        UserDefaults.standard.set(Date(), forKey: "lastBackgroundQuote")
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.Michael-Bautista.motive.refresh")
        let delegate = BackgroundSessionDelegate()
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        
        let env = "https://motive-server-ir1u.onrender.com"
        
        let urlString = "\(env)/quote?topic=self_improvement"

        if let url = URL(string: urlString) {
            let task = session.downloadTask(with: url)
            task.taskDescription = "quote"
            task.resume()
        }
    }
    
    // MARK: Get image in background
    public func getImageBackground() async {
        UserDefaults.standard.set(Date(), forKey: "lastBackgroundImage")
        
        let configuration = URLSessionConfiguration.background(withIdentifier: "com.Michael-Bautista.motive.refresh")
        let delegate = BackgroundSessionDelegate()
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
        
        // Get image download url
        do {
            let imageUrl = try await StorageService.shared.getImageUrl()
            
            if let url = imageUrl {
                let task = session.downloadTask(with: url)
                task.taskDescription = "image"
                task.resume()
            }
        } catch {
            print("Couldn't get image url from supabase for background task.")
        }
    }
}

// MARK: Background delegate
class BackgroundSessionDelegate: NSObject, URLSessionDataDelegate {
    var responseData = Data()
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData.append(data)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        guard error == nil else {
            print("Background task error: \(error!)")
            return
        }

        if task.taskDescription == "quote" {
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(QuoteResponse.self, from: responseData)
                
                let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
                userDefaults?.set(apiResponse.quote, forKey: "quote")
                userDefaults?.set(apiResponse.source, forKey: "source")
                
                WidgetCenter.shared.reloadAllTimelines()
            } catch {
                print("Decoding error: \(error)")
            }
        } else {
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(Data.self, from: responseData)
                
                let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
                userDefaults?.set(apiResponse, forKey: "image")
                
                WidgetCenter.shared.reloadAllTimelines()
            } catch {
                print("Decoding error: \(error)")
            }
        }
    }
}
