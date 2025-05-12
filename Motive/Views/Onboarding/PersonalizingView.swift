//
//  PersonalizingView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct PersonalizingView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            if viewModel.isPersonalizing {
                Text("Personalizing your app...")
                    .font(Font.FontStyles.title2)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .multilineTextAlignment(.center)
                ProgressView()
                    .frame(maxWidth: UIScreen.main.bounds.size.width)
                    .frame(height: 17)
                    .tint(Color.ColorSystem.primaryText)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            } else {
                Text("Your app is good to go.")
                    .font(Font.FontStyles.title2)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .multilineTextAlignment(.center)
                Text("✅")
                    .frame(width: 40)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            StyledButton(
                variant: viewModel.isPersonalizing ? .disabled : .primary,
                text: "Next",
                isLoading: .constant(false)) {
                    navigationController.push(
                        .CustomizedView(
                            navigationController: $navigationController,
                            userViewModel: $userViewModel,
                            viewModel: $viewModel
                        )
                    )
                }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 3...5)) {
                viewModel.isPersonalizing = false
            }
        }
    }
}

#Preview {
    PersonalizingView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()), viewModel: .constant(OnboardingViewModel()))
}
