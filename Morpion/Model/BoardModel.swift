//
//  BoardModel.swift
//  Morpion
//
//  Created by Jonathan on 11/11/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class BoardModel: NSObject {
    
    let playerOne: User
    let playerTwo: User
    var currentPlayer: User
    var cellcount : Int
    
    var arrayOfUserDot: [User]
    
    init(player1: User, player2: User, cellCount: Int){
        self.playerOne = player1
        self.playerTwo = player2
        self.currentPlayer = player1
        self.cellcount = cellCount
        self.arrayOfUserDot = Array(repeatElement(User(player: .none), count: cellcount))
        
        super.init()
    }
    
    private func registerAMove(indexPath: IndexPath)-> Bool {
        // since there is possiblity that user may be nil
        let user : User = self.arrayOfUserDot[indexPath.row]
        if user.playerType == .none {
            arrayOfUserDot[indexPath.row] = currentPlayer
            //user = currentPlayer
            return true
        }
        else{
            return false
        }
    }
    
     func didUserWin(indexPath: IndexPath) -> Bool{

         let result: Bool = false
        if registerAMove(indexPath: indexPath){
            // check if user win
            let currentCellAt = indexPath.row
            
            
            //--------------------------------------------check diagonal Downard (from left to right)--------------------------------------------------
            var checkLeftSide: Bool = false
            var checkRightSide: Bool = false
            var nextCellAt = currentCellAt
            var alignedPoints: Int = -1
            
            /*
             While loop below is checking for left side
             */
            
            while !checkLeftSide{
                // we need to check for corners at the beginning
                if (nextCellAt >= 0 && nextCellAt <= cellcount-1 ) && (arrayOfUserDot[nextCellAt].playerType == currentPlayer.playerType) {
                   alignedPoints += 1
                    if didHitACorner(index: nextCellAt){ // check if hit right corner
                        // stop checking on the left side immediatelly
                        checkLeftSide = true
                    }
                    // change to next cell
                    nextCellAt -= (Int(Constant.numberOfColumn) + 1)
                }
                else{
                    // stop checking on the left side immediatelly
                    checkLeftSide = true
                }
                // check if alignedPoints reach 5
                if alignedPoints >= 5{
                    // yay current player wins
                    return true
                }
            }
            
            /*
             While loop below is checking for Right side
             */
            nextCellAt = currentCellAt
            while !checkRightSide{
                
                if (nextCellAt >= 0 && nextCellAt <= cellcount-1 ) && (arrayOfUserDot[nextCellAt].playerType == currentPlayer.playerType) {
                    alignedPoints += 1
                    if didHitACorner(index: nextCellAt){ // check if hit right corner
                        // stop checking on the Right side immediatelly
                        checkRightSide = true
                    }
                    nextCellAt += (Int(Constant.numberOfColumn) + 1)
                }
                else{
                    // stop checking on the left side immediatelly
                    checkRightSide = true
                }
                // check if alignedPoints reach 5
                if alignedPoints >= 5{
                    // yay current player wins
                    return true
                }
            }
            //--------------------------------------------check diagonal Upward (from left to right)--------------------------------------------------
            //recycling variables
            checkLeftSide = false
            checkRightSide = false
            nextCellAt = currentCellAt
            alignedPoints  = -1
            
            /*
             While loop below is checking for left side
             */
            
            while !checkLeftSide{
                
                if (nextCellAt >= 0 && nextCellAt <= cellcount-1 ) && (arrayOfUserDot[nextCellAt].playerType == currentPlayer.playerType) {
                    alignedPoints += 1
                    if didHitACorner(index: nextCellAt){ // check if hit right corner
                        // stop checking on the left side immediatelly
                        checkLeftSide = true
                    }
                    nextCellAt -= (Int(Constant.numberOfColumn) - 1)
                }
                else{
                    // stop checking on the left side immediatelly
                    checkLeftSide = true
                }
                // check if alignedPoints reach 5
                if alignedPoints >= 5{
                    // yay current player wins
                    return true
                }
            }
            
            /*
             While loop below is checking for Right side
             */
            nextCellAt = currentCellAt
            while !checkRightSide{
                
                if (nextCellAt >= 0 && nextCellAt <= cellcount-1 ) && (arrayOfUserDot[nextCellAt].playerType == currentPlayer.playerType) {
                    alignedPoints += 1
                    if didHitACorner(index: nextCellAt){ // check if hit right corner
                        // stop checking on the Right side immediatelly
                        checkRightSide = true
                    }
                    nextCellAt += (Int(Constant.numberOfColumn) - 1)
                }
                else{
                    // stop checking on the left side immediatelly
                    checkRightSide = true
                }
                // check if alignedPoints reach 5
                if alignedPoints >= 5{
                    // yay current player wins
                    return true
                }
            }
            
            //--------------------------------------------check Horizontally--------------------------------------------------
            //recycling variables
            checkLeftSide = false
            checkRightSide = false
            nextCellAt = currentCellAt
            alignedPoints  = -1
            
            /*
             While loop below is checking for left side
             */
            
            while !checkLeftSide{
                
                if (nextCellAt >= 0 && nextCellAt <= cellcount-1 ) && (arrayOfUserDot[nextCellAt].playerType == currentPlayer.playerType) {
                    alignedPoints += 1
                    if didHitACorner(index: nextCellAt){ // check if hit right corner
                        // stop checking on the left side immediatelly
                        checkLeftSide = true
                    }
                    nextCellAt -= 1
                }
                else{
                    // stop checking on the left side immediatelly
                    checkLeftSide = true
                }
                // check if alignedPoints reach 5
                if alignedPoints >= 5{
                    // yay current player wins
                    return true
                }
            }
            
            /*
             While loop below is checking for Right side
             */
            nextCellAt = currentCellAt
            while !checkRightSide{
                
                if (nextCellAt >= 0 && nextCellAt <= cellcount-1 ) && (arrayOfUserDot[nextCellAt].playerType == currentPlayer.playerType) {
                    alignedPoints += 1
                    if didHitACorner(index: nextCellAt){ // check if hit right corner
                        // stop checking on the Right side immediatelly
                        checkRightSide = true
                    }
                    nextCellAt += 1
                }
                else{
                    // stop checking on the left side immediatelly
                    checkRightSide = true
                }
                // check if alignedPoints reach 5
                if alignedPoints >= 5{
                    // yay current player wins
                    return true
                }
            }
            
            //--------------------------------------------check Vertically--------------------------------------------------
            //recycling variables
            checkLeftSide = false
            checkRightSide = false
            nextCellAt = currentCellAt
            alignedPoints  = -1
            
            /*
             While loop below is checking for left side
             */
            
            while !checkLeftSide{
                
                if (nextCellAt >= 0 && nextCellAt <= cellcount-1 ) && (arrayOfUserDot[nextCellAt].playerType == currentPlayer.playerType) {
                    alignedPoints += 1
                    if didHitACorner(index: nextCellAt){ // check if hit right corner
                        // stop checking on the left side immediatelly
                        checkLeftSide = true
                    }
                    nextCellAt -= Int(Constant.numberOfColumn)
                }
                else{
                    // stop checking on the left side immediatelly
                    checkLeftSide = true
                }
                // check if alignedPoints reach 5
                if alignedPoints >= 5{
                    // yay current player wins
                    return true
                }
            }
            
            /*
             While loop below is checking for Right side
             */
            nextCellAt = currentCellAt
            while !checkRightSide{
                
                if (nextCellAt >= 0 && nextCellAt <= cellcount-1 ) && (arrayOfUserDot[nextCellAt].playerType == currentPlayer.playerType) {
                    alignedPoints += 1
                    if didHitACorner(index: nextCellAt){ // check if hit right corner
                        // stop checking on the Right side immediatelly
                        checkRightSide = true
                    }
                    nextCellAt += Int(Constant.numberOfColumn)
                }
                else{
                    // stop checking on the left side immediatelly
                    checkRightSide = true
                }
                // check if alignedPoints reach 5
                if alignedPoints >= 5{
                    // yay current player wins
                    return true
                }
            }
            
        }
        else{
            // something went wrong. Move was not registered. Should inform us (log it)
            return false
        }
        
        // enter code to check if user wins or not
        
        return result
    }
    
    func changeUserTurn(){
        switch self.currentPlayer {
        case playerOne:
            currentPlayer = playerTwo
        case playerTwo:
            currentPlayer = playerOne
        default: break
            // should not happen
        }
    }
    
    func didHitRightCorner(index : Int)-> Bool{
        if index % Int(Constant.numberOfColumn) == Int(Constant.numberOfColumn) - 1{
            return true
        }
        else{
            return false
        }
    }
    
    func didHitLeftCorner(index : Int)-> Bool{
        if index % Int(Constant.numberOfColumn) == 0{
            return true
        }
        else{
            return false
        }
    }
    func didHitACorner(index: Int)->Bool{
        if didHitRightCorner(index: index) || didHitLeftCorner(index: index){
            return true
        }
        else{
            return false
        }
    }

}
