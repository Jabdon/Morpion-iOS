//
//  EnterNameViewController.swift
//  Morpion
//
//  Created by Jonathan on 10/28/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit
import JSSAlertView

class EnterNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var playerOneLabel: NameTextField!
    @IBOutlet weak var playerTwoLabel: NameTextField!
    @IBOutlet weak var firstTextfieldUiViewTopConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var secondTextfieldUiView: TextFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        playerOneLabel.delegate = self
        playerTwoLabel.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
 */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.playerOneLabel.text = ""
        self.playerTwoLabel.text = ""
    }
    
    @IBAction func startGame(_ sender: Any){
        
        if let playerOneName = playerOneLabel.text,let playerTwoName = playerTwoLabel.text, !playerOneName.isEmpty, !playerTwoName.isEmpty  {
            let player1 = User(name: playerOneName, player: .playerOne)
            let player2 = User(name: playerTwoName, player: .playerTwo)
            
            let boardCollectionView = BoardViewController(playerOne: player1, playerTwo: player2)
            self.show(boardCollectionView, sender: nil)
          
            
        }
        else{
            let customIcon:UIImage = UIImage(named:"header_Image")! // your custom icon UIImage
            let customColor:UIColor = UIColorFromHex(0xF3F4F6, alpha: 1) // base color for the alert
            JSSAlertView().show(
                self,
                title: "Oops!",
                text: "Name cannot be empty.",
                buttonText: "Got It!",
                color: customColor,
                iconImage: customIcon)
         
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
        }
       
    }
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, animations: {
            self.firstTextfieldUiViewTopConstraint.constant = 151.0
            self.view.layoutIfNeeded()
        })
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.utf16.count + string.utf16.count - range.length
        return newLength <= 8
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.25, animations: {
            self.firstTextfieldUiViewTopConstraint.constant = 151.0
            self.view.layoutIfNeeded()
        })
        
        return false
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if let info = notification.userInfo{
            let rect: CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            let keyboardY = view.frame.size.height - rect.height
            let secondTextFieldUiViewBottomY = self.secondTextfieldUiView.frame.origin.y + self.secondTextfieldUiView.frame.size.height
            
            // if keyboard overlaps or blocks the second textfield, then move up textfields
            if keyboardY <= secondTextFieldUiViewBottomY{
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 0.25, animations: {
                    self.firstTextfieldUiViewTopConstraint.constant = 100.0
                    self.view.layoutIfNeeded()
                })
                
            }
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
