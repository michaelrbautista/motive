//
//  PersonalizingView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct PersonalizingView: View {
    @EnvironmentObject var navigationController: NavigationController
    @StateObject var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Spacer()
            if viewModel.isPersonalizingGeneral {
                Text("Personalizing your app...")
                    .font(Font.FontStyles.title2)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .multilineTextAlignment(.center)
                ProgressView()
                    .frame(maxWidth: UIScreen.main.bounds.size.width)
                    .frame(height: 17)
                    .tint(Color.ColorSystem.primaryText)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            } else if viewModel.isPersonalizingQuotes {
                Text("Customizing quotes...")
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
                variant: viewModel.isPersonalizingGeneral || viewModel.isPersonalizingQuotes ? .disabled : .primary,
                text: "Next",
                isLoading: .constant(false)) {
                    navigationController.push(.CustomizedView(viewModel: viewModel))
                }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .onAppear {
            let firstPhase = Double.random(in: 2...4)
            let secondPhase = Double.random(in: 2...4)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + firstPhase) {
                viewModel.isPersonalizingGeneral = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + secondPhase) {
                    viewModel.isPersonalizingQuotes = false
                }
            }
        }
    }
}

#Preview {
    PersonalizingView(viewModel: OnboardingViewModel())
}
