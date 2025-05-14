//
//  HomeView.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    
    @State var viewModel = HomeViewModel()
    
    // For testing
    @State var presentTest = false
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.quotes.indices, id: \.self) { index in
                        VStack {
                            QuoteCell(
                                quote: viewModel.quotes[index].quote,
                                source: viewModel.quotes[index].source
                            )
                            .onAppear {
                                if index == viewModel.quotes.count - 1 {
                                    viewModel.getMoreQuotes()
                                }
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            }
            .ignoresSafeArea()
            .navigationBarTitleDisplayMode(.inline)
            .scrollTargetBehavior(.paging)
            
            Button {
                navigationController.presentSheet(.EmergencyView)
            } label: {
                HStack(spacing: 10) {
                    Image(systemName: "exclamationmark.octagon.fill")
                    
                    Text("TAP IF YOU HAVE A SLACK JAWED POOPY PANTS MENTALITY")
                        .font(Font.FontStyles.headline)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(Color(red: 153/255, green: 31/255, blue: 26/255))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.ColorSystem.systemRed, lineWidth: 2)
                )
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        }
        .toolbar {
            #if DEBUG
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    presentTest.toggle()
                } label: {
                    Text("Test")
                }
            }
            #endif
            
            ToolbarItem(placement: .principal) {
                Text("MOTIVE")
                    .font(.custom("InterDisplay-Bold", size: 12))
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
        }
        .onAppear {
            if viewModel.quotes.count < 5 {
                viewModel.getMoreQuotes()
            }
        }
        .onOpenURL { url in
            navigationController.handleDeepLink(url)
        }
        .sheet(isPresented: $presentTest) {
            TestView()
        }
    }
}

#Preview {
    HomeView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()))
}
