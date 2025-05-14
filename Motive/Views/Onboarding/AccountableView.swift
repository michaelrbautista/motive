//
//  AccountableView.swift
//  Motive
//
//  Created by Michael Bautista on 5/12/25.
//

import SwiftUI

struct AccountableView: View {
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack(spacing: 40) {
            Spacer()
            Image("graph")
                .resizable()
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("People that use the motivational widgets are 30% more likely to stay disciplined.")
                    .font(Font.FontStyles.title2)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Make sure to add the widgets to your home and lock screens.")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.systemGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
            StyledButton(
                variant: viewModel.goals == "" ? .disabled : .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                navigationController.push(
                    .PersonalizingView(
                        navigationController: $navigationController,
                        userViewModel: $userViewModel,
                        viewModel: $viewModel
                    )
                )
            }

        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    AccountableView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()), viewModel: .constant(OnboardingViewModel()))
}
