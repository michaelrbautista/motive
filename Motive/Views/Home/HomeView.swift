//
//  HomeView.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    
    @State var viewModel = HomeViewModel()
    
    let days = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var currentDay: String {
        let weekdayIndex = Calendar.current.component(.weekday, from: Date()) - 1
        return days[weekdayIndex]
    }
    
    @Query var entries: [CheckInEntry]

    let weekDates: [Date]
    let descriptor: FetchDescriptor<CheckInEntry>
    
    var streak = 23
    
    init(navigationController: Binding<NavigationController>, userViewModel: Binding<UserViewModel>) {
        _navigationController = navigationController
        _userViewModel = userViewModel
        
        let calendar = Calendar.current
        let startOfWeek = Date().startOfWeek
        let endOfWeek = Date().endOfWeek
        
        self.weekDates = (0...6).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
        
        let predicate = #Predicate<CheckInEntry> {
            $0.date >= startOfWeek && $0.date <= endOfWeek
        }
        
        self.descriptor = FetchDescriptor(predicate: predicate, sortBy: [SortDescriptor(\.date)])
        
        self._entries = Query(descriptor)
        
        self.streak = UserDefaults.standard.value(forKey: "streak") as? Int ?? 0
    }
    
    var body: some View {
        List {
            // MARK: Week view
            HStack(spacing: 10) {
                Spacer()
                ForEach(weekDates, id: \.self) { day in
                    let hasEntry = entries.contains {
                        Calendar.current.isDate($0.date, inSameDayAs: day)
                    }
                    let isToday = Calendar.current.isDate(day, inSameDayAs: Date())
                    
                    VStack(spacing: 5) {
                        Rectangle()
                            .fill(hasEntry ? Color.ColorSystem.primaryText : Color.ColorSystem.systemGray6)
                            .frame(width: 35, height: 35)
                            .cornerRadius(5)
                            .overlay(
                                isToday ? RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.ColorSystem.systemBlue, lineWidth: 2) : nil
                            )
                        
                        Text(
                            DateFormatter().weekdaySymbols[Calendar.current.component(.weekday, from: day) - 1].prefix(1)
                        )
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
                navigationController.presentSheet(
                    .CheckInCoordinatorView(
                        navigationController: $navigationController,
                        userViewModel: $userViewModel
                    ))
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
                    viewModel.image = userViewModel.image ?? Data()
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
                    .font(Font.FontStyles.headline)
                    .foregroundStyle(Color.ColorSystem.primaryText)
            }
        }
    }
}

#Preview {
    HomeView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()))
}
