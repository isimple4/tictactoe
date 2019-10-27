//
//  Enums.swift
//  TicTacToe
//
//  Created by xiaohui on 2019/10/27.
//  Copyright © 2019 simple4. All rights reserved.
//

import Foundation

enum Player: Int {
    case O = 1
    case X = -1
    
    func swap() -> Player {
        switch self {
        case .O:
            return .X
        case .X:
            return .O
        }
    }
    
    var name: String {
        switch self {
        case .O:
            return "O"
        case .X:
            return "X"
        }
    }
    
    func toPositionState() -> PositionState {
           switch self {
           case .O:
               return .O
           case .X:
               return .X
           }
       }
}

enum PositionState: Int {
    case O = 1
    case X = -1
    case notSet = 0
    
    func getMark() -> String {
        switch self {
        case .O:
            return "O"
        case .X:
            return "X"
        case .notSet:
            return ""
        }
    }
}

enum BoardError: Error {
    case notValidIndex
    case unexpectedClick
    
    var desc: String {
        switch self {
        case .notValidIndex:
            return "error notValidIndex"
        case .unexpectedClick:
            return "unexpeced click, current place has been set"
        }
    }
}

extension BoardError: Equatable {
    static func == (lhs: BoardError, rhs: BoardError) -> Bool {
        switch (lhs, rhs) {
        case (.notValidIndex, .notValidIndex):
            return true
        case (.unexpectedClick, .unexpectedClick):
            return true
        default:
            return false
        }
    }
}

enum BoardResult {
    case winner(Player)
    case draw
    case normal
    case error(BoardError)
}

extension BoardResult: Equatable {
    static func == (lhs: BoardResult, rhs: BoardResult) -> Bool {
        switch (lhs, rhs) {
        case (.winner(let p1), (.winner(let p2))):
            return p1 == p2
        case (.draw, .draw):
            return true
        case (.normal, .normal):
            return true
        case (.error(let e1), .error(let e2)):
            return e1 == e2
        default:
            return false
        }
    }
}
