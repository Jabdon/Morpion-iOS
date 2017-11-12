//
//  OptionViewControler.swift
//  Morpion
//
//  Created by Jonathan on 10/28/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class OptionViewControler: UIViewController {

    @IBOutlet weak var titleLabel: ScreenTitleLabel!
    @IBOutlet weak var humanvsHumanButton: RoundButton!
    @IBOutlet weak var humanvsCpuButton: RoundButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    // this method should take user to Enter name screen
    @IBAction func selectHumanOption(_ sender: Any) {
        let  nameViewController = EnterNameViewController()
        self.show(nameViewController, sender: nil)
    }
    
}
