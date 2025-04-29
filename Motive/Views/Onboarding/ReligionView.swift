//
//  ReligionView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct ReligionView: View {
    @EnvironmentObject var navigationController: NavigationController
    @StateObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("Are you religious?")
                .font(Font.FontStyles.title2)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            VStack(spacing: 20) {
                SelectRow(
                    text: "Yes",
                    selection: $viewModel.religion
                ) {
                    viewModel.religion = "Yes"
                }
                
                SelectRow(
                    text: "No",
                    selection: $viewModel.religion
                ) {
                    viewModel.religion = "No"
                }
            }
            Spacer()
            StyledButton(
                variant: viewModel.religion == "" ? .disabled : .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                if viewModel.religion == "Yes" {
                    navigationController.push(.SelectReligionView(viewModel: viewModel))
                } else {
                    navigationController.push(.PersonalizingView(viewModel: viewModel))
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    ReligionView(viewModel: OnboardingViewModel())
}
