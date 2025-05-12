//
//  OneTimeCodeView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import Supabase

struct OneTimeCodeView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    @Binding var viewModel: OnboardingViewModel
    
    var isSignIn: Bool
    
    @State var returnedError = false
    @State var errorMessage = ""
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                Text("Enter the code that was sent to the email:")
                    .font(Font.FontStyles.title1)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.email)
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.systemGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            }
            Spacer()
            VStack(spacing: 10) {
                HStack {
                    TextField("Enter code", text: $viewModel.code)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .keyboardType(.numberPad)
                        .toolbar {
                            ToolbarItem(placement: .keyboard) {
                                HStack {
                                    Spacer()
                                    Button("Done") {
                                        hideKeyboard()
                                    }
                                }
                            }
                        }
                }
                .background(Color.ColorSystem.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer()
            StyledButton(
                variant: viewModel.code == "" ? .disabled : .primary,
                text: "Next",
                isLoading: $viewModel.isLoading
            ) {
                Task {
                    if isSignIn {
                        await viewModel.signIn { quote, source in
                            DispatchQueue.main.async {
                                userViewModel.quote = quote
                                userViewModel.source = source
                                userViewModel.isLoggedIn = true
                            }
                        }
                    } else {
                        await viewModel.createAccount { quote, source in
                            DispatchQueue.main.async {
                                userViewModel.quote = quote
                                userViewModel.source = source
                                userViewModel.isLoggedIn = true
                            }
                        }
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .alert(isPresented: $returnedError, content: {
            Alert(title: Text(errorMessage))
        })
    }
}

#Preview {
    OneTimeCodeView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()), viewModel: .constant(OnboardingViewModel()), isSignIn: true)
}
