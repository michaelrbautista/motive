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
    public func saveCheckIn(using context: ModelContext) {
        let newEntry = CheckInEntry(
            didWell: didWell,
            didntDoWell: didntDoWell,
            willDoBetter: willDoBetter
        )
        
        context.insert(newEntry)
        
        let lastCheckIn = UserDefaults.standard.value(forKey: "lastCheckIn") as? Date
        
        if lastCheckIn != nil {
            let streak = UserDefaults.standard.value(forKey: "streak") as? Int ?? 0
            UserDefaults.standard.set(streak + 1, forKey: "streak")
            UserDefaults.standard.set(Date.now, forKey: "lastCheckIn")
        } else {
            UserDefaults.standard.set(1, forKey: "streak")
            UserDefaults.standard.set(Date.now, forKey: "lastCheckIn")
        }
    }
    
}
