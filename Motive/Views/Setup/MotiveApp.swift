//
//  MotiveApp.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import Supabase
import SuperwallKit
import BackgroundTasks

@main
struct DailyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State var userViewModel = UserViewModel()
    @State var subscriptionService: SubscriptionService
    
    init() {
        let navAppearance = UINavigationBarAppearance()
        navAppearance.backgroundColor = UIColor(Color.ColorSystem.systemBackground)
        navAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.ColorSystem.primaryText)]
        navAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.ColorSystem.primaryText)]
        navAppearance.shadowColor = .clear
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
        UINavigationBar.appearance().standardAppearance = navAppearance
        
        let tabAppearance = UITabBarAppearance()
        tabAppearance.backgroundColor = UIColor(Color.ColorSystem.systemBackground)
        tabAppearance.shadowColor = .clear
        UITabBar.appearance().scrollEdgeAppearance = tabAppearance
        UITabBar.appearance().standardAppearance = tabAppearance
        
//        if let appDomain = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: appDomain)
//            UserDefaults.standard.synchronize()
//        }
        
        UserDefaults.standard.removeObject(forKey: "reminderTime")
        
        Superwall.configure(apiKey: "pk_3992dc437b4a37af14839c75858845fb92a8d8a68f6f2aad")
        
        self.subscriptionService = SubscriptionService.shared
        
//        let userDefaults = UserDefaults(suiteName: "group.Michael-Bautista.motive")
//        print(userDefaults?.value(forKey: "quote"))
//        print(userDefaults?.value(forKey: "source"))
//        print(userDefaults?.value(forKey: "image"))
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "America/Los_Angeles")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let lastBackgroundQuote = UserDefaults.standard.value(forKey: "lastBackgroundQuote") as? Date
        let lastBackgroundImage = UserDefaults.standard.value(forKey: "lastBackgroundImage") as? Date
        
        print("Last quote: \(formatter.string(from: lastBackgroundQuote ?? Date.now))")
        print("Last image: \(formatter.string(from: lastBackgroundImage ?? Date.now))")
    }
    
    var body: some Scene {
        WindowGroup {
            CheckAuthentication(userViewModel: $userViewModel)
        }
    }
}

struct CheckAuthentication: View {
    
    @Binding var userViewModel: UserViewModel
    
    var body: some View {
        if userViewModel.isLoading {
            VStack(spacing: 20) {
                Spacer()
                
                Text("Time to lock in.")
                    .font(.custom("InterDisplay-Bold", size: 22))
                    .foregroundStyle(Color.ColorSystem.primaryText)
                
                Spacer()
            }
            .frame(width: 160)
        } else {
            if userViewModel.isLoggedIn {
                LoggedInView(userViewModel: $userViewModel)
                    .onAppear {
                        if !SubscriptionService.shared.isSubscribed {
                            Superwall.shared.register(placement: "campaign_trigger")
                        }
                    }
            } else {
                LandingPageCoordinatorView(userViewModel: $userViewModel)
            }
        }
    }
}

// Extension to hide keyboard
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
