//
//  SelectReligionView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct SelectReligionView: View {
    @EnvironmentObject var navigationController: NavigationController
    @StateObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("Which religion do you follow?")
                .font(Font.FontStyles.title2)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            VStack(spacing: 20) {
                SelectRow(
                    text: "Christianity",
                    selection: $viewModel.religion
                ) {
                    viewModel.religion = "Christianity"
                }
                
                SelectRow(
                    text: "Catholicism",
                    selection: $viewModel.religion
                ) {
                    viewModel.religion = "Catholicism"
                }
                
                SelectRow(
                    text: "Judaism",
                    selection: $viewModel.religion
                ) {
                    viewModel.religion = "Judaism"
                }
                
                SelectRow(
                    text: "Islam",
                    selection: $viewModel.religion
                ) {
                    viewModel.religion = "Islam"
                }
                
                SelectRow(
                    text: "Other",
                    selection: $viewModel.religion
                ) {
                    viewModel.religion = "Other"
                }
            }
            Spacer()
            StyledButton(
                variant: viewModel.religion == "Yes" ? .disabled : .primary,
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
    SelectReligionView(viewModel: OnboardingViewModel())
}
