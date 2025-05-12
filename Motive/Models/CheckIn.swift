//
//  CheckIn.swift
//  Motive
//
//  Created by Michael Bautista on 5/11/25.
//

import SwiftUI
import SwiftData

@Model
class CheckInEntry {
    var date: Date
    var didWell: String
    var didntDoWell: String
    var willDoBetter: String
    
    init(date: Date = Date(), didWell: String, didntDoWell: String, willDoBetter: String) {
        self.date = date
        self.didWell = didWell
        self.didntDoWell = didntDoWell
        self.willDoBetter = willDoBetter
    }
}

extension Date {
    var startOfWeek: Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        return calendar.date(from: components)!
    }

    var endOfWeek: Date {
        let calendar = Calendar.current
        let start = self.startOfWeek
        return calendar.date(byAdding: .day, value: 6, to: start)!
    }
}
