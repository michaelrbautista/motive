//
//  NavigationTypes.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

enum Screen: Identifiable, Hashable {
    // MARK: Onboarding
    case LandingPageView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    case WelcomeView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    case InspirationView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    case LearnView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>
    )
    case EnterGoalsView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>
    )
    case PreventingView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>
    )
    case AccountableView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>
    )
    case ReminderView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>
    )
    case PersonalizingView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>
    )
    case CustomizedView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>
    )
    case AddWidgetsView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>
    )
    
    // MARK: Auth
    case SignInView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    case CreateAccountView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>
    )
    case OneTimeCodeView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<OnboardingViewModel>,
        isSignIn: Bool
    )
    
    // MARK: Home
    case HomeView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    
    // MARK: Check in
    case FirstCheckInView(
        navigationController: Binding<NavigationController>,
        sheetNavigationController: Binding<SheetNavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    case SecondCheckInView(
        navigationController: Binding<NavigationController>,
        sheetNavigationController: Binding<SheetNavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<CheckInViewModel>
    )
    case ThirdCheckInView(
        navigationController: Binding<NavigationController>,
        sheetNavigationController: Binding<SheetNavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<CheckInViewModel>
    )
    
    // MARK: Widgets
    case WidgetsView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    case NewQuoteView(
        navigationController: Binding<NavigationController>,
        sheetNavigationController: Binding<SheetNavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<WidgetsViewModel>
    )
    case NewImageView(
        navigationController: Binding<NavigationController>,
        sheetNavigationController: Binding<SheetNavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<WidgetsViewModel>
    )
    
    // MARK: Settings
    case SettingsView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    
    var id: Self { return self }
}

extension Screen {
    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        switch self {
        default:
            hasher.combine("Default")
        }
    }
    
    // Conform to Equatable
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        switch (lhs, rhs) {
        default:
            return true
        }
    }
}

enum Sheet: Identifiable, Hashable {
    // MARK: New quote/image
    case NewQuoteCoordinatorView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<WidgetsViewModel>
    )
    case NewImageCoordinatorView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>,
        viewModel: Binding<WidgetsViewModel>
    )
    
    // MARK: Check in
    case CheckInCoordinatorView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    
    // MARK: Reminder time
    case CheckInTimeView(
        navigationController: Binding<NavigationController>,
        userViewModel: Binding<UserViewModel>
    )
    
    var id: Self { return self }
    
    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        switch self {
        default:
            hasher.combine("Default")
        }
    }
    
    // Conform to Equatable
    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        switch (lhs, rhs) {
        default:
            return true
        }
    }
}
