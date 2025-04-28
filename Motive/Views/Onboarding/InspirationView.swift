//
//  InspirationView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct InspirationView: View {
    @EnvironmentObject var navigationController: NavigationController
    @StateObject var viewModel = OnboardingViewModel()
    
    var body: some View {
        VStack {
            Text("Where do you get inspiration from? (Select all that apply)")
                .font(Font.FontStyles.title2)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            VStack(spacing: 20) {
                MultiSelectRow(
                    text: "Self improvement",
                    setSelection: $viewModel.pursuits
                ) {
                    if viewModel.pursuits.contains("Self improvement") {
                        viewModel.pursuits.remove("Self improvement")
                    } else {
                        viewModel.pursuits.insert("Self improvement")
                    }
                }
                
                MultiSelectRow(
                    text: "Faith",
                    setSelection: $viewModel.pursuits
                ) {
                    if viewModel.pursuits.contains("Faith") {
                        viewModel.pursuits.remove("Faith")
                    } else {
                        viewModel.pursuits.insert("Faith")
                    }
                }
                
                MultiSelectRow(
                    text: "Entrepreneurship",
                    setSelection: $viewModel.pursuits
                ) {
                    if viewModel.pursuits.contains("Entrepreneurship") {
                        viewModel.pursuits.remove("Entrepreneurship")
                    } else {
                        viewModel.pursuits.insert("Entrepreneurship")
                    }
                }
                
                MultiSelectRow(
                    text: "Sports",
                    setSelection: $viewModel.pursuits
                ) {
                    if viewModel.pursuits.contains("Sports") {
                        viewModel.pursuits.remove("Sports")
                    } else {
                        viewModel.pursuits.insert("Sports")
                    }
                }
                
                MultiSelectRow(
                    text: "Weightlifting",
                    setSelection: $viewModel.pursuits
                ) {
                    if viewModel.pursuits.contains("Weightlifting") {
                        viewModel.pursuits.remove("Weightlifting")
                    } else {
                        viewModel.pursuits.insert("Weightlifting")
                    }
                }
                
                MultiSelectRow(
                    text: "Running",
                    setSelection: $viewModel.pursuits
                ) {
                    if viewModel.pursuits.contains("Running") {
                        viewModel.pursuits.remove("Running")
                    } else {
                        viewModel.pursuits.insert("Running")
                    }
                }
            }
            Spacer()
            StyledButton(
                variant: viewModel.pursuits.count == 0 ? .disabled : .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                navigationController.push(.EnterGoalsView(viewModel: viewModel))
            }

        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    InspirationView()
}
