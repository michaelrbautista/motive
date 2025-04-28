//
//  RevenueCatService.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import RevenueCat

class RevenueCatService {
    
    public static let shared = RevenueCatService()
    
    // MARK: Check if user is subscribed
    public func checkSubscription() async throws -> Bool {
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            
            if customerInfo.entitlements["pro"]?.isActive == true {
                // user has access to "your_entitlement_id"
                return true
            } else {
                return false
            }
        } catch {
            throw error
        }
    }
    
}
