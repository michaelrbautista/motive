//
//  WelcomeView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

import SwiftUI

struct WelcomeView: View {
    
    var navigationController: NavigationController
    var userViewModel: UserViewModel
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome to Motive. We’ll give you daily motivational quotes from the most successful people in history.")
                    .font(Font.FontStyles.title2)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Let’s personalize the app for you.")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.systemGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Spacer()
            StyledButton(
                variant: .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                navigationController.push(
                    .InspirationView(
                        navigationController: navigationController,
                        userViewModel: userViewModel
                    )
                )
            }

        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    WelcomeView(navigationController: NavigationController(), userViewModel: UserViewModel())
}
