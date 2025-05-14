//
//  AddWidgetsView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct AddWidgetsView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("Add the widgets to your home and lock screens to stay locked in.")
                .font(Font.FontStyles.title2)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    // MARK: Medium
                    VStack(alignment: .leading, spacing: 5) {
                        Text("MEDIUM")
                            .font(Font.FontStyles.footnote)
                            .foregroundStyle(Color.ColorSystem.systemGray)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Circumstances don't make the man, they only reveal him to himself.")
                            .font(.custom("InterDisplay-Bold", size: 16))
                            .foregroundStyle(Color.white)
                            .lineLimit(5)
                            
                            Text("Epictetus")
                            .font(.custom("InterDisplay-Bold", size: 14))
                            .foregroundStyle(Color.gray)
                        }
                        .frame(height: 155)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.ColorSystem.systemGray5)
                        )
                    }
                }
                
                HStack(alignment: .top) {
                    // MARK: Small
                    VStack(alignment: .leading, spacing: 5) {
                        Text("SMALL")
                            .font(Font.FontStyles.footnote)
                            .foregroundStyle(Color.ColorSystem.systemGray)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Circumstances don't make the man, they only reveal him to himself.")
                            .font(.custom("InterDisplay-Bold", size: 14))
                            .foregroundStyle(Color.white)
                            .lineLimit(5)
                            
                            Text("Epictetus")
                            .font(.custom("InterDisplay-Bold", size: 12))
                            .foregroundStyle(Color.gray)
                            .lineLimit(1)
                        }
                        .frame(height: 155)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.ColorSystem.systemGray5)
                        )
                    }
                    
                    // MARK: Lock screen
                    VStack(alignment: .leading, spacing: 5) {
                        Text("LOCK SCREEN")
                            .font(Font.FontStyles.footnote)
                            .foregroundStyle(Color.ColorSystem.systemGray)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Epictetus")
                            .font(.custom("InterDisplay-Bold", size: 12))
                            .foregroundStyle(Color.white)
                            .lineLimit(1)
                            
                            Text("Circumstances don't make the man, they only reveal him to himself.")
                            .font(.custom("InterDisplay", size: 10))
                            .foregroundStyle(Color.white)
                            .lineLimit(3)
                        }
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.ColorSystem.systemGray5)
                        )
                    }
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            StyledButton(
                variant: .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                navigationController.push(
                    .CreateAccountView(
                        navigationController: $navigationController,
                        userViewModel: $userViewModel,
                        viewModel: $viewModel
                    )
                )
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    AddWidgetsView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()), viewModel: .constant(OnboardingViewModel()))
}
