//
//  ScreenTitleLabel.swift
//  Morpion
//
//  Created by Jonathan on 10/30/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class ScreenTitleLabel: UILabel {

    /*
    override func draw(_ rect: CGRect) {
        // Drawing code
       ///self.font = UIFont(name: "Avenir-Light" , size: 20)
        //self.textColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1)

    }
 */
    
    override func layoutSubviews() {
        self.font = UIFont(name: "Avenir-Light" , size: 20)
        self.textColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1)
    }
    /*
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit(){
        self.font = UIFont(name: "AppleSDGothicNeo-Light" , size: 15)
        self.textColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1)
    }
 */
}
