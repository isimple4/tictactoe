//
//  BoardTests.swift
//  TicTacToeTests
//
//  Created by xiaohui on 2019/10/27.
//  Copyright © 2019 simple4. All rights reserved.
//

import XCTest
@testable import TicTacToe




class BoardTests: XCTestCase {
    
    
    func testNotValidIndex() {
        var b = Board()
        
        let p = Player.O
        
        let r = b.setState(to: 9, player: p)
        XCTAssertEqual(r, BoardResult.error(.notValidIndex))
        
        let r2 = b.setState(to: -1, player: p)
        XCTAssertEqual(r2, BoardResult.error(.notValidIndex))
        
    }
    
    //    func testAllDirectList() {
    //        let s: [PositionState] = [.O, .X, .O,
    //                                  .X, .O, .O,
    //                                  .X, .O, .X]
    //
    //        let b = Board.init(states: s)
    //
    //        let l = b.allDirectList()
    //
    //        let exp = [1, 1, -1, -1, 1, 1, 1, 1]
    //
    //        XCTAssertEqual(l, exp)
    //
    //    }
    
    func testDraw() {
        let s: [PositionState] = [.O, .X, .O,
                                  .X, .O, .O,
                                  .X, .O, .X]
        
        let b = Board.init(states: s)
        
        let r = b.calculateResult()
        
        XCTAssertEqual(r, BoardResult.draw)
    }
    
    func testWin1() {
        let s: [PositionState] = [.O, .X, .O,
                                  .X, .O, .O,
                                  .X, .X, .O]
        
        let b = Board.init(states: s)
        let p = Player.O
        
        let r = b.calculateResult()
        
        XCTAssertEqual(r, BoardResult.winner(p))
    }
    
    func testWin2() {
        let s: [PositionState] = [.O, .X, .O,
                                  .O, .X, .O,
                                  .X, .X, .O]
        
        let b = Board.init(states: s)
        let r = b.calculateResult()
        
        XCTAssertEqual(r, BoardResult.winner(Player.X))
    }
    
    func testNormal() {
        let s: [PositionState] = [.O, .X, .O,
                                  .X, .O, .O,
                                  .X, .notSet, .notSet]
        
        let b = Board.init(states: s)
        let r = b.calculateResult()
        
        XCTAssertEqual(r, BoardResult.normal)
    }
    
    
    func testSetStateNormal() {
        var b = Board()
        let p1 = Player.O
        let p2 = Player.X
        
        
        _ = b.setState(to: 0, player: p1)
        let r = b.setState(to: 1, player: p2)
        
        
        XCTAssertEqual(r, BoardResult.normal)
        
    }
    
    func testSetStateDraw() {
        //        let s: [PositionState] = [.O, .X, .O,
        //                                  .X, .O, .O,
        //                                  .X, .O, .X]
        
        var b = Board()
        let p1 = Player.O
        let p2 = Player.X
        
        _ = b.setState(to: 0, player: p1)
        _ = b.setState(to: 1, player: p2)
        _ = b.setState(to: 2, player: p1)
        _ = b.setState(to: 3, player: p2)
        _ = b.setState(to: 4, player: p1)
        _ = b.setState(to: 6, player: p2)
        _ = b.setState(to: 5, player: p1)
        _ = b.setState(to: 8, player: p2)
        let r = b.setState(to: 7, player: p1)
        
        
        XCTAssertEqual(r, BoardResult.draw)
    }
    
    func testSetStateWin() {
        //        let s: [PositionState] = [.O, .X, .O,
        //                                  .X, .O, .O,
        //                                  .X, .X, .O]
        
        var b = Board()
        let p1 = Player.O
        let p2 = Player.X
        
        _ = b.setState(to: 0, player: p1)
        _ = b.setState(to: 1, player: p2)
        _ = b.setState(to: 2, player: p1)
        _ = b.setState(to: 3, player: p2)
        _ = b.setState(to: 4, player: p1)
        _ = b.setState(to: 6, player: p2)
        _ = b.setState(to: 5, player: p1)
        _ = b.setState(to: 7, player: p2)
        let r = b.setState(to: 8, player: p1)
        
        
        
        XCTAssertEqual(r, BoardResult.winner(.O))
    }
    
    func testUnexpectedClick() {
        let s: [PositionState] = [.O, .X, .O,
                                  .X, .O, .O,
                                  .X, .O, .X]
        
        var b = Board.init(states: s)
        
        let r = b.setState(to: 2, player: .O)
        
        XCTAssertEqual(r, BoardResult.error(.unexpectedClick))
        
    }
    
    
    
    func testWin11() {
        let s: [PositionState] = [.X, .notSet, .notSet,
                                  .X, .notSet, .notSet,
                                  .X, .notSet, .notSet]
        
        let b = Board.init(states: s)
        
        let r = b.calculateResult()
        
        XCTAssertEqual(r, BoardResult.winner(.X))
    }
    
    func testWin12() {
        let s: [PositionState] = [.O, .O, .O,
                                  .X, .notSet, .notSet,
                                  .X, .notSet, .notSet]
        
        let b = Board.init(states: s)
        
        let r = b.calculateResult()
        
        XCTAssertEqual(r, BoardResult.winner(.O))
    }
    
    
    func testWin13() {
        let s: [PositionState] = [.O, .O, .X,
                                  .X, .X, .notSet,
                                  .X, .notSet, .notSet]
        
        let b = Board.init(states: s)
        
        let r = b.calculateResult()
        
        XCTAssertEqual(r, BoardResult.winner(.X))
    }
    
    func testWin14() {
        let s: [PositionState] = [.O, .O, .X,
                                  .X, .X, .notSet,
                                  .X, .notSet, .notSet]
        
        let b = Board.init(states: s)
        
        let r = b.calculateResult()
        
        XCTAssertEqual(r, BoardResult.winner(.X))
    }
}
