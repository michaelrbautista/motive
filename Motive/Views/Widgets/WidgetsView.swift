//
//  WidgetsView.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI
import WidgetKit
import SuperwallKit

struct WidgetsView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    
    @State var viewModel = WidgetsViewModel()
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.originalQuote)
                        .font(.custom("InterDisplay-Bold", size: 16))
                        .foregroundStyle(Color.white)
                        .lineLimit(5)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    
                    Text(viewModel.originalSource)
                        .font(.custom("InterDisplay-Bold", size: 14))
                        .foregroundStyle(Color.gray)
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                }
                .frame(height: 155)
                .frame(maxWidth: .infinity, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.ColorSystem.systemGray5)
                )
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                // MARK: New quote button
                Button {
                    navigationController.presentSheet(
                        .NewQuoteCoordinatorView(
                            navigationController: $navigationController,
                            userViewModel: $userViewModel,
                            viewModel: $viewModel
                        )
                    )
                } label: {
                    HStack {
                        Spacer()
                        Text("New quote")
                            .font(Font.FontStyles.headline)
                            .foregroundStyle(Color.ColorSystem.primaryText)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Color.ColorSystem.systemGray5)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
            .buttonStyle(.plain)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
            
            // MARK: Image
            VStack(alignment: .leading, spacing: 10) {
                if let image = UIImage(data: viewModel.originalImage) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                } else {
                    Image("goggins")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                }
                
                // MARK: New image button
                Button {
                    navigationController.presentSheet(
                        .NewImageCoordinatorView(
                            navigationController: $navigationController,
                            userViewModel: $userViewModel,
                            viewModel: $viewModel
                        )
                    )
                } label: {
                    HStack {
                        Spacer()
                        Text("New image")
                            .font(Font.FontStyles.headline)
                            .foregroundStyle(Color.ColorSystem.primaryText)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Color.ColorSystem.systemGray5)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
            .buttonStyle(.plain)
            .listRowInsets(EdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
            
            // MARK: Emergency
            Button {
                navigationController.presentSheet(.EmergencyView)
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "exclamationmark.octagon.fill")
                    
                    Text("TAP IF YOU HAVE A SLACK JAWED POOPY PANTS MENTALITY")
                        .font(Font.FontStyles.headline)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(Color.ColorSystem.systemRed)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            .listRowInsets(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Widgets")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("MOTIVE")
                    .font(.custom("InterDisplay-Bold", size: 12))
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
        }
        .onOpenURL { url in
            navigationController.handleDeepLink(url)
        }
        .onAppear {
            print("HERE")
            viewModel.originalQuote = userViewModel.quote ?? ""
            viewModel.originalSource = userViewModel.source ?? ""
            viewModel.originalImage = userViewModel.image ?? Data()
        }
    }
}

#Preview {
    NavigationStack {
        WidgetsView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()))
    }
}
