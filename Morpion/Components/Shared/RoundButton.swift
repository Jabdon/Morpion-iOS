//
//  RoundButton.swift
//  Morpion
//
//  Created by Jonathan on 10/29/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class RoundButton: UIButton {


    override func draw(_ rect: CGRect) {
        // Drawing code
        self.layer.borderWidth = 0.2
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 20
        self.setTitleColor(UIColor.darkGray, for: UIControlState.normal)
        self.titleLabel?.font = UIFont(name: "Avenir-Light", size: 18)
    }
 

}
