//
//  UserViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import Supabase
import RevenueCat
import SuperwallKit
import HealthKit

@MainActor
class UserViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var isLoading = false
    
    @Published var event: AuthChangeEvent? = nil
    @Published var session: Session? = nil
    
    @Published var isSubscribed = false
    
    init() {
        self.isLoading = true
        
        Task {
            await checkAuth()
        }
    }
    
    // MARK: Check auth
    @MainActor
    public func checkAuth() async {
        self.isLoading = true
        
        do {
            let _ = try await SupabaseService.shared.supabase.auth.session
            
            let authUser = try await SupabaseService.shared.supabase.auth.session.user
            
            // Get user from db
            let user: User = try await SupabaseService.shared.supabase
                .from("users")
                .select()
                .eq("id", value: authUser.id)
                .single()
                .execute()
                .value
            
            UserService.currentUser = user
            
            // Check if user is subscribed
            self.isSubscribed = try await RevenueCatService.shared.checkSubscription()
            
            #if DEBUG
            self.isSubscribed = true
            #endif
            
            self.isLoggedIn = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isLoading = false
            }
//            self.isLoggedIn = true
//            self.isLoading = false
        } catch {
            print(error)
            self.isLoggedIn = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isLoading = false
            }
//            self.isLoggedIn = false
//            self.isLoading = false
        }
    }
}
