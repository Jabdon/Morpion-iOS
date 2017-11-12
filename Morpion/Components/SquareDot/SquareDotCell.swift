//
//  SquareDotCell.swift
//  Morpion
//
//  Created by Jonathan on 11/2/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class SquareDotCell: UICollectionViewCell {

    //Userobject when square is taken by a user
    var userTaken: User! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // this function should handle when user taps on it
    func userHasTappedOn(user: User)->Bool{
        //check first if it is already taken
        if istaken(){
            //if user is taken do not do anything
            
        }
        else{
            //if user not taken then do something
            
        }
        
    }
    
    
    // methos would indicate if this square has already been registered
    func istaken()->Bool{
        if userTaken == nil {
            return false
        }
        else{
            return true
        }
    }
    
    // this function will reset a square
    func clear(){
        var userTaken: User! = nil
    }

}
