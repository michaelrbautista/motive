//
//  NavigationTypes.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

// MARK: Screen
enum Screen: Identifiable, Hashable {
    // Onboarding
    case LandingPageView(
        navigationController: NavigationController,
        userViewModel: UserViewModel
    )
    case WelcomeView(
        navigationController: NavigationController,
        userViewModel: UserViewModel
    )
    case InspirationView(
        navigationController: NavigationController,
        userViewModel: UserViewModel
    )
    case EnterGoalsView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: OnboardingViewModel
    )
    case LearnView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: OnboardingViewModel
    )
    case PersonalizingView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: OnboardingViewModel
    )
    case CustomizedView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: OnboardingViewModel
    )
    case AddWidgetsView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: OnboardingViewModel
    )
    
    // Auth
    case SignInView(
        navigationController: NavigationController,
        userViewModel: UserViewModel
    )
    case CreateAccountView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: OnboardingViewModel
    )
    case OneTimeCodeView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: OnboardingViewModel,
        isSignIn: Bool
    )
    
    // Home
    case HomeView(
        navigationController: NavigationController,
        userViewModel: UserViewModel
    )
    case FirstCheckInView(
        navigationController: NavigationController,
        sheetNavigationController: SheetNavigationController,
        userViewModel: UserViewModel
    )
    case SecondCheckInView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: CheckInViewModel
    )
    case ThirdCheckInView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: CheckInViewModel
    )
    
    // Widgets
    case WidgetsView(
        navigationController: NavigationController,
        userViewModel: UserViewModel
    )
    case NewQuoteView(
        navigationController: NavigationController,
        sheetNavigationController: SheetNavigationController,
        userViewModel: UserViewModel,
        viewModel: WidgetsViewModel
    )
    case NewImageView(
        navigationController: NavigationController,
        sheetNavigationController: SheetNavigationController,
        userViewModel: UserViewModel,
        viewModel: WidgetsViewModel
    )
    
    // Settings
    case SettingsView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        selectedTopics: [String]
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

// MARK: Sheet
enum Sheet: Identifiable, Hashable {
    // New quote/image
    case NewQuoteCoordinatorView(
        navigationController: NavigationController,
        sheetNavigationController: SheetNavigationController,
        userViewModel: UserViewModel,
        viewModel: WidgetsViewModel
    )
    case NewImageCoordinatorView(
        navigationController: NavigationController,
        sheetNavigationController: SheetNavigationController,
        userViewModel: UserViewModel,
        viewModel: WidgetsViewModel
    )
    case SelectTopicView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        topic: Binding<String>
    )
    case SelectAllTopicsView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        selectedTopics: Binding<[String]>
    )
    case SaveQuoteView(
        navigationController: NavigationController,
        userViewModel: UserViewModel,
        viewModel: WidgetsViewModel
    )
    
    // Check in
    case CheckInCoordinatorView(
        navigationController: NavigationController,
        userViewModel: UserViewModel
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
