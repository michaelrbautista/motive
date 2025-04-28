//
//  AmbitionView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

import SwiftUI

struct AmbitionView: View {
    @EnvironmentObject var navigationController: NavigationController
    
    var body: some View {
        VStack {
            Text("With motivatio and discipline, you can achieve your biggest goals.")
                .font(Font.FontStyles.title3)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            Text("We made Motive to help you start and maintain the pursuit of your goals.")
                .font(Font.FontStyles.title3)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .multilineTextAlignment(.center)
            Spacer()
            StyledButton(
                variant: .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                navigationController.push(.InspirationView)
            }

        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
    }
}

#Preview {
    AmbitionView()
}
