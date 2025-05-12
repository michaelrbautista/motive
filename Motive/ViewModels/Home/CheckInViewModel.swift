//
//  CheckInViewModel.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

@Observable
final class CheckInViewModel {
    
    var didWell = ""
    var didntDoWell = ""
    var willDoBetter = ""
    
    // MARK: Save check in
    public func saveCheckIn() {
        let newEntry = CheckInEntry(
            didWell: didWell,
            didntDoWell: didntDoWell,
            willDoBetter: willDoBetter
        )
        
        
    }
    
}
