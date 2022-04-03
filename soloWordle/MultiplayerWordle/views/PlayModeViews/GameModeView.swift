//
//  GameModeView.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/11/22.
//

import SwiftUI
import Foundation

struct GameModeView: View {
    
//    0 = solo, 1 = ad mode
    @State var gameMode: [Bool] = [false, false]
    
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: SoloView().navigationBarBackButtonHidden(true).navigationBarHidden(true), isActive: $gameMode[0]) {
                    EmptyView()
                }
             
                NavigationLink(destination: SoloView().navigationBarBackButtonHidden(true), isActive: $gameMode[1]) {
                    EmptyView()
                }
                
                Image(systemName: "w.square")
                    .foregroundColor(.brown)
                    .font(.system(size: 200))
               
                Button(action: {gameMode[0].toggle()}) {
                    ZStack{
                        RoundedRectangle(cornerRadius: 2)
                            .frame(width: 300, height: 80, alignment: .center)
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.black, lineWidth: 2))
                        Text("Solo")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                }
                
                Button(action: {gameMode[1].toggle()}) {
                    ZStack{
                    RoundedRectangle(cornerRadius: 2)
                        .frame(width: 300, height: 80, alignment: .center)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(.black, lineWidth: 2))
                        Text("AD mode")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                }
                Spacer()
            }.padding([.top], 60)
            .navigationTitle("Select Game Mode")
        }
    }
}

struct GameModeView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeView()
    }
}

