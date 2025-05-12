//
//  InspirationView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct InspirationView: View {
    
    var navigationController: NavigationController
    var userViewModel: UserViewModel
    
    @State var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack {
            Text("Where do you get inspiration from? (Select all that apply)")
                .font(Font.FontStyles.title1)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            VStack(spacing: 20) {
                MultiSelectRow(
                    text: "Self improvement",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Self improvement") {
                        viewModel.inspirations.remove("Self improvement")
                    } else {
                        viewModel.inspirations.insert("Self improvement")
                    }
                }
                
                MultiSelectRow(
                    text: "Sports",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Sports") {
                        viewModel.inspirations.remove("Sports")
                    } else {
                        viewModel.inspirations.insert("Sports")
                    }
                }
                
                MultiSelectRow(
                    text: "Entrepreneurship",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Entrepreneurship") {
                        viewModel.inspirations.remove("Entrepreneurship")
                    } else {
                        viewModel.inspirations.insert("Entrepreneurship")
                    }
                }
            }
            Spacer()
            StyledButton(
                variant: viewModel.inspirations.count == 0 ? .disabled : .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                navigationController.push(
                    .EnterGoalsView(
                        navigationController: navigationController,
                        userViewModel: userViewModel,
                        viewModel: $viewModel
                    )
                )
            }

        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    InspirationView(navigationController: NavigationController(), userViewModel: UserViewModel(), viewModel: OnboardingViewModel())
}
