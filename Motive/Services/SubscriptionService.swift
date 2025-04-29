//
//  SubscriptionService.swift
//  Motive
//
//  Created by Michael Bautista on 4/28/25.
//

import SwiftUI
import SuperwallKit

final class SubscriptionService: ObservableObject, SuperwallDelegate {
    
    public static let shared = SubscriptionService()
        
    @Published var isSubscribed: Bool = false

    private init() {
        Superwall.shared.delegate = self
        
        if Superwall.shared.subscriptionStatus.isActive {
            print("SUBSCRIBED")
            isSubscribed = true
        } else {
            print("NOT SUBSCRIBED")
        }
    }
    
    @MainActor
    func subscriptionStatusDidChange(from oldValue: SubscriptionStatus, to newValue: SubscriptionStatus) {
        switch Superwall.shared.subscriptionStatus {
        case .active(_):
            // If you're using more than one entitlement, you can check which one is active here.
            // This example just assumes one is being used.
            print("User is pro plan.")
            self.isSubscribed = true
        case .inactive:
            print("User is free plan.")
            self.isSubscribed = false
        case .unknown:
            print("User is free plan.")
            self.isSubscribed = false
        }
    }
}
