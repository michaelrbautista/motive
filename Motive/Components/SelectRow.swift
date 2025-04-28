//
//  SelectRow.swift
//  Motive
//
//  Created by Michael Bautista on 4/27/25.
//

import SwiftUI

struct SelectRow: View {
    
    var text: String
    var subtext: String?
    @Binding var selection: String
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
                            .foregroundStyle(selection == text ? Color.ColorSystem.systemBackground : Color.ColorSystem.primaryText)
                            .multilineTextAlignment(.leading)
                        if subtext != nil {
                            Text(subtext!)
                                .font(Font.FontStyles.callout)
                                .foregroundStyle(selection == text ? Color.ColorSystem.systemBackground : Color.ColorSystem.systemGray)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    
                    Spacer()
                }
                .background(selection == text ? Color.ColorSystem.primaryText : Color.ColorSystem.systemGray6)
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
                    if subtext != nil {
                        Text(subtext!)
                            .font(Font.FontStyles.callout)
                            .foregroundStyle(Color.ColorSystem.systemGray3)
                            .multilineTextAlignment(.leading)
                    }
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
        SelectRow(text: "Test option", selection: .constant("Test"), onSelect: {})
        SelectRow(text: "Test option", selection: .constant("Test"), isDisabled: true, onSelect: {})
        SelectRow(text: "Test option", selection: .constant("Test option"), onSelect: {})
    }
}
