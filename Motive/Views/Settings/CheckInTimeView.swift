//
//  CheckInTimeView.swift
//  Motive
//
//  Created by Michael Bautista on 5/12/25.
//

import SwiftUI

struct CheckInTimeView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    
    @State var reminderTime: Date = {
        let defaultTime = UserDefaults.standard.value(forKey: "reminderTime") as? Date
        
        if let time = defaultTime {
            return time
        } else {
            var components = DateComponents()
            components.hour = 20
            components.minute = 0
            return Calendar.current.date(from: components) ?? Date()
        }
    }()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                HStack {
                    Text("Select a time")
                        .font(Font.FontStyles.body)
                        .foregroundStyle(Color.ColorSystem.systemGray)
                    Spacer()
                    DatePicker("Pick a time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.automatic)
                        .labelsHidden()
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                .background(Color.ColorSystem.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                Spacer()
            }
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .background(Color.ColorSystem.systemBackground)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        navigationController.dismissSheet()
                    } label: {
                        Text("Cancel")
                    }

                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                            if let error = error {
                                print("Notification permission error: \(error.localizedDescription)")
                            }
                            
                            UserDefaults.standard.set(reminderTime, forKey: "reminderTime")
                            
                            navigationController.dismissSheet()
                        }
                    } label: {
                        Text("Save")
                            .foregroundStyle(Color.ColorSystem.systemBlue)
                    }
                }
            }
        }
    }
}

#Preview {
    CheckInTimeView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()))
}
