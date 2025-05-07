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
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var userViewModel: UserViewModel
    
    @StateObject var viewModel = WidgetsViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                // MARK: Quote
                Text("Quote")
                    .font(Font.FontStyles.title2)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    .onAppear {
                        viewModel.originalQuote = userViewModel.quote ?? ""
                        viewModel.originalSource = userViewModel.source ?? ""
                    }
                
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
                    navigationController.presentSheet(.NewQuoteCoordinatorView(viewModel: viewModel))
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
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 20))
            }
            
            // MARK: Image
            VStack(alignment: .leading, spacing: 10) {
                Text("Image")
                    .font(Font.FontStyles.title2)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    .onAppear {
                        viewModel.originalImage = userViewModel.image ?? Data()
                    }
                
                if let image = UIImage(data: viewModel.originalImage) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                } else {
                    Image("davidGoggins")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                }
                
                // MARK: New image button
                Button {
                    navigationController.presentSheet(.NewImageCoordinatorView(viewModel: viewModel))
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
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 20))
            }
            
            Spacer()
        }
        .listStyle(.insetGrouped)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Widgets")
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("MOTIVE")
                    .font(.custom("InterDisplay-Bold", size: 12))
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
        }
    }
}

#Preview {
    NavigationStack {
        WidgetsView()
            .environmentObject(UserViewModel())
    }
}
