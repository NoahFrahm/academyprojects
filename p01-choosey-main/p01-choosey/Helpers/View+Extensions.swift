//
//  View+Extensions.swift
//  p01
//
//  Created by Samuel Shi on 9/19/21.
//

import SwiftUI

extension Text {
    func star() -> Text {
        self
            .font(.caption)
            .fontWeight(.bold)
            .foregroundColor(.yellow)
    }
}

extension View {
    func star() -> some View {
        self
            .font(.caption.weight(.bold))
            .foregroundColor(.yellow)
    }

    func fullscreenBackground<Content: View>(_ content: Content) -> some View {
        ZStack {
            content.ignoresSafeArea()

            self
        }
    }
}
