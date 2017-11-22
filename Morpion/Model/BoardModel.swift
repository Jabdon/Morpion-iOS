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
    var currentPlayer: User.UserPlayer!
    var cellcount : Int
    
    var arrayOfUserDot: [User]
    
    init(player1: User, player2: User, cellCount: Int){
        self.playerOne = player1
        self.playerTwo = player2
        self.currentPlayer = .playerOne
        self.cellcount = cellCount
        self.arrayOfUserDot = Array(repeatElement(User(player: .none), count: cellcount))
        
        super.init()
    }
    
    private func registerAMove(indexPath: IndexPath)-> Bool {
        // since there is possiblity that user may be nil
        let user : User? = self.arrayOfUserDot[indexPath.row]
        if user?.playerType == .none {
            user?.playerType = currentPlayer
            return true
        }
        else{
            return false
        }
    }
    
     func didUserWin(indexPath: IndexPath) -> Bool{
        var result: Bool = false
        if registerAMove(indexPath: indexPath){
            // check if user win
        }
        else{
            // something went wrong. Move was not registered. Should inform us (log it)
            return false
        }
        
        // enter code to check if user wins or not
        
        return result
    }
}
