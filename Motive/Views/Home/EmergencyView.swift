//
//  EmergencyView.swift
//  Motive
//
//  Created by Michael Bautista on 5/13/25.
//

import SwiftUI

struct EmergencyView: View {
    @Environment(\.dismiss) private var dismiss
    
//    @Binding var navigationController: NavigationController
    
    @State var viewModel = EmergencyViewModel()
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .foregroundStyle(Color.ColorSystem.primaryText)
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .background(Color.ColorSystem.systemBackground)
                .onAppear {
                    viewModel.getQuote()
                }
        } else {
            ScrollView {
                Color.clear
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                
                VStack {
                    HStack(spacing: 10) {
                        Image(systemName: "exclamationmark.octagon.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color.ColorSystem.systemRed)
                        
                        Text("WARNING")
                            .font(Font.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.ColorSystem.systemRed)
                    }
                    
                    Text("YOU'RE IN DANGER OF WASTING YOUR POTENTIAL.")
                        .font(Font.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(Color.ColorSystem.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text(viewModel.content.uppercased())
                    .font(Font.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 40, leading: 0, bottom: 40, trailing: 0))
                
                Text("IT'S TIME TO LOCK IN.")
                    .font(Font.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 0))
                
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Spacer()
                        Text("Roger that")
                            .font(Font.FontStyles.headline)
                            .foregroundStyle(Color.ColorSystem.primaryText)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Color.ColorSystem.systemGray6)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .background(Color.ColorSystem.systemBackground)
        }
    }
}

#Preview {
    EmergencyView()
}
