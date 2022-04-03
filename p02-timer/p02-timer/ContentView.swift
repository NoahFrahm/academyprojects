//
//  ContentView.swift
//  p02-timer
//
//  Created by Samuel Shi on 2/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var hasSelectedTime: Bool = false
    @State private var paused: Bool = false
    @State private var totalSecondsInTimer: Int = 0
    @State private var elapsedTime: Int = 0
    
    @State private var hourText = ""
    @State private var minuteText = ""
    @State private var secondText = ""
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var selectTime: some View {
        HStack{
            TextField("h", text: $hourText)
            Text(":")
            TextField("m", text: $minuteText)
            Text(":")
            TextField("s", text: $secondText)
//            Text(secondText)
        }.textFieldStyle(NumberTextFieldStyle())
    }
    
    var timerView: some View {
        ZStack{
            CirclesView(elapsedTime: elapsedTime, totalTime: totalSecondsInTimer)
            Text("\(remainingTime)")
        }
    }
    
    var remainingTime: String {
        let timeLeft = totalSecondsInTimer - elapsedTime
        
        let hrs = timeLeft / 3600
        let mins = (timeLeft % 3600) / 60
        let sec = timeLeft % 60
        
        let hours = String(format: "%02d", hrs)
        let minutes = String(format: "%02d", mins)
        let seconds = String(format: "%02d", sec)
        
        return "\(hours): \(minutes) : \(seconds)"
    }
    
    func cancelAction() {
        paused = false
        hasSelectedTime = false
        elapsedTime = 0
        totalSecondsInTimer = 0
        hourText = ""
        minuteText = ""
        secondText = ""
        
    }
    
    func startAction() {
        paused = false
        let hours = Int(hourText) ?? 0
        let minutes = Int(minuteText) ?? 0
        let seconds = Int(secondText) ?? 0
        let totalSeconds =  hours * 360 + minutes * 60 + seconds
        
        print(hours, minutes, seconds, totalSeconds)
        
        totalSecondsInTimer = totalSeconds
        hasSelectedTime = true
    }
    
    func handleTimerEvent() {
        
        if hasSelectedTime && elapsedTime < totalSecondsInTimer && !paused{
            elapsedTime += 1
        }
    }
    
    
    var body: some View {
        VStack{
            Group{
                if hasSelectedTime {
                    timerView
                }
                else {
                    selectTime
                }
                
                HStack{
                    CircularButton(action: {cancelAction()}, title: "Cancel", backgroundColor: .secondary)
                    
                    Spacer()
                    
                    if hasSelectedTime && paused {
                        CircularButton(action: {startAction()}, title: "Start", backgroundColor: .green)
                    }
                    else if  hasSelectedTime && !paused {
                        CircularButton(action: {paused.toggle()}, title: "Pause", backgroundColor: .green)
                    }
                    else {
                        CircularButton(action: {startAction()}, title: "Start", backgroundColor: .green)
                        
                    }
                }
                
            }.frame(height: 300)
            
        }
        .padding()
        .onReceive(timer) { _ in
            handleTimerEvent()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().preferredColorScheme(.dark)
            ContentView().preferredColorScheme(.light)
        }
    }
}
