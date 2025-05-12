//
//  CustomizedView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import SuperwallKit

struct CustomizedView: View {
    
    var navigationController: NavigationController
    var userViewModel: UserViewModel
    
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 40) {
                Image("goggins")
                    .resizable()
                    .scaledToFit()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Your app has been customized to your goals.")
                        .font(Font.FontStyles.title2)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Become the best version of yourself with Motive.")
                        .font(Font.FontStyles.body)
                        .foregroundStyle(Color.ColorSystem.systemGray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            Spacer()
            StyledButton(
                variant: .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                if SubscriptionService.shared.isSubscribed {
                    navigationController.push(
                        .AddWidgetsView(
                            navigationController: navigationController,
                            userViewModel: userViewModel,
                            viewModel: $viewModel
                        )
                    )
                } else {
                    Superwall.shared.register(placement: "campaign_trigger") {
                        navigationController.push(
                            .AddWidgetsView(
                                navigationController: navigationController,
                                userViewModel: userViewModel,
                                viewModel: $viewModel
                            )
                        )
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    CustomizedView(navigationController: NavigationController(), userViewModel: UserViewModel(), viewModel: .constant(OnboardingViewModel()))
}
