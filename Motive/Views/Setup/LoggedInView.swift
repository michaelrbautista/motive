//
//  LoggedInView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct LoggedInView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        TabView {
            HomeCoordinatorView()
                .tabItem {
                    Image(systemName: "house.fill")
                }
                .environmentObject(userViewModel)
            
            SettingsCoordinatorView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
                .environmentObject(userViewModel)
        }
        .tint(Color.ColorSystem.primaryText)
    }
}

#Preview {
    LoggedInView()
        .environmentObject(UserViewModel())
}
