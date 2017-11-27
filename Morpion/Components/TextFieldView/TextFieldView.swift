//
//  TextFieldView.swift
//  Morpion
//
//  Created by Jonathan on 10/29/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class TextFieldView: UIView  {

    override func draw(_ rect: CGRect) {
        // Drawing code
        let border = CALayer()
        border.backgroundColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1).cgColor
        border.frame = CGRect(x:0.0, y: self.frame.height - 1, width: self.frame.width , height: 0.5)
        self.layer.addSublayer(border)
    }

    
    

}
