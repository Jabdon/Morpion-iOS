//
//  EnterNameViewController.swift
//  Morpion
//
//  Created by Jonathan on 10/28/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class EnterNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var playerOneLabel: NameTextField!
    @IBOutlet weak var playerTwoLabel: NameTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        playerOneLabel.delegate = self
        playerTwoLabel.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGame(_ sender: Any){
        
        if let playerOneName = playerOneLabel.text,let playerTwoName = playerTwoLabel.text, !playerOneName.isEmpty, !playerTwoName.isEmpty  {
            let player1 = User(name: playerOneName, player: .playerOne)
            let player2 = User(name: playerTwoName, player: .playerTwo)
            
            let boardCollectionView = BoardViewController(playerOne: player1, playerTwo: player2)
            self.show(boardCollectionView, sender: nil)
            
        }
        else{
            let alert = UIAlertController(title: "Oops", message: "Name cannot be empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 8
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
