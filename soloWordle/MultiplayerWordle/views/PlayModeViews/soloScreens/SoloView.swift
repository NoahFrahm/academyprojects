//
//  SoloView.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/13/22.
//

import Foundation
import SwiftUI

struct SoloView: View {
    
    @State var score: Int = 0
    @State var showStats: Bool = false
    @State var ActiveGame: GameView = GameView()
    
//    only show stats when user clicks bar
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            TopBarView(showStat: $showStats, presentationMode: _presentationMode)
            Divider()
            ZStack{
                ScrollView{
                    ActiveGame
                }.padding([.bottom], 10)
                    .onChange(of: ActiveGame.GVM.guessList) { _ in
                    print("update score")
                }
                .onChange(of: ActiveGame.GVM.solution) { _ in
                    print("pop up")
                }

                if showStats {
                    VStack{
                        Spacer()
                        UserStats(resetContinue: $showStats)
                            .padding([.bottom], 120)
                        Spacer()
                    }
                }

            }
        }
    }
}

struct SoloView_Previews: PreviewProvider {
    static var previews: some View {
        SoloView()
    }
}

struct TopBarView: View {
    
    @Binding var showStat: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        HStack{
            Spacer()
            Button(action: {                     self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("BACK")
                    .foregroundColor(.black)
                    .font(.title2)
            }
            
            Spacer()
            Button(action: {showStat.toggle()}) {
                Image(systemName: "chart.bar.xaxis")
                    .foregroundColor(.black)
                    .font(.title)
            }
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "gear")
                    .foregroundColor(.black)
                    .font(.title)
            }
            Spacer()
            
        }
    }
}
