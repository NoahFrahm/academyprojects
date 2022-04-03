//
//  KeyBoardView.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/3/22.
//

import SwiftUI

struct KeyBoardView: View {
    @StateObject var keyModel = KeyBoardViewModel()
    
    @Binding var typedOut: [String]
    @Binding var GuessList: [[String]]
    @Binding var solution: String
    @Binding var reset: Bool
        
    var spacing: CGFloat = 5
    
    var body: some View {
        VStack{
            VStack(spacing: 8){
                KeyRowView(spacing: spacing, keyModel: keyModel, typedOut: $typedOut).topRow
                KeyRowView(spacing: spacing, keyModel: keyModel, typedOut: $typedOut).middleRow
                BottomKeysView(spacing: spacing, keyModel: keyModel, bottomRow: keyModel.bottomRow, GuessList: $GuessList, typedOut: $typedOut, solution: solution)
            }.font(.title)
            .padding([.bottom], 50)
        }.onChange(of: reset) { _ in
            typedOut = [String]()
            GuessList = [[String]]()
            keyModel.resetKeys()
            reset = false
        }
    }
}

struct KeyBoardView_Previews: PreviewProvider {

    static var previews: some View {
        KeyBoardView(
            typedOut: .constant(["q", "u", "a", "c","k"]),
            GuessList: .constant([["q", "u", "a", "c","k"]]),
            solution: .constant("quack"),
            reset: .constant(false))
    }
}

private struct KeyBoardKeyView: View {
    
    @Binding var typedOutLetters: [String]
    var letter: String
    var backgroundColor: Color
    var letterColor: Color
    
    var body: some View {
        Button(action: {
            if typedOutLetters.count < 5 {
                typedOutLetters.append(letter.uppercased())
            }
        }) {
            ZStack{
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(backgroundColor)
                Text(letter.uppercased())
                    .foregroundColor(letterColor)
                    .font(.body)
                    .bold()
            }.frame(width: 32, height: 60)
        }
    }
}


private struct BottomKeysView: View {

    var spacing: CGFloat
    var keyModel: KeyBoardViewModel
    var bottomRow: [String]

    @Binding var GuessList: [[String]]
    @Binding var typedOut: [String]
    
    var solution: String
    var solFormatted: [String] {
        var formed: [String] = [String]()
        for char in solution {
            formed.append(String(char).uppercased())
        }
        return formed
    }


    func deleteChar() {
        if typedOut.count > 0 {
            _ = typedOut.popLast()
        }
    }

    var body: some View {
        HStack(spacing: spacing){
            Spacer()
            
            Button(action: {
                if keyModel.guesses < 6 && typedOut.count == 5 {
                    keyModel.guesses += 1
                    GuessList.append(typedOut)

                    let newKeyColors = keyModel.CheckAnswer(guess: typedOut, answer: solFormatted)

                    for index in 0...(typedOut.count - 1) {
                        keyModel.changeKeyColor(keyName: typedOut[index], newCol: newKeyColors[index])
                    }
                    
                    typedOut = [String]()
                    }
                }
            ){
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(keyModel.defaultKeyColor)
                        .frame(width: 57, height: 60)
                    Text("ENTER")
                        .foregroundColor(.black)
                        .font(.body)
                        .bold()
                }
            }
            
            ForEach(keyModel.bottomRow, id: \.self) { keyy in
                KeyBoardKeyView(typedOutLetters: $typedOut,letter: keyy, backgroundColor: keyModel.keysColor[keyy]!.color, letterColor: keyModel.keysColor[keyy]!.textColor)
            }
            
            Button(action: {
                deleteChar()
                }
            ) {
                ZStack{
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(keyModel.defaultKeyColor)
                        .frame(width: 50, height: 60)
                    Image(systemName: "delete.left")
                        .foregroundColor(.black)
                        .font(.title)
                }
            }
            
            Spacer()
        }
    }
}


private struct KeyRowView {

    var spacing: CGFloat
    var keyModel: KeyBoardViewModel
    @Binding var typedOut: [String]

    
    var topRow: some View {
        HStack(spacing: spacing){
            Spacer()
            ForEach(keyModel.topRow, id: \.self) { keyy in
                KeyBoardKeyView(typedOutLetters: $typedOut,letter: keyy, backgroundColor: keyModel.keysColor[keyy]!.color, letterColor: keyModel.keysColor[keyy]!.textColor)
            }
            Spacer()
        }
    }
    
    var middleRow: some View {
        HStack(spacing: spacing){
            Spacer()
            ForEach(keyModel.middleRow, id: \.self) { keyy in
                KeyBoardKeyView(typedOutLetters: $typedOut,letter: keyy, backgroundColor: keyModel.keysColor[keyy]!.color, letterColor: keyModel.keysColor[keyy]!.textColor)
            }
            Spacer()
        }
    }
}
