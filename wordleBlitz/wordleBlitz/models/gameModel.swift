//
//  gameModel.swift
//  wordleBlitz
//
//  Created by Noah Frahm on 3/29/22.
//

import Foundation
import SwiftUI

class gameModel: ObservableObject {
    
    @Published var keys: [String: key] = [String: key]()
    @Published var guesses: [[String]] = []
    @Published var typedOut: [String] = []
    @Published var gameOver: Bool = false
    
    //the view doesnt need to know about these
    @Published var solutionSet = words
    @Published var solution: String = words[Int.random(in: 0..<words.count)]


//    let defaultKeyColor: Color = Color("lightgray")
//    let wrongKeyColor: Color = .gray
//    let defaultTextColor: Color = .black
//    let changedTextColor: Color = .white
    private var maxGuesses = 6
    private var solutionIndex = 0
    private var tries: Int {
        return guesses.count
    }
    private var stringGuess: String {
        var stringy: String = ""
        for letr in self.typedOut {
            stringy += letr.uppercased()
        }
        return stringy
    }
    private var solutionArrayFormat: [String] {
        var myArr: [String] = []
        for char in self.solution {
            myArr.append(String(char))
        }
        return myArr
    }
    

    convenience init() {
        self.init(solution: words[Int.random(in: 0..<words.count)])
    }
    
    init(solution: String) {
        let topRow = ["q","w","e","r","t","y","u","i","o","p"]
        let middleRow = ["a","s","d","f","g","h","j","k","l"]
        let bottomRow = ["z","x","c","v","b","n","m"]
        
        for letter in topRow {
            self.keys[letter] = key(name: letter)
        }
        for letter in middleRow {
            self.keys[letter] = key(name: letter)

        }
        for letter in bottomRow {
            self.keys[letter] = key(name: letter)
        }
        self.solution = solution
    }
    
    
    //fetches a new word from solution set, specifically base on solutionindex, and makes it the new solution
    func newWord() {
        self.solution = self.solutionSet[self.solutionIndex]
        self.solutionIndex += 1
    }
    
    
    //resets the game with a new solution
    private func reset() {
        self.guesses = []
        self.typedOut = []
        self.resetKeys()
        self.newWord()
    }
    
    
    //makes all keys their default color
    private func resetKeys() {
        let topRow = ["q","w","e","r","t","y","u","i","o","p"]
        let middleRow = ["a","s","d","f","g","h","j","k","l"]
        let bottomRow = ["z","x","c","v","b","n","m"]
        
        for letter in topRow {
            self.keys[letter]?.color = self.keys[letter]?.defaultKeyColor ?? .gray
        }
        for letter in middleRow {
            self.keys[letter]?.color = self.keys[letter]?.defaultKeyColor ?? .gray

        }
        for letter in bottomRow {
            self.keys[letter]?.color = self.keys[letter]?.defaultKeyColor ?? .gray
        }
    }
    
    
    //type a letter
    func typeLetter(letter: String) {
        if typedOut.count < 5 {
            typedOut.append(letter)
        }
    }
    
    
    //delete a letter
    func delete() {
        if typedOut.count > 0 {
            _ = typedOut.popLast()
        }
    }

    
    // checks guess and recolors keys appropriately
    func enter() {
        if self.typedOut.count != 5 { return }
        
        let colorKey = self.checkGuess(guess: self.typedOut)
        
        //this for loop decodes color key and assigns new key/text colors accordingly
        for index in 0...self.typedOut.count {
            let myKey = self.keys[self.typedOut[index]]
            
            self.keys[self.typedOut[index]]?.textColor = myKey?.changedTextColor ?? .gray
            
            switch colorKey[index]{
                case "wrong":
                    self.keys[self.typedOut[index]]?.color = myKey?.wrongKeyColor ?? .gray
                case "correct":
                    self.keys[self.typedOut[index]]?.color = myKey?.correctKeyColor ?? .gray
                case "partial":
                    self.keys[self.typedOut[index]]?.color = myKey?.partialKeyColor ?? .gray
                default:
                    print("error finding key to change")
            }
        }
        
        self.guesses.append(self.typedOut)
        self.typedOut = []
        self.checkGameOver()
    }
    
    
    //checks if game is over by max guesses or correct solution an sets gameover bool to true or false accordingly
    private func checkGameOver() {
        if self.guesses.count == self.maxGuesses || self.stringGuess.uppercased() == self.solution.uppercased() {
            self.gameOver = true
        }
    }
    
    
    //makes a dictionary with letter frequencies in a given word
    private func wordBreakDown(buchstabe: [String]) -> [String: Int] {
            var counter = [String: Int]()
            for char in buchstabe {
                if counter[String(char)] == nil {
                    counter[String(char)] = 1
                }
                else{
                    counter[String(char)]? += 1
                }
            }
            return counter
    }

    
    //returns an array with a color key base on guess and actual solution
    //wrong is if letter is not in word, partial if letter is in wrong position, and correct if letter is correctly placed
    func checkGuess(guess: [String]) -> [String] {
//        print(guess)
        let answer = self.solutionArrayFormat
        let wordLength = self.solution.count
        var letterCounts = wordBreakDown(buchstabe: answer)
        var key: [String] = []


        for index in 0...wordLength {
            key[index] = ""
        }
    
        for rotation in 0...2{
            switch rotation {
                case 0:
                    for j in 0...wordLength {
                        if guess[j] == answer[j]{
                            key[j] = "correct"
                            letterCounts[guess[j]]! -= 1
                        }
                    }
                case 1:
                    for j in 0...wordLength {
                        if answer.contains(guess[j]) && key[j] != "correct" && letterCounts[guess[j]]! > 0 {
                            key[j] = "partial"
                            letterCounts[guess[j]]! -= 1
                        }
                    }
                case 2:
                    for j in 0...wordLength {
                        if key[j] == "" {
                            key[j] = "wrong"
                        }
                    }
                default:
                    key[0] = "correct"
                }
        }
        return key
    }

}

struct key {
    var name: String
    var color: Color = .gray
    var textColor: Color = .black
    
//    let defaultKeyColor: Color = Color("lightgray")
    let defaultKeyColor: Color = .white
    let wrongKeyColor: Color = .gray
    let correctKeyColor: Color = .green
    let partialKeyColor: Color = .yellow

    let defaultTextColor: Color = .black
    let changedTextColor: Color = .white
    
}
