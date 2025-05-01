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
    var fullScreenCover: FullScreenCover? { get set }

    func push(_ screen:  Screen)
    func pop()
    func popToRoot()
    func presentSheet(_ sheet: Sheet)
    func dismissSheet()
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover)
    func dismissFullScreenCover()
}

// MARK: Navigation controller
class NavigationController: CoordinatorProtocol {
    @Published var path: NavigationPath = NavigationPath()
    @Published var sheet: Sheet? = nil
    @Published var fullScreenCover: FullScreenCover? = nil
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func presentSheet(_ sheet: Sheet) {
        self.sheet = sheet
    }
    
    func presentFullScreenCover(_ fullScreenCover: FullScreenCover) {
        self.fullScreenCover = fullScreenCover
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
    
    func dismissFullScreenCover() {
        self.fullScreenCover = nil
    }
    
    // MARK: - Screen views
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        // Onboarding
        case .LandingPageView:
            LandingPageView()
        case .AmbitionView:
            AmbitionView()
        case .InspirationView:
            InspirationView()
        case .EnterGoalsView(let viewModel):
            EnterGoalsView(viewModel: viewModel)
        case .SelectReligionView(let viewModel):
            SelectReligionView(viewModel: viewModel)
        case .PersonalizingView(let viewModel):
            PersonalizingView(viewModel: viewModel)
        case .CustomizedView(let viewModel):
            CustomizedView(viewModel: viewModel)
        case .WidgetsView(let viewModel):
            WidgetsView(viewModel: viewModel)
            
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
            
        // Settings
        case .SettingsView(let selectedTopics):
            SettingsView(selectedTopics: selectedTopics)
        }
    }
    
    // MARK: Sheet views
    @ViewBuilder
    func build(_ sheet: Sheet) -> some View {
        switch sheet {
        case .SelectTopicView(let topic):
            SelectTopicView(topic: topic)
        case .SelectAllTopicsView(let selectedTopics):
            SelectAllTopicsView(selectedTopics: selectedTopics)
        }
    }
    
    // MARK: Fullscreen cover views
    @ViewBuilder
    func build(_ fullScreenCover: FullScreenCover) -> some View {
        switch fullScreenCover {
        default:
            Text("Full screen view")
        }
    }
}
