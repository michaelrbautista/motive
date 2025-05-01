//
//  EnterGoalsView.swift
//  Motive
//
//  Created by Michael Bautista on 4/28/25.
//

import SwiftUI

struct EnterGoalsView: View {
    @EnvironmentObject var navigationController: NavigationController
    @StateObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("What are your goals?")
                .font(Font.FontStyles.title2)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            ZStack(alignment: .topLeading) {
                if viewModel.goals == "" {
                    Text("Enter your goals...")
                        .font(Font.FontStyles.body)
                        .foregroundStyle(Color.ColorSystem.systemGray)
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                }
                
                TextEditor(text: $viewModel.goals)
                    .frame(height: 200)
                    .scrollContentBackground(.hidden)
            }
            .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
            .background(Color.ColorSystem.systemGray6)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
            StyledButton(
                variant: viewModel.goals == "" ? .disabled : .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                navigationController.push(.PersonalizingView(viewModel: viewModel))
            }

        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    EnterGoalsView(viewModel: OnboardingViewModel())
}
