//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Divyansh Dwivedi on 07/05/22.
//

import SwiftUI
final class GameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible()),]
    
    @Published  var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published  var isBoardDisabled = false
    @Published  var alertItem: AlertItem?
    
    func processPlayer(for position: Int) {
        if isSquareOcupied(in: moves, forindex: position){ return }
        moves[position] = Move(player: .human, boardIndex: position)
      
        if checkWinConditions(for: .human, in: moves) {
            alertItem = AlertView.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertView.draw
            return
        }
        
        isBoardDisabled = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPosition = determineCompMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isBoardDisabled = false
            if checkWinConditions(for: .computer, in: moves) {
                alertItem = AlertView.computerwin
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertView.draw
                return
            }
        }
        
    }
    
    func isSquareOcupied(in moves: [Move?], forindex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    
    func determineCompMovePosition(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOcupied(in: moves, forindex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        return movePosition
    }
    
    
    func checkWinConditions(for player: Player, in moves: [Move?]) -> Bool {
        let winPatters: Set<Set<Int>> = [[0, 1, 2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap{ $0 }.filter {$0.player == player }
        let playerPosition = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatters where pattern.isSubset(of: playerPosition) {
            return true
        }
            return false
        }
    
    
    func checkForDraw(in moves:[Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}
