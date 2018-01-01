//
//  SplashViewController.swift
//  Morpion
//
//  Created by Jonathan on 1/1/18.
//  Copyright © 2018 Ansilans. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var Logo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            
            UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                // put here the code you would like to animate
                self.Logo.alpha = 0
                self.view.layoutIfNeeded()
                
            }, completion: {(finished:Bool) in
                // the code you put here will be compiled once the animation finishes
                UIView.animate(withDuration: 0, animations: {
                    let enterName = EnterNameViewController()
                    self.present(enterName, animated: false, completion: nil)
                    self.view.layoutIfNeeded()
                })
            //self.performSegue(withIdentifier: "leadingToTutorial", sender: self)
            })
        // Do any additional setup after loading the view.
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
