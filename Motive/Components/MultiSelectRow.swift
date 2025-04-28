//
//  MultiSelectRow.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct MultiSelectRow: View {
    
    var text: String
    @Binding var setSelection: Set<String>
    var isDisabled: Bool = false
    var onSelect: (() -> Void)
    
    var body: some View {
        if !isDisabled {
            Button {
                onSelect()
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(text)
                            .font(Font.FontStyles.headline)
                            .foregroundStyle(setSelection.contains(text) ? Color.ColorSystem.systemBackground : Color.ColorSystem.primaryText)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    
                    Spacer()
                }
                .background(setSelection.contains(text) ? Color.ColorSystem.primaryText : Color.ColorSystem.systemGray6)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)
        } else {
            HStack {
                VStack(alignment: .leading) {
                    Text(text)
                        .font(Font.FontStyles.headline)
                        .foregroundStyle(Color.ColorSystem.systemGray2)
                        .multilineTextAlignment(.leading)
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                
                Spacer()
            }
            .background(Color.ColorSystem.systemGray6)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    VStack {
        MultiSelectRow(text: "Test option", setSelection: .constant(["Test"]), onSelect: {})
        MultiSelectRow(text: "Test option", setSelection: .constant(["Test"]), isDisabled: true, onSelect: {})
        MultiSelectRow(text: "Test option", setSelection: .constant(["Test option"]), onSelect: {})
    }
}
