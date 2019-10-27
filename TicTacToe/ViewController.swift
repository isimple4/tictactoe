//
//  ViewController.swift
//  TicTacToe
//
//  Created by xiaohui on 2019/10/27.
//  Copyright © 2019 simple4. All rights reserved.
//

import UIKit









class ViewController: UIViewController {
    
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
        
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    var buttonList: [UIButton]!
    
    
    var currentPlayer: Player = .O
    
    lazy var board = Board()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonList = [button0, button1, button2, button3, button4, button5, button6, button7, button8]
        resetButton.addTarget(self, action: #selector(initStatus), for: .touchUpInside)
        resetButton.isHidden = true
        
        initStatus()
    }
    
    @objc func initStatus() {

        
        board.initStatus()
        
        buttonList.forEach {
            $0.setTitle("", for: .normal)
            $0.isUserInteractionEnabled = true
        }
        
        currentPlayer = .O
        statusLabel.text = "Player \(currentPlayer.name) turn"
        
    }
    
    
    
    fileprivate func updateBoard(at index: Int) {
        switch board.setState(to: index, player: currentPlayer) {
        case .normal:
            self.swapPlayer()
        case .winner(let winner):
            statusLabel.text = "Player \(winner.name) win"
            resetButton.isHidden = false
            
            buttonList.forEach {
                $0.isUserInteractionEnabled = false
            }
        case .draw:
            print("draw")
            statusLabel.text = "draw game"
            resetButton.isHidden = false
        case .error(let error):
            print("error \(error.desc)")
            
        }
    }
    
    @IBAction func buttonClick(_ button: UIButton) {
        print("\(button.tag)")
        
        let index = button.tag

        if board.getState(from: index) == .notSet {
                        
            let newState = currentPlayer.toPositionState()
            
            button.setTitle(newState.getMark(), for: .normal)
            button.isUserInteractionEnabled = false
      
            updateBoard(at: index)
        }
        
    }
    
    func swapPlayer() {
        currentPlayer = currentPlayer.swap()
        statusLabel.text = "Player \(currentPlayer.name) turn"
    }
}

