//
//  ViewController.swift
//  TicTacToe
//
//  Created by Marco Montalto on 02/04/16.
//  Copyright © 2016 Marco Montalto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var player = 1 // 1 = nought; 2 = crosses
    var playerNames = ["nought", "cross"]
    var gameState = [0,0,0,0,0,0,0,0,0];
    let winningCombinations = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    var moves = 0;
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var gameOverView: UIView!
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        
        let state = gameState[sender.tag]
        
        if (state == 0) {
            
            moves += 1;
            gameState[sender.tag] = player
            
            if player == 1 {
                sender.setImage(UIImage(named: "nought.png"), for: UIControlState())
                checkWinning()
                player = 2
            } else {
                sender.setImage(UIImage(named: "cross.png"), for: UIControlState())
                checkWinning()
                player = 1
            }
        }
    }
    
    @IBAction func restartGame(_ sender: AnyObject) {
        
        player = 1
        moves = 0;
        gameState = [0,0,0,0,0,0,0,0,0]
        
        var buttonToClear : UIButton
        for i in 0 ..< 9 {
            buttonToClear = view.viewWithTag(i) as! UIButton
            buttonToClear.setImage(nil, for: UIControlState())
        }
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            
            self.gameOverView.center = CGPoint(x: self.gameOverView.center.x, y: self.gameOverView.center.y*4)
        })
        
        gameOverView.isHidden = true;
    }
    
    func checkWinning() {
        
        for combination in winningCombinations {
            
            var matchOver = true
            
            for pos in combination {
                if gameState[pos] != player {
                    matchOver = false
                }
            }
            
            if matchOver == true {
                
                endGame(playerNames[player-1] + " won!!!")
                break;
                
            } else if moves == 9 {
                
                endGame("It a draw!!");
                break;
            }
        }
    }
    
    func endGame(_ message: String) {
        
        [0][1]
        
        winnerLabel.text = message
        gameOverView.isHidden = false;
        
        UIView.animate(withDuration: 1, animations: { () -> Void in
            
            self.gameOverView.center = CGPoint(x: self.gameOverView.center.x, y: self.gameOverView.center.y/4)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameOverView.isHidden = true;
        gameOverView.center = CGPoint(x: gameOverView.center.x, y: gameOverView.center.y*4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

