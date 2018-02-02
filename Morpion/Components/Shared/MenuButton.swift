//
//  MenuButton.swift
//  Morpion
//
//  Created by Jonathan on 2/1/18.
//  Copyright © 2018 Ansilans. All rights reserved.
//

import UIKit

class MenuButton: UIButton {


    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    /*override func draw(_ rect: CGRect) {
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 100
    } */
    override func awakeFromNib() {
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor(red: 90/255, green: 105/255, blue: 120/255, alpha: 1).cgColor
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }


}
