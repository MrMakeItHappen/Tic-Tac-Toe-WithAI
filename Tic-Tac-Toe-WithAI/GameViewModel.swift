//
//  Gameswift
//  Tic-Tac-Toe-WithAI
//
//  Created by Stanley Miller on 5/1/21.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var alertItem: AlertItem?
    
    //Configure theme.
    let boardColor = Color(#colorLiteral(red: 0.1490048468, green: 0.1490279436, blue: 0.1489969492, alpha: 1))
    let pieceColor = Color(#colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1))
    let selectionColor = Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    
    //Configure columns
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
}

//MARK: - Check Sqaure Availablity
extension GameViewModel {
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
}

//MARK: - AI Logic
extension GameViewModel {
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        //All possible win conditions.
        let winPatterns: Set<Set<Int>> = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6],
        ]
        
        //Determine all non-nil computer moves.
        //If AI can win, then win.
        let computerMoves = moves.compactMap({ $0 }).filter {
            $0.player == .computer
        }
        let computerPositions = Set(computerMoves.map({ $0.boardIndex }))
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(computerPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        //Determine all non-nil human moves.
        //If AI can't win, then block.
        let humanMoves = moves.compactMap({ $0 }).filter {
            $0.player == .human
        }
        let humanPositions = Set(humanMoves.map({ $0.boardIndex }))
        
        for pattern in winPatterns {
            let winPositions = pattern.subtracting(humanPositions)
            
            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPositions.first!)
                if isAvailable {
                    return winPositions.first!
                }
            }
        }
        
        //IF AI can't block , then take middle square.
        let centerSquare = 4
        if !isSquareOccupied(in: moves, forIndex: centerSquare) {
            return centerSquare
        }
        
        //Create a random move position.
        //If AI can't take middle square, take random available square.
        var movePosition = Int.random(in: 0..<9)
        
        //Check if move position is occupied.
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        //Move position is not occupied.
        return movePosition
    }
}


//MARK: - Reset Game
extension GameViewModel {
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}


//MARK: - Win Condition
extension GameViewModel {
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        //All possible win conditions.
        let winPatterns: Set<Set<Int>> = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8],
            [0, 3, 6],
            [1, 4, 7],
            [2, 5, 8],
            [0, 4, 8],
            [2, 4, 6],
        ]
        
        //Determine all non-nil player/computer moves.
        let playerMoves = moves.compactMap({ $0 }).filter {
            $0.player == player
        }
        let playerPositions = Set(playerMoves.map({ $0.boardIndex }))
        
        //Check for winning positions.
        for pattern in winPatterns where pattern.isSubset(of: playerPositions) {
            //We have a winner.
            return true
        }
        
        //No winner.
        return false
    }
}


//MARK: - Draw Condition
extension GameViewModel {
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap({ $0 }).count == 9
    }
}


//MARK: - React To Player Move
extension GameViewModel {
    func processPlayerMove(for index: Int) {
        if isSquareOccupied(in: moves, forIndex: index) {
            //Position is occupied.
            return
        }
        
        //Position is not occupied. Place human move. Disable game board.
        moves[index] = Move(player: .human, boardIndex: index)
        
        if checkWinCondition(for: .human, in: moves) {
            //Player wins
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            //Draw
            alertItem = AlertContext.draw
            return
        }
        
        isGameBoardDisabled = true
        
        //Determine if position is occupied. Place computer move. Enable game board.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [self] in
            let computerPosition = determineComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            
            if checkWinCondition(for: .computer, in: moves) {
                //Computer Wins
                alertItem = AlertContext.computerWin
                return
            }
            
            if checkForDraw(in: moves) {
                //Draw
                alertItem = AlertContext.draw
                return
            }
            
            isGameBoardDisabled = false
        }
    }
}
