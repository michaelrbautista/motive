//
//  NewQuoteView.swift
//  Motive
//
//  Created by Michael Bautista on 5/1/25.
//

import SwiftUI
import WidgetKit

struct NewQuoteView: View {
    
    var navigationController: NavigationController
    var sheetNavigationController: SheetNavigationController
    var userViewModel: UserViewModel
    
    @State var viewModel: WidgetsViewModel
    
    @State var presentConfirmSave = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // MARK: Topic selector
//                TopicSelector(topic: $viewModel.quoteTopic)
                
                MediumWidgetPreview(
                    quote: viewModel.newQuote == "" ? $viewModel.originalQuote : $viewModel.newQuote,
                    source: viewModel.newSource == "" ? $viewModel.originalSource : $viewModel.newSource
                )
                
                HStack(alignment: .top) {
                    SmallWidgetPreview(
                        quote: viewModel.newQuote == "" ? $viewModel.originalQuote : $viewModel.newQuote,
                        source: viewModel.newSource == "" ? $viewModel.originalSource : $viewModel.newSource
                    )
                    
                    LockScreenWidgetPreview(
                        quote: viewModel.newQuote == "" ? $viewModel.originalQuote : $viewModel.newQuote,
                        source: viewModel.newSource == "" ? $viewModel.originalSource : $viewModel.newSource
                    )
                }
                
                // MARK: Generate button
                Button {
                    Task {
                        await viewModel.generateNewQuote()
                    }
                } label: {
                    HStack {
                        Spacer()
                        if viewModel.quoteIsLoading {
                            ProgressView()
                                .tint(Color.ColorSystem.primaryText)
                        } else {
                            Text("Generate")
                                .font(Font.FontStyles.headline)
                                .foregroundStyle(Color.ColorSystem.primaryText)
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Color.ColorSystem.systemBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .disabled(viewModel.quoteIsLoading)
                
                Spacer()
            }
            .padding(EdgeInsets(top: 40, leading: 20, bottom: 0, trailing: 20))
            .background(Color.ColorSystem.systemBackground)
            .navigationTitle("New Quote")
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
                            .foregroundStyle(viewModel.quoteIsLoading ? Color.ColorSystem.systemGray5 : Color.ColorSystem.systemBlue)
                    }
                    .disabled(!viewModel.hasGeneratedQuote || viewModel.quoteIsLoading)
                }
            }
            .alert(Text("Are you sure you want to save? This will overwrite the current quote."), isPresented: $presentConfirmSave) {
                Button(role: .cancel) {} label: {
                    Text("Cancel")
                }
                
                Button(role: .none) {
                    // Save quote
                    QuoteService.shared.saveQuote(quote: viewModel.newQuote, source: viewModel.newSource)
                    
                    viewModel.originalQuote = viewModel.newQuote
                    viewModel.originalSource = viewModel.newSource
                    userViewModel.quote = viewModel.newQuote
                    userViewModel.source = viewModel.newSource
                    
                    viewModel.newQuote = ""
                    viewModel.newSource = ""
                    
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
    NewQuoteView(navigationController: NavigationController(), sheetNavigationController: SheetNavigationController(), userViewModel: UserViewModel(), viewModel: WidgetsViewModel())
}
