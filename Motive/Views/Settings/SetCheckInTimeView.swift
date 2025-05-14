//
//  SetCheckInTimeView.swift
//  Motive
//
//  Created by Michael Bautista on 5/12/25.
//

import SwiftUI

struct SetCheckInTimeView: View {
    
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    
    @State var checkInTime: Date = {
        let defaultTime = UserDefaults.standard.value(forKey: "checkInTime") as? Date
        
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
                    DatePicker("Pick a time", selection: $checkInTime, displayedComponents: .hourAndMinute)
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
                        NotificationService.shared.scheduleNotification(date: checkInTime)
                        
                        navigationController.dismissSheet()
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
    SetCheckInTimeView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()))
}
