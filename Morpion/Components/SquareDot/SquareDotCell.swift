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
    @IBOutlet weak var squareDotSymbol: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData( user: User){
        self.squareDotSymbol.image = user.userSymbol
    }
}
