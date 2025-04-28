//
//  StyledButton.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

enum ButtonVariant {
    case primary
    case secondary
    case disabled
}

struct StyledButton: View {
    
    var variant: ButtonVariant
    var text: String
    @Binding var isLoading: Bool
    var action: (() -> Void)
    
    var body: some View {
        switch variant {
        case .primary:
            Button {
                action()
            } label: {
                HStack {
                    Spacer()
                    if isLoading {
                        ProgressView()
                            .frame(maxWidth: UIScreen.main.bounds.size.width)
                            .frame(height: 17)
                            .tint(Color.ColorSystem.primaryText)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    } else {
                        Text(text)
                            .font(Font.FontStyles.headline)
                            .foregroundStyle(Color.ColorSystem.primaryText)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                    Spacer()
                }
                .frame(height: 40)
                .background(Color.ColorSystem.systemBlue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(isLoading)
        case .secondary:
            Button {
                action()
            } label: {
                HStack {
                    Spacer()
                    if isLoading {
                        ProgressView()
                            .frame(height: 17)
                            .frame(maxWidth: UIScreen.main.bounds.size.width)
                            .tint(Color.ColorSystem.primaryText)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    } else {
                        Text(text)
                            .font(Font.FontStyles.headline)
                            .foregroundStyle(Color.ColorSystem.primaryText)
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    }
                    Spacer()
                }
                .frame(height: 40)
                .background(Color.ColorSystem.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(isLoading)
        case .disabled:
            Button {
                
            } label: {
                HStack {
                    Spacer()
                    Text(text)
                        .font(Font.FontStyles.headline)
                        .foregroundStyle(Color.ColorSystem.systemGray)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    Spacer()
                }
                .frame(height: 40)
                .background(Color.ColorSystem.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(true)
        }
    }
}

#Preview {
    VStack {
        StyledButton(variant: .primary, text: "Test button", isLoading: .constant(false), action: {})
        StyledButton(variant: .secondary, text: "Test button", isLoading: .constant(false), action: {})
    }
    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
}
