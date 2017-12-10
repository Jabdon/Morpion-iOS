//
//  PlayerNameText.swift
//  Morpion
//
//  Created by Jonathan on 12/9/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class PlayerNameText: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 1, left: 0, bottom: 1, right: 0)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }

}
