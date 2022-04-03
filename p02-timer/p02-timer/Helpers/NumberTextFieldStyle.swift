//
//  NumberTextFieldStyle.swift
//  p02-timer
//
//  Created by Samuel Shi on 2/27/22.
//

import SwiftUI

struct NumberTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .padding()
            .font(.title)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(uiColor: .secondarySystemBackground), lineWidth: 3)
            )
    }
}
