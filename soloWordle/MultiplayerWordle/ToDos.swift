//
//  ToDos.swift
//  MultiplayerWordle
//
//  Created by Noah Frahm on 3/13/22.
//

import Foundation

//DONE (check for bugs)
// make keys on keyboard change color to match guess results

//DONE (work on display formatting)
//display solution on last guess

//TODO
//add spell check

//TODO
//prevent repeats and increase word list size

//TODO
//display victory screen for solution before or on last guess

//TODO
//animate on guess

//TODO
//softer colors and light gray key default



//AD mode Notes
//identical to solo mode but on every new word it displays an AD


//1v1 Notes
//start here, implementing multiplayer will be easier this way since it is turn based with two players
//if done sucessfully here it will be trivial to implement for hangman

//HANGMAN Notes
//when game is hosted each person tha joins will be responsible for one word
//host -> join -> wait -> word selection screen after start -> game rotates words -> winner based on speed and guesses -> bonus points for less people guessing your word
//once the user submits to text field this data is sent to database and user is moved to waiting screen
//game doesnt start until all users have submitted a word
//add random word option so users dont have to type word
