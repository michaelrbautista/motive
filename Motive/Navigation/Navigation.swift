//
//  Navigation.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

// MARK: Coordinator protocols
protocol CoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    var sheet: Sheet? { get set }

    func push(_ screen:  Screen)
    func pop()
    func popToRoot()
    func presentSheet(_ sheet: Sheet)
    func dismissSheet()
}

// MARK: Navigation controller
class NavigationController: CoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet? = nil
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    // MARK: - Screen views
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        // Onboarding
        case .LandingPageView(let navigationController, let userViewModel):
            LandingPageView(navigationController: navigationController)
        case .WelcomeView:
            WelcomeView()
        case .InspirationView:
            InspirationView()
        case .EnterGoalsView(let viewModel):
            EnterGoalsView(viewModel: viewModel)
        case .LearnView(let viewModel):
            LearnView(viewModel: viewModel)
        case .PersonalizingView(let viewModel):
            PersonalizingView(viewModel: viewModel)
        case .CustomizedView(let viewModel):
            CustomizedView(viewModel: viewModel)
        case .AddWidgetsView(let viewModel):
            AddWidgetsView(viewModel: viewModel)
            
        // Auth
        case .SignInView:
            SignInView()
        case .CreateAccountView(let viewModel):
            CreateAccountView(viewModel: viewModel)
        case .OneTimeCodeView(let viewModel, let isSignIn):
            OneTimeCodeView(viewModel: viewModel, isSignIn: isSignIn)
            
        // Home
        case .HomeView:
            HomeView()
        case .FirstCheckInView:
            FirstCheckInView()
        case .SecondCheckInView(let viewModel):
            SecondCheckInView(viewModel: viewModel)
        case .ThirdCheckInView(let viewModel):
            ThirdCheckInView(viewModel: viewModel)
            
        // Widgets
        case .WidgetsView:
            WidgetsView()
        case .NewQuoteView(let viewModel):
            NewQuoteView(viewModel: viewModel)
        case .NewImageView(let viewModel):
            NewImageView(viewModel: viewModel)
            
        // Settings
        case .SettingsView(let selectedTopics):
            SettingsView(selectedTopics: selectedTopics)
        }
    }
    
    // MARK: Sheet views
    @ViewBuilder
    func build(_ sheet: Sheet) -> some View {
        switch sheet {
        case .NewQuoteCoordinatorView(let viewModel):
            NewQuoteCoordinatorView(viewModel: viewModel)
        case .NewImageCoordinatorView(let viewModel):
            NewImageCoordinatorView(viewModel: viewModel)
        case .SelectTopicView(let topic):
            SelectTopicView(topic: topic)
        case .SelectAllTopicsView(let selectedTopics):
            SelectAllTopicsView(selectedTopics: selectedTopics)
        case .SaveQuoteView(let viewModel):
            NewQuoteView(viewModel: viewModel)
        case .CheckInCoordinatorView:
            CheckInCoordinatorView()
        }
    }
}

// MARK: Sheet navigation controller
class SheetNavigationController: CoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet? = nil
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func dismissSheet() {
        self.sheet = nil
    }
    
    // MARK: - Screen views
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        // New quote/image
        case .NewQuoteView(let viewModel):
            NewQuoteView(viewModel: viewModel)
        case .NewImageView(let viewModel):
            NewImageView(viewModel: viewModel)
            
        // Check in
        case .FirstCheckInView:
            FirstCheckInView()
        case .SecondCheckInView(let viewModel):
            SecondCheckInView(viewModel: viewModel)
        case .ThirdCheckInView(let viewModel):
            ThirdCheckInView(viewModel: viewModel)
        default:
            Text("Error")
        }
    }
    
    // MARK: Sheet views
    @ViewBuilder
    func build(_ sheet: Sheet) -> some View {
        switch sheet {
        case .SelectTopicView(let topic):
            SelectTopicView(topic: topic)
        default:
            Text("Error")
        }
    }
}
