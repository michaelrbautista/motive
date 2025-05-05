//
//  OpenAIService.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI

final class OpenAIService: ObservableObject {
    
    public static let shared = OpenAIService()
    
    // MARK: Get url
    public func getUrl(topic: String) -> String {
        var topicParameter = "self_improvement"
        
        switch topic {
        case "Sports":
            topicParameter = "sports"
        case "Entrepreneurship":
            topicParameter = "entrepreneurship"
        default:
            break
        }
        
        let env = "https://motive-server-ir1u.onrender.com"
        
//        #if DEBUG
//        env = "http://127.0.0.1:8000"
//        #endif
        
        let urlString = "\(env)/quote?topic=\(topicParameter)"
        
        return urlString
    }
    
    // MARK: Get quote on background thread
    public func getQuoteBackground(topic: String, completion: @escaping ((APIResponse) -> Void)) async {
        let urlString = self.getUrl(topic: topic)
        
        guard let url = URL(string: urlString) else { return }
                
        let request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let config = URLSessionConfiguration.background(withIdentifier: "getQuoteInBackground")
        config.sessionSendsLaunchEvents = true
        let session = URLSession(configuration: config)
        
        let response = await withTaskCancellationHandler {
            try? await session.data(for: request)
        } onCancel: {
            let task = session.downloadTask(with: request)
            task.resume()
        }
        
        if let data = response {
            do {
                let decoded = try JSONDecoder().decode(APIResponse.self, from: data.0)
                completion(decoded)
            } catch {
                print("Decoding error:", error)
            }
        }
    }
    
    // MARK: Get quote on main thread
    public func getQuoteMain(topic: String, completion: @escaping ((APIResponse) -> Void)) {
        let urlString = self.getUrl(topic: topic)
        
        guard let url = URL(string: urlString) else { return }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    
}
