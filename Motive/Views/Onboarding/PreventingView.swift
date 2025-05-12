//
//  PreventingView.swift
//  Motive
//
//  Created by Michael Bautista on 5/12/25.
//

import SwiftUI

struct PreventingView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("Is there anything preventing you from reaching your goals? (Select all that apply)")
                .font(Font.FontStyles.title1)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            VStack(spacing: 20) {
                MultiSelectRow(
                    text: "Lack of motivation",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Lack of motivation") {
                        viewModel.inspirations.remove("Lack of motivation")
                    } else {
                        viewModel.inspirations.insert("Lack of motivation")
                    }
                }
                
                MultiSelectRow(
                    text: "Lack of discipline",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Lack of discipline") {
                        viewModel.inspirations.remove("Lack of discipline")
                    } else {
                        viewModel.inspirations.insert("Lack of discipline")
                    }
                }
                
                MultiSelectRow(
                    text: "Lack of accountability",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Lack of accountability") {
                        viewModel.inspirations.remove("Lack of accountability")
                    } else {
                        viewModel.inspirations.insert("Lack of accountability")
                    }
                }
                
                MultiSelectRow(
                    text: "Other",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Other") {
                        viewModel.inspirations.remove("Other")
                    } else {
                        viewModel.inspirations.insert("Other")
                    }
                }
            }
            Spacer()
            StyledButton(
                variant: .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                navigationController.push(
                    .AccountableView(
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
    PreventingView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()), viewModel: .constant(OnboardingViewModel()))
}
