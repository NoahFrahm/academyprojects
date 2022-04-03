//
//  CirclesView.swift
//  p02-timer
//
//  Created by Samuel Shi on 2/26/22.
//

import SwiftUI

struct CirclesView: View {
    let elapsedTime: Int // the amount of time that has passed so far, in seconds
    let totalTime: Int   // the total amount of time, in seconds

    var percentageElapsed: CGFloat {
        let progress = max(Double(elapsedTime) / Double(totalTime), 0.005)
        return progress
    }

    var body: some View {
        circles.aspectRatio(1, contentMode: .fit)
    }

    var circles: some View {
        Circle()
            .stroke(Color.blue, lineWidth: 20.0)
            .opacity(0.3)
            .overlay {
                Circle()
                    .trim(from: 0.0, to: percentageElapsed)
                    .stroke(Color.blue, style: strokeStyle)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear(duration: 0.75), value: elapsedTime)
                    .shadow(color: .black, radius: 2, x: 0, y: 0)
            }
    }

    var gradient: AngularGradient {
        AngularGradient(colors: [.pink, .purple, .pink], center: .center)
    }

    var strokeStyle: StrokeStyle {
        StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round)
    }
}

struct CirclesView_Previews: PreviewProvider {
    static var previews: some View {
        CirclesView(elapsedTime: 15, totalTime: 20)
    }
}
