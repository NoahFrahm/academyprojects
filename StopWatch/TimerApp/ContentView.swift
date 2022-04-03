//
//  ContentView.swift
//  TimerApp
//
//  Created by Noah Frahm on 2/24/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var time = 0.00
    @State private var pause = true
    
    var timer = Timer.publish(every: 0.001, on: .main, in: .common).autoconnect()

    
    var body: some View {
        VStack{
            if !pause {
                Text(String(format: "%.2f", time)).onReceive(timer) { input in
                    time += 0.001
                }
            }
            else {
                Text(String(format: "%.2f", time))
            }
            HStack{
                Button(action: {pause.toggle()
                    }) {
                        if pause {
                            Text("start")
                        }
                        else {
                            Text("pause")
                            
                        }
                    }
                Button(action: {time = 0.0
                    }) {
                        Text("reset")
                    }
            }
        }
    }
}


//build swipe and tap to categorize
//speed edit
//magnified edit
//// power press


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
