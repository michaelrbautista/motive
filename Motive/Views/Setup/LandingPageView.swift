//
//  LandingPageView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import SuperwallKit

struct LandingPageView: View {
    
    var navigationController: NavigationController
    var userViewModel: UserViewModel
    
    var body: some View {
        VStack(spacing: 40) {
            Text("MOTIVE")
                .font(.custom("InterDisplay-Bold", size: 40))
                .foregroundStyle(Color.ColorSystem.primaryText)
            
            VStack(spacing: 10) {
                StyledButton(
                    variant: .primary,
                    text: "Get Started",
                    isLoading: .constant(false)
                ) {
                    navigationController.push(
                        .WelcomeView(
                            navigationController: navigationController,
                            userViewModel: userViewModel
                        )
                    )
                }
                
                StyledButton(
                    variant: .secondary,
                    text: "Sign In",
                    isLoading: .constant(false)
                ) {
                    navigationController.push(
                        .SignInView(
                            navigationController: navigationController,
                            userViewModel: userViewModel
                        )
                    )
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

#Preview {
    LandingPageView(navigationController: NavigationController(), userViewModel: UserViewModel())
}
