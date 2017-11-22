//
//  CustomAlertViewController.swift
//  Morpion
//
//  Created by Jonathan on 10/31/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func transition(animateIn: Bool){
        UIView.animate(withDuration: 0.2, animations: {
            if animateIn{
                self.visualEffect.effect = UIBlurEffect(style: .light)
            }
            else{
                self.visualEffect.effect = nil
            }
            
        }) { (success) in
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
