//
//  HomeView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import WidgetKit

struct HomeView: View {
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var userViewModel: UserViewModel
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            // MARK: Topic selector
            TopicSelector(viewModel: viewModel).padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            
            Spacer()
            
            // MARK: Quote
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.quote)
                    .font(.custom("InterDisplay-Bold", size: 24))
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(viewModel.source)
                    .font(.custom("InterDisplay-Bold", size: 16))
                    .foregroundStyle(Color.ColorSystem.systemGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .onAppear {
                viewModel.quote = userViewModel.quote ?? ""
                viewModel.source = userViewModel.source ?? ""
            }
            
            Spacer()
            
            // MARK: Generate button
            Button {
                Task {
                    await viewModel.generateNewQuote()
                }
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
            ToolbarItem(placement: .principal) {
                Text("MOTIVE")
                    .font(.custom("InterDisplay-Bold", size: 12))
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigationController.presentSheet(.SaveQuoteView(viewModel: viewModel))
                } label: {
                    Text("Save")
                        .foregroundStyle(!viewModel.hasGenerated || viewModel.isLoading ? Color.ColorSystem.systemGray : Color.ColorSystem.primaryText)
                }
                .disabled(!viewModel.hasGenerated || viewModel.isLoading)
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
    NavigationStack {
        HomeView()
    }
}
