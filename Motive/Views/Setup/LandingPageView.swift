//
//  LandingPageView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import SuperwallKit

struct LandingPageView: View {
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 0) {
                Image("wordLandingPage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200)
            }
            
            VStack(spacing: 10) {
                StyledButton(
                    variant: .primary,
                    text: "Get Started",
                    isLoading: .constant(false)
                ) {
                    navigationController.push(.AmbitionView)
                }
                
                StyledButton(
                    variant: .secondary,
                    text: "Sign In",
                    isLoading: .constant(false)
                ) {
                    navigationController.push(.SignInView)
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
    }
}

#Preview {
    LandingPageView()
}
