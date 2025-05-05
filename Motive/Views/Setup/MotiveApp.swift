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
    
    @Environment(\.scenePhase) private var phase
    
    @StateObject var userViewModel = UserViewModel()
    @StateObject var subscriptionService = SubscriptionService.shared
    
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
        
        Superwall.configure(apiKey: "pk_3992dc437b4a37af14839c75858845fb92a8d8a68f6f2aad")
        
        print("Next quote:")
        print(UserDefaults.standard.value(forKey: "nextQuote") ?? "nothing")
        print()
        
        print("Last quote:")
        print(UserDefaults.standard.value(forKey: "lastQuote") ?? "nothing")
        print()
    }
    
    var body: some Scene {
        WindowGroup {
            CheckAuthentication()
                .environmentObject(userViewModel)
                .onOpenURL { url in
                    handleIncomingURL(url)
                }
        }
        .backgroundTask(.appRefresh("com.Michael-Bautista.motive.refresh")) { sendable in
            // call API
            await OpenAIService.shared.getQuoteBackground(
                topic: userViewModel.topics.randomElement() ?? "Self improvement"
            ) { response in
                QuoteService.shared.saveQuote(quote: response.quote, source: response.source)
            }
        }
        .backgroundTask(.urlSession("getQuoteInBackground")) { sendable in
            // ?
        }
    }
    
    func handleIncomingURL(_ url: URL) {
        SupabaseService.shared.supabase.handle(url)
        print("User signed in with magic link!")
    }
}

struct CheckAuthentication: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
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
                LoggedInView()
                    .environmentObject(userViewModel)
            } else {
                LandingPageCoordinatorView()
                    .environmentObject(userViewModel)
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
