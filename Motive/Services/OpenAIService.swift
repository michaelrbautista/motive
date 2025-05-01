//
//  OpenAIService.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI

final class OpenAIService: ObservableObject {
    
    public static let shared = OpenAIService()
    
    // MARK: Get quote
    public func getQuote(topic: String, completion: @escaping ((APIResponse) -> Void)) {
        var topicParameter = "self_improvement"
        
        switch topic {
        case "Religion":
            topicParameter = "religion"
        case "Sports":
            topicParameter = "sports"
        case "Entrepreneurship":
            topicParameter = "entrepreneurship"
        default:
            break
        }
        
        var env = "https://motive-server-ir1u.onrender.com"
        
        #if DEBUG
        env = "http://127.0.0.1:8000"
        #endif
        
        guard let url = URL(string: "\(env)/quote?topic=\(topicParameter)") else { return }
                
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
                print("Decoding error: ", error)
            }
        }.resume()
    }
    
}
