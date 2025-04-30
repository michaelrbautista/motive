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
                
                MultiSelectRow(
                    text: "Religion",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Religion") {
                        viewModel.inspirations.remove("Religion")
                    } else {
                        viewModel.inspirations.insert("Religion")
                    }
                }
                
                MultiSelectRow(
                    text: "Weightlifting",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Weightlifting") {
                        viewModel.inspirations.remove("Weightlifting")
                    } else {
                        viewModel.inspirations.insert("Weightlifting")
                    }
                }
                
                MultiSelectRow(
                    text: "Running",
                    setSelection: $viewModel.inspirations
                ) {
                    if viewModel.inspirations.contains("Running") {
                        viewModel.inspirations.remove("Running")
                    } else {
                        viewModel.inspirations.insert("Running")
                    }
                }
            }
            Spacer()
            StyledButton(
                variant: viewModel.inspirations.count == 0 ? .disabled : .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                if viewModel.inspirations.contains("Faith") {
                    navigationController.push(.EnterGoalsView(viewModel: viewModel))
                } else {
                    navigationController.push(.EnterGoalsView(viewModel: viewModel))
                }
            }

        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    InspirationView()
}
