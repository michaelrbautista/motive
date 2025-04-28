//
//  FirstStepView.swift
//  Motive
//
//  Created by Michael Bautista on 4/28/25.
//

import SwiftUI

struct FirstStepView: View {
    @EnvironmentObject var navigationController: NavigationController
    @StateObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("Motivation and inspiration can help you take the first step.")
                .font(Font.FontStyles.title3)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Discipline will get you to your destination.")
                .font(Font.FontStyles.title3)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            StyledButton(
                variant: viewModel.pursuits.count == 0 ? .disabled : .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                navigationController.push(.MotiveHelpsView(viewModel: viewModel))
            }

        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    FirstStepView(viewModel: OnboardingViewModel())
}
