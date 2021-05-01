//
//  Move.swift
//  Tic-Tac-Toe-WithAI
//
//  Created by Stanley Miller on 5/1/21.
//

import Foundation

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

enum Player {
    case human
    case computer
}
