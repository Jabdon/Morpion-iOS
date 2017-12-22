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
    /*
    override func draw(_ rect: CGRect) {
        let startingY: CGFloat = self.frame.origin.y + (self.frame.height/2)
        let startingX: CGFloat = self.frame.origin.x
        
        let endingY: CGFloat = startingY
        let endingX: CGFloat = self.frame.origin.x + self.frame.width
        
        let aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x: startingX/*Put starting Location*/, y:startingY /*Put starting Location*/))
        
        aPath.addLine(to: CGPoint(x: endingX/*Put Next Location*/, y: endingY/*Put Next Location*/))
        
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.red.set()
        aPath.stroke()
        //If you want to fill it as well
        aPath.fill()
    }
 */
}

enum lineSegment {
    case horizontal
    case vertical
    case diagonalUpward
    case diagonalDownward
    case none
}
