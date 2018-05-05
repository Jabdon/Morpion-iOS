//
//  User.swift
//  Morpion
//
//  Created by Jonathan on 10/31/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class Player: NSObject {
    
    enum UserPlayer {
        case playerOne
        case playerTwo
        case none
    }
    
    var playerType: UserPlayer
    

    //user name
    var name: String!
    //user score
    var score: Int = 0
    // user symbol/mark
    var userSymbol: UIImage!
    // user ID
    var user_ID: Int?
    
    
    // init func
    init( user: UserData, playerType : UserPlayer) {
        self.name = user.username
        self.user_ID = user.userID
        self.playerType = playerType
        super.init()
        self.userSymbol = self.userImage(player: playerType)
        
    }
    
    
    // init a Non-player
    override init (){
        self.playerType = .none
        super.init()
        self.userSymbol = self.userImage(player: .none)
    }
    
    private func userImage( player: UserPlayer) -> UIImage{
        switch player {
        case .playerOne:
            return UIImage(named: "circle")!
        case .playerTwo:
            return UIImage(named: "cross")!
        case .none:
            return UIImage(named: "dot")!
        }
    
    }
    
    // function that will increment user score
    func playerWins(){
        self.score += 1
    }
    
}
