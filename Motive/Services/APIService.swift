//
//  APIService.swift
//  Motive
//
//  Created by Michael Bautista on 4/29/25.
//

import SwiftUI

final class APIService {
    
    public static let shared = APIService()
    
    // MARK: Get quotes for feed
    public func getQuotesForFeed(completion: @escaping ((FeedResponse) -> Void)) {
//        var env = "https://motive-server-ir1u.onrender.com"
//
//        #if DEBUG
//        env = "http://127.0.0.1:8000"
//        #endif
        
        let env = "https://motive-server-ir1u.onrender.com"
        
        let urlString = "\(env)/feed"
        
        guard let url = URL(string: urlString) else { return }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(FeedResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    
    // MARK: Get emergency quote
    public func getEmergencyQuote(completion: @escaping ((EmergencyResponse) -> Void)) {
//        var env = "https://motive-server-ir1u.onrender.com"
//        
//        #if DEBUG
//        env = "http://127.0.0.1:8000"
//        #endif
        
        let env = "https://motive-server-ir1u.onrender.com"
        
        let urlString = "\(env)/emergency"
        
        guard let url = URL(string: urlString) else { return }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(EmergencyResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
    
    // MARK: Get quote on main thread
    public func getQuoteMain(completion: @escaping ((QuoteResponse) -> Void)) {
//        var env = "https://motive-server-ir1u.onrender.com"
//        
//        #if DEBUG
//        env = "http://127.0.0.1:8000"
//        #endif
        
        let env = "https://motive-server-ir1u.onrender.com"
        
        let urlString = "\(env)/quote?topic=self_improvement"
        
        guard let url = URL(string: urlString) else { return }
                
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            
            do {
                let decoded = try JSONDecoder().decode(QuoteResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded)
                }
            } catch {
                print("Decoding error:", error)
            }
        }.resume()
    }
}
