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
@Observable
class NavigationController: CoordinatorProtocol {
    var path: NavigationPath = NavigationPath()
    var sheet: Sheet? = nil
    
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
    
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        // MARK: Onboarding
        case .LandingPageView(let navigationController, let userViewModel):
            LandingPageView(
                navigationController: navigationController,
                userViewModel: userViewModel
            )
        case .WelcomeView(let navigationController, let userViewModel):
            WelcomeView(
                navigationController: navigationController,
                userViewModel: userViewModel
            )
        case .InspirationView(let navigationController, let userViewModel):
            InspirationView(
                navigationController: navigationController,
                userViewModel: userViewModel
            )
        case .LearnView(let navigationController, let userViewModel, let viewModel):
            LearnView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .EnterGoalsView(let navigationController, let userViewModel, let viewModel):
            EnterGoalsView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .PreventingView(let navigationController, let userViewModel, let viewModel):
            PreventingView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .AccountableView(let navigationController, let userViewModel, let viewModel):
            AccountableView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .ReminderView(let navigationController, let userViewModel, let viewModel):
            ReminderView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .PersonalizingView(let navigationController, let userViewModel, let viewModel):
            PersonalizingView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .CustomizedView(let navigationController, let userViewModel, let viewModel):
            CustomizedView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .AddWidgetsView(let navigationController, let userViewModel, let viewModel):
            AddWidgetsView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
            
        // MARK: Auth
        case .SignInView(let navigationController, let userViewModel):
            SignInView(
                navigationController: navigationController,
                userViewModel: userViewModel
            )
        case .CreateAccountView(let navigationController, let userViewModel, let viewModel):
            CreateAccountView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .OneTimeCodeView(let navigationController, let userViewModel, let viewModel, let isSignIn):
            OneTimeCodeView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel,
                isSignIn: isSignIn
            )
            
        // MARK: Home
        case .HomeView(let navigationController, let userViewModel):
            HomeView(
                navigationController: navigationController,
                userViewModel: userViewModel
            )
            
        // MARK: Widgets
        case .WidgetsView(let navigationController, let userViewModel):
            WidgetsView(
                navigationController: navigationController,
                userViewModel: userViewModel
            )
        case .NewQuoteView(let navigationController, let sheetNavigationController, let userViewModel, let viewModel):
            NewQuoteView(
                navigationController: navigationController,
                sheetNavigationController: sheetNavigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .NewImageView(let navigationController, let sheetNavigationController, let userViewModel, let viewModel):
            NewImageView(
                navigationController: navigationController,
                sheetNavigationController: sheetNavigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
            
        // MARK: Settings
        case .SettingsView(let navigationController, let userViewModel):
            SettingsView(
                navigationController: navigationController,
                userViewModel: userViewModel
            )
            
        default:
            Text("Navigation Error")
        }
    }
    
    @ViewBuilder
    func build(_ sheet: Sheet) -> some View {
        switch sheet {
        // MARK: New quote/image coordinators
        case .NewQuoteCoordinatorView(let navigationController, let userViewModel, let viewModel):
            NewQuoteCoordinatorView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .NewImageCoordinatorView(let navigationController, let userViewModel, let viewModel):
            NewImageCoordinatorView(
                navigationController: navigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
            
        // MARK: Check in coordinator
        case .CheckInCoordinatorView(let navigationController, let userViewModel):
            CheckInCoordinatorView(
                navigationController: navigationController,
                userViewModel: userViewModel
            )
            
        // MARK: Check in time
        case .CheckInTimeView(let navigationController, let userViewModel):
            CheckInTimeView(navigationController: navigationController, userViewModel: userViewModel)
        }
    }
}

// MARK: Sheet navigation controller
@Observable
class SheetNavigationController: CoordinatorProtocol {
    var path: NavigationPath = NavigationPath()
    var sheet: Sheet? = nil
    
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
    
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        // MARK: New quote/image
        case .NewQuoteView(let navigationController, let sheetNavigationController, let userViewModel, let viewModel):
            NewQuoteView(
                navigationController: navigationController,
                sheetNavigationController: sheetNavigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .NewImageView(let navigationController, let sheetNavigationController, let userViewModel, let viewModel):
            NewImageView(
                navigationController: navigationController,
                sheetNavigationController: sheetNavigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
            
        // MARK: Check in
        case .FirstCheckInView(let navigationController, let sheetNavigationController, let userViewModel):
            FirstCheckInView(
                navigationController: navigationController,
                sheetNavigationController: sheetNavigationController,
                userViewModel: userViewModel
            )
        case .SecondCheckInView(let navigationController, let sheetNavigationController, let userViewModel, let viewModel):
            SecondCheckInView(
                navigationController: navigationController,
                sheetNavigationController: sheetNavigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        case .ThirdCheckInView(let navigationController, let sheetNavigationController, let userViewModel, let viewModel):
            ThirdCheckInView(
                navigationController: navigationController,
                sheetNavigationController: sheetNavigationController,
                userViewModel: userViewModel,
                viewModel: viewModel
            )
        default:
            Text("Navigation Error")
        }
    }
    
    // MARK: Sheet views
    @ViewBuilder
    func build(_ sheet: Sheet) -> some View {
        switch sheet {
        default:
            Text("Navigation Error")
        }
    }
}
