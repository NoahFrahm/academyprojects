//
//  LetterView.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/2/22.
//

import SwiftUI

struct LetterView: View {

    @StateObject var letterModel: LetterViewModel = LetterViewModel(solution: "Quack", size: 5)
    
    @State var gameOver: Bool = false
    
    @Binding var solution: String
    @Binding var typedLetters: [String]
    @Binding var guesses: [[String]]
    @Binding var reset: Bool
    
    var tries = 6
    var lengthenTypedOut: [String] {
        var shortened = typedLetters
        while shortened.count < 5 {
            shortened.append("")
        }
        return shortened
    }
    var foundAnswer: Bool {
        if guesses.count >= 1 {
            let lastg = guesses[guesses.count - 1].joined().uppercased()
            return lastg == solution.uppercased()
        }
        return false
    }
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                ForEach(0...tries-1 , id: \.self) { index in
                    if index < guesses.count {
                        LetterRowView(sol: solution,word: guesses[index], width: 60, height: 60, LVM: letterModel)
                    }
                    else if index == guesses.count && guesses.count < tries {
                        TypedOutLettersView(letters: lengthenTypedOut)
                    }
                    else {
                        LetterRowView(sol: solution, width: 60, height: 60)
                    }
                }
            }.padding()
            if guesses.count == tries || foundAnswer{
                VStack{
                    ZStack{
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(width: 100, height: 50, alignment: .center)
                        Text(solution.uppercased())
                                .foregroundColor(.white)
                    }
                    if gameOver {
                        Button(action: {
                            reset = true
                            gameOver = false
                        }) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(width: 200, height: 50)
                                    .foregroundColor(.black)
                                Text("Next Word")
                                    .bold()
                                    .font(.title2)
                                    .foregroundColor(.white)
                            }
                        }.padding([.top], 200)
                    }
                    Spacer()
                }.onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        gameOver = true
                    }
                }
            }
        }
    }
}

struct LetterView_Previews: PreviewProvider {
    static var previews: some View {
        LetterView(letterModel: LetterViewModel(solution: "quack", size: 5),solution: .constant("quack"), typedLetters: .constant(["b", "o", "u", "n", "g"]),
                   guesses: .constant([["y", "o", "u", "n", "k"],["y", "o", "u", "n", "k"]]), reset: .constant(false))
    }
}


struct TypedOutLettersView: View {
    var letters: [String] = ["", "", "", "", ""]

    var body: some View {
        HStack{
            ForEach(0...4, id: \.self) { index in
                SingleLetter(buchstabe: letters[index]).typed
            }
        }
    }
}


struct LetterRowView: View {
    
    var sol: String
    var word: [String] = ["", "", "", "", ""]
    var width: Double
    var height: Double
    var radius: Double = 0
    var color: Color = .white

//    model holds the solution
    var LVM: LetterViewModel = LetterViewModel(solution: "quack", size: 5)

    var body: some View {
        let LVM: LetterViewModel = LetterViewModel(solution: sol, size: 5)
        let key = LVM.CheckAnswer(guess: word)

        HStack{
            ForEach(0...4, id: \.self) { index in
                switch key[index] {
                case "green":
                    SingleLetter(buchstabe: word[index]).green
                case "yellow":
                    SingleLetter(buchstabe: word[index]).yellow
                case "gray":
                    SingleLetter(buchstabe: word[index]).gray
                default:
                    SingleLetter(buchstabe: word[index]).empty
                }
            }
        }
    }
}


struct SingleLetter {

    var width: Double = 60
    var height: Double = 60
    var buchstabe: String = ""

    private var letter: String {
        return buchstabe.uppercased()
    }

    var green: some View {
        SingleLetterView(width: width, height: height, color: .green, unformattedletter: letter)
    }
    var yellow: some View {
        SingleLetterView(width: width, height: height, color: .yellow,unformattedletter: letter)
    }
    var gray: some View {
        SingleLetterView(width: width, height: height, color: .gray,unformattedletter: letter)
    }
    var typed: some View {
        SingleLetterView(width: width, height: height, color: .white,unformattedletter: buchstabe, textColor: .black, borderColorWhenWhite: .black)
    }
    var empty: some View {
        SingleLetterView(width: width, height: height, color: .white)
    }
}


struct SingleLetterView: View {

    var width: Double
    var height: Double
    var radius: Double = 0
    var color: Color = .white
    var unformattedletter: String = ""
    var textColor: Color = .white
    var borderColorWhenWhite: Color = .white

    private var letter: String {
        return unformattedletter.uppercased()
    }

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: radius)
                .foregroundColor(color)
                .frame(width: width, height: height)
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(color == .white ? letter == "" ? .gray : borderColorWhenWhite : color, lineWidth: 2))
                Text(letter)
                    .foregroundColor(textColor)
                    .bold()
                    .font(.largeTitle)
        }
    }
}
