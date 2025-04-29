//
//  CustomizedView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import SuperwallKit

struct CustomizedView: View {
    @EnvironmentObject var navigationController: NavigationController
    @StateObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("Your app has been customized to your goals.")
                .font(Font.FontStyles.title3)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Become the best version of yourself with Motive.")
                .font(Font.FontStyles.title3)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            StyledButton(
                variant: .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                if SubscriptionService.shared.isSubscribed {
                    navigationController.push(.WidgetsView(viewModel: viewModel))
                } else {
                    Superwall.shared.register(placement: "campaign_trigger") {
                        navigationController.push(.WidgetsView(viewModel: viewModel))
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    CustomizedView(viewModel: OnboardingViewModel())
}
