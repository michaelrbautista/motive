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
    case LandingPageView
    case WelcomeView
    case InspirationView
    case EnterGoalsView(viewModel: OnboardingViewModel)
    case LearnView(viewModel: OnboardingViewModel)
    case PersonalizingView(viewModel: OnboardingViewModel)
    case CustomizedView(viewModel: OnboardingViewModel)
    case AddWidgetsView(viewModel: OnboardingViewModel)
    
    // Auth
    case SignInView
    case CreateAccountView(viewModel: OnboardingViewModel)
    case OneTimeCodeView(viewModel: OnboardingViewModel, isSignIn: Bool)
    
    // Widgets
    case WidgetsView
    case NewQuoteView(viewModel: WidgetsViewModel)
    case NewImageView(viewModel: WidgetsViewModel)
    
    // Settings
    case SettingsView(selectedTopics: [String])
    
    var id: Self { return self }
}

extension Screen {
    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        switch self {
        case .OneTimeCodeView:
            hasher.combine("OneTimeCodeView")
        default:
            break
        }
    }
    
    // Conform to Equatable
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        switch (lhs, rhs) {
        case (.OneTimeCodeView, .OneTimeCodeView):
            return true
        default:
            return true
        }
    }
}

// MARK: Sheet
enum Sheet: Identifiable, Hashable {
    
    case NewQuoteCoordinatorView(viewModel: WidgetsViewModel)
    case NewImageCoordinatorView(viewModel: WidgetsViewModel)
    case SelectTopicView(topic: Binding<String>)
    case SelectAllTopicsView(selectedTopics: Binding<[String]>)
    case SaveQuoteView(viewModel: WidgetsViewModel)
    
    var id: Self { return self }
    
    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        switch self {
        case .NewQuoteCoordinatorView:
            hasher.combine("NewQuoteCoordinatorView")
        case .NewImageCoordinatorView:
            hasher.combine("NewImageCoordinatorView")
        case .SelectTopicView:
            hasher.combine("SelectTopicView")
        case .SelectAllTopicsView:
            hasher.combine("SelectAllTopicsView")
        case .SaveQuoteView:
            hasher.combine("SaveQuoteView")
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

// MARK: Full screen cover
enum FullScreenCover: Identifiable, Hashable {
    
    case ShareView
    
    var id: Self { return self }
}

extension FullScreenCover {
    // Conform to Hashable
    func hash(into hasher: inout Hasher) {
        switch self {
        case .ShareView:
            hasher.combine("ShareView")
        }
    }
    
    // Conform to Equatable
    static func == (lhs: FullScreenCover, rhs: FullScreenCover) -> Bool {
        switch (lhs, rhs) {
        case (.ShareView, .ShareView):
            return true
        }
    }
}
