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

extension Calendar {
    func startOfWeek(for date: Date = Date()) -> Date? {
        self.dateInterval(of: .weekOfYear, for: date)?.start
    }
}
