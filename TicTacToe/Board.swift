//
//  Board.swift
//  TicTacToe
//
//  Created by xiaohui on 2019/10/27.
//  Copyright © 2019 simple4. All rights reserved.
//

import Foundation


struct Board {
    private let n = 3
    
    private var boardState: [PositionState]!
    
    private var rowTotal: [Int] = [0, 0, 0]
    private var colTotal: [Int] = [0, 0, 0]
    private var ang1Total: Int = 0
    private var ang2Total: Int = 0
    
    private let allWinIndexs: [(Int, Int, Int)] = [(0, 1, 2), (3, 4, 5), (6, 7, 8),
                                                   (0, 3, 6), (1, 4, 7), (2, 5, 8),
                                                   (0, 4, 8), (2, 4, 6)]
    
    
    init(states: [PositionState]? = nil) {
        initStatus()
        if states != nil { boardState = states }
    }
    
    
    mutating func initStatus() {
        boardState = [.notSet, .notSet, .notSet,
                      .notSet, .notSet, .notSet,
                      .notSet, .notSet, .notSet]
        
        rowTotal = [0, 0, 0]
        colTotal = [0, 0, 0]
        ang1Total = 0
        ang2Total = 0
    }
    
    func getState(from index: Int) -> PositionState {
        return boardState[index]
    }
    
    mutating func setState(to index: Int, player: Player) -> BoardResult {
        guard index < n*n && index >= 0 else { return .error(.notValidIndex) }
        let state = getState(from: index)
        guard state == .notSet else { return BoardResult.error(.unexpectedClick) }
        
        
        let newState = player.toPositionState()
        boardState[index] = newState
        
        
        return calculateResult()
        
    }
    
//    mutating private func checkWin(_ index: Int, _ currentPlayer: Player) -> BoardResult {
//
//        let row = index / n
//        let col = index % n
//
//        let v = currentPlayer.rawValue
//        rowTotal[row] += v
//        colTotal[col] += v
//
//        if row == col { ang1Total += v }
//        if row + col == 2 { ang2Total += v }
//
//        // check current row/col/ang when click
//        let list = [rowTotal[row], colTotal[col],
//                    ang1Total, ang2Total]
//
//        return checkAllDirections(list)
//    }
    
    
    func calculateResult(_ list: [Int]? = nil) -> BoardResult {
        let tempList: [Int] = list ?? self.allDirectList()
        
        // check directions
        var foundWinner = false
        var player: Player?
        for i in 0..<tempList.count {
            if abs(tempList[i]) == n {
                foundWinner = true
                player = tempList[i] > 0 ? .O : .X
                break
            }
        }
        
        if let player = player, foundWinner == true {
            
            return .winner(player)
        }
        
        // check draw
        var isFull = true
        boardState.forEach {
            if $0 == .notSet { isFull = false }
        }
        
        if isFull == true { return .draw }
        
        // otherwise continue
        return .normal
    }
    
    private func allDirectList() -> [Int] {
        var list = [Int]()
        allWinIndexs.forEach {
            let total = boardState[$0.0].rawValue + boardState[$0.1].rawValue + boardState[$0.2].rawValue
            list.append(total)
        }
        
        return list
    }
}
