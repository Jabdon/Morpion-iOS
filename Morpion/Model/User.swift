//
//  User.swift
//  Morpion
//
//  Created by Jonathan on 10/31/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class User: NSObject {
    
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
    
    
    // init func
    init( name: String, player: UserPlayer) {
        self.name = name
        self.playerType = player
        super.init()
        self.userSymbol = self.userImage(player: player)
        
    }
    
    // init a Non-player
    init (player: UserPlayer){
        self.playerType = player
        super.init()
        self.userSymbol = self.userImage(player: player)
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
    func userWins(){
        self.score += 1
    }
    
}
