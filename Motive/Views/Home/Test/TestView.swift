//
//  TestView.swift
//  Motive
//
//  Created by Michael Bautista on 5/12/25.
//

import SwiftUI

struct TestView: View {
    
    @State var viewModel = TestViewModel()
    
    var body: some View {
        List {
            Button {
                viewModel.testNotification()
            } label: {
                Text("Test notification")
            }

        }
    }
}

#Preview {
    TestView()
}
