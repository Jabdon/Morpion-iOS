//
//  NameTextField.swift
//  Morpion
//
//  Created by Jonathan on 10/29/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class NameTextField: UITextField {

    override func draw(_ rect: CGRect) {
        // Drawing code
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.font = UIFont(name: "HelveticaNeue-UltraLight", size: 30)
    }
    /*
    override func layoutSubviews() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.font = UIFont(name:"AppleSDGothicNeo-Light" , size: 16)
    }
 */


}
