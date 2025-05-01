//
//  HomeView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var userViewModel: UserViewModel
    
    @StateObject var viewModel = HomeViewModel()
    
    @State var presentConfirmSave = false
    
    var body: some View {
        VStack {
            // MARK: Topic selector
            TopicSelector(viewModel: viewModel).padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            Spacer()
            
            // MARK: Mock ups
            VStack(spacing: 20) {
                // MARK: Medium
                VStack(alignment: .leading, spacing: 5) {
                    Text("MEDIUM")
                        .font(Font.FontStyles.footnote)
                        .foregroundStyle(Color.ColorSystem.systemGray)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    
                    Text(viewModel.quote == "" ? "Quote goes here" : viewModel.quote)
                        .italic()
                        .font(Font.system(size: 16))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .frame(height: 155)
                        .frame(maxWidth: .infinity)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.ColorSystem.systemGray5)
                        )
                }
                
                HStack(alignment: .top) {
                    // MARK: Small
                    VStack(alignment: .leading, spacing: 5) {
                        Text("SMALL")
                            .font(Font.FontStyles.footnote)
                            .foregroundStyle(Color.ColorSystem.systemGray)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        
                        Text(viewModel.quote == "" ? "Quote goes here" : viewModel.quote)
                            .italic()
                            .font(Font.system(size: 14))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .frame(height: 155)
                            .frame(maxWidth: .infinity)
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
                        
                        Text(viewModel.quote == "" ? "Quote goes here" : viewModel.quote)
                            .font(Font.system(size: 12))
                            .foregroundStyle(Color.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.ColorSystem.systemGray5)
                            )
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
            Spacer()
            
            // MARK: Generate button
            Button {
                viewModel.generateNewQuote()
            } label: {
                HStack {
                    Spacer()
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(Color.ColorSystem.primaryText)
                    } else {
                        Text("Generate")
                            .font(Font.FontStyles.headline)
                            .foregroundStyle(viewModel.topic == "" ? Color.ColorSystem.systemGray : Color.ColorSystem.primaryText)
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(viewModel.topic == "" ? Color.ColorSystem.systemGray6 : Color.ColorSystem.systemBlue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 40, trailing: 20))
            .disabled(viewModel.topic == "" || viewModel.isLoading)
        }
        .listStyle(.insetGrouped)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(formattedDate)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    presentConfirmSave.toggle()
                } label: {
                    Text("Save")
                        .foregroundStyle(viewModel.quote == "" ? Color.ColorSystem.systemGray : Color.ColorSystem.primaryText)
                }
                .disabled(viewModel.quote == "" || viewModel.isLoading)
            }
        }
        .alert(Text("Are you sure you want to save? This will overwrite the current quote."), isPresented: $presentConfirmSave) {
            Button(role: .cancel) {
                
            } label: {
                Text("Cancel")
            }

            
            Button(role: .none) {
                // Overwrite current quote
                
            } label: {
                Text("Save")
            }
        }
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d" // "Wed, Apr 30"
        return formatter.string(from: Date())
    }
}

#Preview {
    HomeView()
}
