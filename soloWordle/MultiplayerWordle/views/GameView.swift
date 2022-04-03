//
//  GameView.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/12/22.
//

import Foundation

import SwiftUI


struct GameView: View {
    
    @StateObject var GVM: GameViewModel = GameViewModel()

    var body: some View {
        ScrollView{
            LetterView(solution: $GVM.solution, typedLetters: $GVM.writtenSoFar, guesses: $GVM.guessList, reset: $GVM.reset)
            KeyBoardView(typedOut: $GVM.writtenSoFar, GuessList: $GVM.guessList, solution: $GVM.solution, reset: $GVM.reset)
        }.onChange(of: GVM.reset){ _ in
            GVM.newWord()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    
    static var previews: some View {
        GameView()
    }
}
