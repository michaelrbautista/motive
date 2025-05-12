//
//  HomeView.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    var navigationController: NavigationController
    var userViewModel: UserViewModel
    
    @Environment(\.modelContext) private var modelContext
    
    @State var viewModel = HomeViewModel()
    
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var currentDay: String {
        let weekdayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        return days[weekdayIndex]
    }
    
    var streak = 23
    
    var body: some View {
        List {
            // MARK: Week view
            HStack(spacing: 10) {
                Spacer()
                ForEach(0..<7, id: \.self) { index in
                    VStack(spacing: 5) {
                        Rectangle()
                            .fill(Color.ColorSystem.systemGray6)
                            .frame(width: 35, height: 35)
                            .cornerRadius(5)
                            .overlay(
                                days[index] == currentDay ? RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.ColorSystem.systemBlue, lineWidth: 2) : nil
                            )
                        
                        Text(days[index].prefix(1))
                            .font(Font.FontStyles.callout)
                            .foregroundColor(Color.ColorSystem.primaryText)
                            .frame(width: 35, height: 25)
                    }
                }
                Spacer()
            }
            .listRowInsets(EdgeInsets(top: 20, leading: 20, bottom: 40, trailing: 20))
            .listRowSeparator(.hidden)
            
            // MARK: Check in button
            Button {
                navigationController.presentSheet(.CheckInCoordinatorView)
            } label: {
                HStack {
                    Spacer()
                    Text("Complete today's check in")
                        .font(Font.FontStyles.headline)
                        .foregroundStyle(Color.ColorSystem.primaryText)
                    Spacer()
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(Color.ColorSystem.systemBlue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
            .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 40, trailing: 20))
            .listRowSeparator(.hidden)
            
            VStack(spacing: 20) {
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
                }
                
                // MARK: Image
                if let image = UIImage(data: viewModel.image) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else {
                    Image("goggins")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 170)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(Date.now.formatted(date: .abbreviated, time: .omitted))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("MOTIVE")
                    .font(.custom("InterDisplay-Bold", size: 12))
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Text("\(streak) 🔥")
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(UserViewModel())
}
