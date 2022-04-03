//
//  NavvySection.swift
//  Navvy
//
//  Created by Samuel Shi on 8/21/21.
//

import SwiftUI

struct MySection<Header: View, Content: View>: View {
    let header: Header
    var background: Color?
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                header
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()
            }

            HStack {
                content()

                Spacer()
            }
            .padding()
            .background(background ?? Color(.systemGray5))
            .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}

struct NavvySection_Previews: PreviewProvider {
    static var previews: some View {
        MySection(header: Text("address")) {
            Text("Yo")
        }
        .preferredColorScheme(.dark)
        .fullscreenBackground(Color(.systemGray6))
    }
}
