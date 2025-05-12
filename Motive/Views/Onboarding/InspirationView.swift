//
//  InspirationView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct InspirationView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    
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
                    text: "Athletes",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Athletes") {
                        viewModel.inspirations.remove("Athletes")
                    } else {
                        viewModel.inspirations.insert("Athletes")
                    }
                }
                
                MultiSelectRow(
                    text: "Entrepreneurs",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Entrepreneurs") {
                        viewModel.inspirations.remove("Entrepreneurs")
                    } else {
                        viewModel.inspirations.insert("Entrepreneurs")
                    }
                }
                
                MultiSelectRow(
                    text: "Philosophers",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Philosophers") {
                        viewModel.inspirations.remove("Philosophers")
                    } else {
                        viewModel.inspirations.insert("Philosophers")
                    }
                }
                
                MultiSelectRow(
                    text: "Faith",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Faith") {
                        viewModel.inspirations.remove("Faith")
                    } else {
                        viewModel.inspirations.insert("Faith")
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
                    .LearnView(
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
    InspirationView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()))
}
