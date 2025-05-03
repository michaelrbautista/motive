//
//  SaveQuoteView.swift
//  Motive
//
//  Created by Michael Bautista on 5/1/25.
//

import SwiftUI
import WidgetKit

struct SaveQuoteView: View {
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var userViewModel: UserViewModel
    
    @StateObject var viewModel: HomeViewModel
    
    @State var presentConfirmSave = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Widgets")
                        .font(Font.FontStyles.title1)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                    
                    // MARK: Medium
                    VStack(alignment: .leading, spacing: 5) {
                        Text("MEDIUM")
                            .font(Font.FontStyles.footnote)
                            .foregroundStyle(Color.ColorSystem.systemGray)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(
                                viewModel.quote == "" ? "Circumstances don't make the man, they only reveal him to himself." : viewModel.quote
                            )
                            .font(.custom("InterDisplay-Bold", size: 16))
                            .foregroundStyle(Color.white)
                            .lineLimit(5)
                            
                            Text(
                                viewModel.source == "" ? "Epictetus" : viewModel.source
                            )
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
                            Text(
                                viewModel.quote == "" ? "Circumstances don't make the man, they only reveal him to himself." : viewModel.quote
                            )
                            .font(.custom("InterDisplay-Bold", size: 14))
                            .foregroundStyle(Color.white)
                            .lineLimit(5)
                            
                            Text(
                                viewModel.source == "" ? "Epictetus" : viewModel.source
                            )
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
                            Text(
                                viewModel.source == "" ? "Epictetus" : viewModel.source
                            )
                            .font(.custom("InterDisplay-Bold", size: 12))
                            .foregroundStyle(Color.white)
                            .lineLimit(1)
                            
                            Text(
                                viewModel.quote == "" ? "Circumstances don't make the man, they only reveal him to himself." : viewModel.quote
                            )
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
            .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20))
            .background(Color.ColorSystem.systemBackground)
            .navigationTitle("Preview")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        navigationController.dismissSheet()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(Color.ColorSystem.primaryText)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        presentConfirmSave.toggle()
                    } label: {
                        Text("Save")
                            .foregroundStyle(Color.ColorSystem.systemBlue)
                    }
                }
            }
            .alert(Text("Are you sure you want to save? This will overwrite the current quote."), isPresented: $presentConfirmSave) {
                Button(role: .cancel) {} label: {
                    Text("Cancel")
                }
                
                Button(role: .none) {
                    QuoteService.shared.saveQuote(quote: viewModel.quote, source: viewModel.source)
                    
                    navigationController.dismissSheet()
                } label: {
                    Text("Save")
                        .foregroundStyle(Color.ColorSystem.systemBlue)
                }
            }
        }
    }
}

#Preview {
    SaveQuoteView(viewModel: HomeViewModel())
}
