//
//  HomeView.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    
    @State var viewModel = HomeViewModel()
    
    // For testing
    @State var presentTest = false
    
    var body: some View {
        List {
            // MARK: Quote
            VStack(alignment: .leading, spacing: 5) {
                Text(viewModel.quote)
                    .font(Font.FontStyles.title2)
                    .foregroundStyle(Color.ColorSystem.primaryText)
                
                Text(viewModel.source)
                    .font(Font.FontStyles.headline)
                    .foregroundStyle(Color.ColorSystem.systemGray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.ColorSystem.systemGray6)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .onAppear {
                viewModel.quote = userViewModel.quote ?? "Quote"
                viewModel.source = userViewModel.source ?? "Source"
                viewModel.image = userViewModel.image ?? Data()
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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
        .navigationTitle(Date.now.formatted(date: .abbreviated, time: .omitted))
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
            NotificationService.shared.requestNotificationAuth { wasGranted in
                if wasGranted {
                    let checkInTime = UserDefaults.standard.value(forKey: "checkInTime") as? Date
                    NotificationService.shared.scheduleNotification(date: checkInTime)
                }
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
