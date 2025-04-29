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
    
    var body: some View {
        List {
            Section {
                Button {
                    navigationController.presentSheet(.SelectTopicView(topic: $viewModel.topic))
                } label: {
                    HStack {
                        if viewModel.topic == "" {
                            Text("Select")
                                .font(Font.FontStyles.body)
                                .foregroundStyle(Color.ColorSystem.systemGray)
                        } else {
                            Text(viewModel.topic)
                                .font(Font.FontStyles.body)
                                .foregroundStyle(Color.ColorSystem.primaryText)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 12)
                            .foregroundStyle(Color.ColorSystem.systemGray2)
                            .fontWeight(.bold)
                    }
                }
            } header: {
                Text("Topic")
            }
            
            Section {
                Button {
                    
                } label: {
                    HStack {
                        Spacer()
                        Text("Generate")
                            .font(Font.FontStyles.headline)
                            .foregroundStyle(Color.ColorSystem.primaryText)
                        Spacer()
                    }
                }
                .listRowBackground(Color.ColorSystem.systemBlue)
            }
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    HomeView()
}
