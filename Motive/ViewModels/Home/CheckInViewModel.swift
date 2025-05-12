//
//  CheckInViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

final class CheckInViewModel: ObservableObject {
    
    @Published var didWell = ""
    @Published var didntDoWell = ""
    @Published var willDoBetter = ""
    
    // MARK: Save check in
    public func saveCheckIn() {
        let newEntry = CheckInEntry(
            didWell: didWell,
            didntDoWell: didntDoWell,
            willDoBetter: willDoBetter
        )
        
        
    }
    
}
