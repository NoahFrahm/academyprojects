//
//  KeyBoardViewModel.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/3/22.
//

import Foundation
import SwiftUI

class KeyBoardViewModel: ObservableObject {
    
    @Published var keysColor = [String: key]()
    @Published var guesses = 0
    
    let topRow = ["q","w","e","r","t","y","u","i","o","p"]
    let middleRow = ["a","s","d","f","g","h","j","k","l"]
    let bottomRow = ["z","x","c","v","b","n","m"]
    
    let defaultKeyColor: Color = Color("lightgray")
    let wrongKeyColor: Color = .gray
    let defaultTextColor: Color = .black
    let changedTextColor: Color = .white
    
    struct key {
        let name: String
        var color: Color
        var textColor: Color
    }
    
    
    init() {
        for letter in topRow {
            keysColor[letter] = key(name: letter , color: defaultKeyColor, textColor: defaultTextColor)
        }
        for letter in middleRow {
            keysColor[letter] = key(name: letter , color: defaultKeyColor, textColor: defaultTextColor)
        }
        for letter in bottomRow {
            keysColor[letter] = key(name: letter , color: defaultKeyColor, textColor: defaultTextColor)
        }
    }
    
    
    func resetKeys() {
        for letter in topRow {
            keysColor[letter] = key(name: letter , color: defaultKeyColor, textColor: defaultTextColor)
        }
        for letter in middleRow {
            keysColor[letter] = key(name: letter , color: defaultKeyColor, textColor: defaultTextColor)
        }
        for letter in bottomRow {
            keysColor[letter] = key(name: letter , color: defaultKeyColor, textColor: defaultTextColor)
        }
        guesses = 0
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
    
    
    func CheckAnswer(guess: [String], answer: [String]) -> [String] {
//        print(guess, answer, "key check")
        var letterCounts = wordBreakDown(buchstabe: answer)
        var key = ["","","","",""]

        
        for index in 0...4 {
            key[index] = ""
        }
        
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
        return key
    }
    
    
    func changeKeyColor(keyName: String, newCol: String) {
        var newColor: Color
        
        switch newCol {
            case "green":
                newColor = .green
            case "yellow":
                newColor = .yellow
            case "gray":
                newColor = .gray
//                newColor = wrongKeyColor
            default:
                newColor = .gray
        }
        
        if keysColor[keyName.lowercased()]?.color != .green {
            if newColor == .gray{
                if keysColor[keyName.lowercased()]?.color != .yellow {
                    keysColor[keyName.lowercased()]?.color = newColor
                    keysColor[keyName.lowercased()]?.textColor = changedTextColor
                }
            }
            else {
                keysColor[keyName.lowercased()]?.color = newColor
                keysColor[keyName.lowercased()]?.textColor = changedTextColor
            }
        }
        //        if keysColor[keyName.lowercased()]?.color != .green {
        //            keysColor[keyName.lowercased()]?.color = newColor
        //            keysColor[keyName.lowercased()]?.textColor = changedTextColor
        //        }
    }
    
    
}
