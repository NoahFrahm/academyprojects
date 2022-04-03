//
//  LetterViewModel.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/2/22.
//

import Foundation

class LetterViewModel: ObservableObject {
    
    @Published var guesses: [[String]]

    public var answerRaw: String
    let wordLength: Int
    
    var answer: [String] {
//        add checks for safety, length 5 string
        var convertedAnswer: [String] = [String]()
        for character in answerRaw {
            convertedAnswer.append(character.uppercased())
        }
        return convertedAnswer
    }
    
    init(solution: String, size: Int) {
        self.answerRaw = solution
        self.wordLength = size
        self.guesses = [[String]]()
    }
    
    private func wordBreakDown(buchstabe: [String]) -> [String: Int] {
            var counter = [String: Int]()
            for char in buchstabe{
                if counter[String(char)] == nil {
                    counter[String(char)] = 1
                }
                else{
                    counter[String(char)]? += 1
                }
            }
            return counter
    }
    
    func CheckAnswer(guess: [String]) -> [String] {
//        print(guess)
        var letterCounts = wordBreakDown(buchstabe: answer)
        var key = ["","","","",""]

        
        for index in 0...4 {
            key[index] = ""
        }
        
        if guess.count != wordLength || guess == key {
            for index in 0...4 {
                key[index] = "empty"
            }
            return key
        }
        else {
            for rotation in 0...2{
                switch rotation {
                case 0:
                    for j in 0...4 {
                        if guess[j] == answer[j]{
                            key[j] = "green"
                            letterCounts[guess[j]]! -= 1
                        }
                    }
                case 1:
                    for j in 0...4 {
                        if answer.contains(guess[j]) && key[j] != "green" && letterCounts[guess[j]]! > 0 {
                            key[j] = "yellow"
                            letterCounts[guess[j]]! -= 1
                        }
                    }
                case 2:
                    for j in 0...4 {
                        if key[j] == "" {
                            key[j] = "gray"
                        }
                    }
                default:
                    key[0] = "green"
                }
            }
        }
//        print(guess, key)
        return key
    }
}
