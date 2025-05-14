//
//  CheckInTimeView.swift
//  Motive
//
//  Created by Michael Bautista on 5/12/25.
//

import SwiftUI
import UserNotifications

struct CheckInTimeView: View {
    @Binding var navigationController: NavigationController
    @Binding var userViewModel: UserViewModel
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Text("What time do you want to do your daily check in?")
                .font(Font.FontStyles.title1)
                .foregroundStyle(Color.ColorSystem.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            HStack {
                Text("Select a time")
                    .font(Font.FontStyles.body)
                    .foregroundStyle(Color.ColorSystem.systemGray)
                Spacer()
                DatePicker("Pick a time", selection: $viewModel.checkInTime, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.automatic)
                    .labelsHidden()
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color.ColorSystem.systemGray6)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
            StyledButton(
                variant: .primary,
                text: "Next",
                isLoading: .constant(false)
            ) {
                NotificationService.shared.requestNotificationAuth { wasGranted in
                    navigationController.push(
                        .PersonalizingView(
                            navigationController: $navigationController,
                            userViewModel: $userViewModel,
                            viewModel: $viewModel
                        )
                    )
                }
            }

        }
        .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    NotificationService.shared.requestNotificationAuth { wasGranted in
                        if !wasGranted {
                           viewModel.sendReminder = false
                        }
                        
                        navigationController.push(
                            .PersonalizingView(
                                navigationController: $navigationController,
                                userViewModel: $userViewModel,
                                viewModel: $viewModel
                            )
                        )
                    }
                } label: {
                    Text("Skip")
                        .foregroundStyle(Color.ColorSystem.systemGray)
                }
            }
        }
    }
}

#Preview {
    CheckInTimeView(navigationController: .constant(NavigationController()), userViewModel: .constant(UserViewModel()), viewModel: .constant(OnboardingViewModel()))
}
