//
//  LearnView.swift
//  Motive
//
//  Created by Michael Bautista on 5/3/25.
//

import SwiftUI

struct LearnView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 40) {
                Image("kobemj")
                    .resizable()
                    .scaledToFit()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("History’s greatest leaders, innovators, and talents were inspired by those that came before them.")
                        .font(Font.FontStyles.title2)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Motive gives you inspiration just like they had.")
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
    LearnView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()), viewModel: .constant(OnboardingViewModel()))
}
