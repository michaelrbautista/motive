//
//  MotiveWidgetsBundle.swift
//  MotiveWidgets
//
//  Created by Michael Bautista on 4/29/25.
//

import WidgetKit
import SwiftUI

@main
struct MotiveWidgetsBundle: WidgetBundle {
    var body: some Widget {
        MotiveWidgets()
        MotiveWidgetsControl()
        MotiveWidgetsLiveActivity()
    }
}
