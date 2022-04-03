//
//  CircularButton.swift
//  p02-timer
//
//  Created by Samuel Shi on 2/27/22.
//

import SwiftUI

struct CircularButton: View {
    let action: () -> Void     // action to be run when button is pressed
    let title: String          // the button title
    let backgroundColor: Color // the button color
    
    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(backgroundColor)
                .frame(width: 75, height: 75)
                .background(Circle().fill(translucentBackgroundColor))
                .padding(4)
                .overlay(Circle().stroke(translucentBackgroundColor, lineWidth: 2))
        })
    }
    
    private var translucentBackgroundColor: Color {
        backgroundColor.opacity(0.25)
    }
}

struct CircularButton_Previews: PreviewProvider {
    static var previews: some View {
        CircularButton(action: {}, title: "Start", backgroundColor: .green)
    }
}
