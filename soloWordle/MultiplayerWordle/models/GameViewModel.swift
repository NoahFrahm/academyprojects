//
//  GameViewModel.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/18/22.
//

import Foundation

class GameViewModel: ObservableObject {

    @Published var guessList: [[String]] =
    //[]
    [["Q","U","A","C","K"],["Q","U","A","C","K"],["Q","U","A","C","K"],["Q","U","A","C","K"],["Q","U","A","C","K"]]
    @Published var writtenSoFar: [String] = [String]()
    @Published var solution = words[Int.random(in: 0..<words.count)]
    @Published var reset: Bool = false
    @Published var solutionSet = words
    
    init() {}
    
    init(solution: String) {
        self.solution = solution
    }
    
    func newWord() {
        self.solution = words[Int.random(in: 0..<words.count)]
    }
}
