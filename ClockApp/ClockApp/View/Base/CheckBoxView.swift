//
//  CheckBoxView.swift
//  ClockApp
//
//  Created by BS-272 on 9/2/21.
//

import Foundation
import SwiftUI

struct CheckBoxView: View {
    
    let name: String
    @Binding var selected: Bool
    
    var body: some View {
        Button {
            self.$selected.wrappedValue.toggle()
        } label: {
            HStack {
                Image(systemName:  self.$selected.wrappedValue ? "checkmark.square" : "square")
                Text(name)
            }
        }
        .onAppear {
            self.$selected.wrappedValue = false
        }

    }
}
