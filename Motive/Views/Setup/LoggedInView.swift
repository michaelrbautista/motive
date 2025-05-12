//
//  LoggedInView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct LoggedInView: View {
    
    var userViewModel: UserViewModel
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .environmentObject(userViewModel)
            
            WidgetsView()
                .tabItem {
                    Image(systemName: "photo.stack.fill")
                }
                .environmentObject(userViewModel)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .environmentObject(userViewModel)
        }
        .tint(Color.ColorSystem.primaryText)
    }
}

#Preview {
    LoggedInView(userViewModel: UserViewModel())
}
