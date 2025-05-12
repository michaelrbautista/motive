//
//  LoggedInView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct LoggedInView: View {
    
    @Binding var userViewModel: UserViewModel
    
    var body: some View {
        TabView {
            HomeCoordinatorView(userViewModel: $userViewModel)
                .tabItem {
                    Image(systemName: "house.fill")
                }
            
            WidgetsCoordinatorView(userViewModel: $userViewModel)
                .tabItem {
                    Image(systemName: "photo.stack.fill")
                }
            
            SettingsCoordinatorView(userViewModel: $userViewModel)
                .tabItem {
                    Image(systemName: "gearshape.fill")
                }
        }
        .tint(Color.ColorSystem.primaryText)
    }
}

#Preview {
    LoggedInView(userViewModel: .constant(UserViewModel()))
}
