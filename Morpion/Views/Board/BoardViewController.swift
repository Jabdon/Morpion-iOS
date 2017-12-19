//
//  BoardViewController.swift
//  Morpion
//
//  Created by Jonathan on 11/2/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit
import JSSAlertView

class BoardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewBoard: UICollectionView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var boardCollectionview: UICollectionView!
    @IBOutlet weak var scoreBoardContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var boardCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scoreBoardBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var boardCollectionWidth: NSLayoutConstraint!
    @IBOutlet weak var scoreBoardBackgroundView: UIView!
    
    // boardscore constraint
    @IBOutlet weak var scorePlayerTwoView: UIView!
    @IBOutlet weak var scorePlayerOneView: UIView!
    @IBOutlet weak var scoreBoardPlayerOneName: UILabel!
    @IBOutlet weak var scoreBoardPlayerTwoName: UILabel!
    @IBOutlet weak var playerTwoScorePts: UILabel!
    @IBOutlet weak var playerOneScorePts: UILabel!
    
    
    let constantToMoveUpScoreboardBy: CGFloat = UIScreen.main.bounds.height * 0.9
    let constantToDismissScoreboardBy: CGFloat = UIScreen.main.bounds.height * 0.2
    
    //
    var scoreBoardIsShown: Bool = false
    
    var cellInfo : CellSizeInfo?
    let boardModel: BoardModel
    
    @IBOutlet weak var playerOneNametext: PlayerNameText!
    @IBOutlet weak var playerTwoNametext: PlayerNameText!
    
    @IBOutlet weak var playerOneNameContainer: UIView!
    @IBOutlet weak var playerTwoNameContainer: UIView!
    @IBOutlet weak var dismissOrShowButton: UIButton!
    @IBOutlet weak var scoreboardView: UIView!
    
    @IBAction func restartGame() {
        
        //show alert
        let customIcon:UIImage = UIImage(named:"error_Image")! // your custom icon UIImage
        let customColor:UIColor = UIColorFromHex(0xF3F4F6, alpha: 1) // base color for the alert
        let alertview = JSSAlertView().show(
            self,
            title: "One More!",
            text: "Are You Sure You Want To Restart The Game?",
            buttonText: "Yep!",
            cancelButtonText: "Nope",
            color: customColor,
            iconImage: customIcon)
        //Make phone vibrate
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
        alertview.addAction {
            self.removeLines(info: self.boardModel.winInfo)
            self.boardModel.refreshArray()
            self.boardCollectionview.reloadData()
            self.showOrDismissScoreBoard()
            
        }
        
    }
    
    @IBAction func undoGame() {
        //show alert
        if (self.boardModel.winInfo.winnerPlayer == nil){
            let customIcon:UIImage = UIImage(named:"error_Image")! // your custom icon UIImage
            let customColor:UIColor = UIColorFromHex(0xF3F4F6, alpha: 1) // base color for the alert
            let alertview = JSSAlertView().show(
                self,
                title: "Back In Time",
                text: "Are You Sure You Want To Undo The Latest Move?",
                buttonText: "Yep!",
                cancelButtonText: "Nope",
                color: customColor,
                iconImage: customIcon)
            //Make phone vibrate
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
            alertview.addAction {
                    self.boardModel.undoPlay()
                    self.updatePlayerNameText()
                    self.boardCollectionview.reloadData()
                    self.showOrDismissScoreBoard()
                
                
            }
        }
        else{
            let customIcon:UIImage = UIImage(named:"error_Image")! // your custom icon UIImage
            let customColor:UIColor = UIColorFromHex(0xF3F4F6, alpha: 1) // base color for the alert
            JSSAlertView().show(
                self,
                title: "Back In Time",
                text: "Sorry, Cannot Undo. There is Already A Winner",
                buttonText: "Got It!",
                color: customColor,
                iconImage: customIcon)
            
        }
        
    }
    
    
    
    init(playerOne: User, playerTwo: User) {
        self.boardModel = BoardModel(player1: playerOne, player2: playerTwo, cellCount: Int(Constant.numberOfColumn)*Int(Constant.numberOfRow))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true
        self.setupScoreBoard()
        
        // Do any additional setup after loading the view.
        // assign names
        playerOneNametext.text = boardModel.playerOne.name
        playerTwoNametext.text = boardModel.playerTwo.name
        
        //set up info name
        self.setCellInfo()
         collectionViewBoard.dataSource = self
        collectionViewBoard.delegate = self
        let nib = UINib(nibName: "SquareDotCell", bundle: nil)
        collectionViewBoard?.register(nib, forCellWithReuseIdentifier: "squareDot")
        boardCollectionview.reloadData()
        
        //register action
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapTodismiss))
        self.scoreBoardBackgroundView.addGestureRecognizer(gesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct CellSizeInfo {
        var cellSize: CGFloat
        var cellMinSpacing: CGFloat
    }
    
    func setCellInfo(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        // CollectionView height must be at least
        let sizeToWorkWith: CGFloat = boardCollectionViewHeight.multiplier * screenHeight
        let widthToWorkWith: CGFloat = boardCollectionWidth.multiplier * screenWidth
        var cellDimension: CGFloat = widthToWorkWith / Constant.numberOfColumn
        var itDoesntFits: Bool = true
        while itDoesntFits {
            //check for height
            let newHeight = cellDimension * Constant.numberOfRow
            if(newHeight <= sizeToWorkWith){
                // yay it fits the height
                itDoesntFits = false
            }
            else{
                cellDimension -= 0.5
            }
            
        }
        let cellMinSpacing = (widthToWorkWith - (cellDimension * Constant.numberOfColumn)) / Constant.numberOfColumn
        self.cellInfo = CellSizeInfo(cellSize: cellDimension, cellMinSpacing: cellMinSpacing)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return boardModel.arrayOfUserDot.count //Int (Constant.numberOfColumn * Constant.numberOfRow)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "squareDot", for: indexPath) as! SquareDotCell
        cell.loadData(user: boardModel.arrayOfUserDot[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // let cellSize = determineProperCellInfo()
        return CGSize(width: self.cellInfo!.cellSize , height: self.cellInfo!.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellMinSpacing =  self.cellInfo?.cellMinSpacing
        return cellMinSpacing!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // if there's already a winner let user(s) know that they need to restart the game
        if boardModel.winInfo.winnerPlayer == nil {
            if boardModel.didUserWin(indexPath: indexPath){
                // user wins code
                let currentCell = boardCollectionview.cellForItem(at: indexPath) as! SquareDotCell
                currentCell.loadData(user: boardModel.arrayOfUserDot[indexPath.row])
                updateScoreBoard()
                drawlines(info: boardModel.winInfo)
                // win alert
                let customIcon:UIImage = UIImage(named:"trophy_Image")! // your custom icon UIImage
                let customColor:UIColor = UIColorFromHex(0xF3F4F6, alpha: 1) // base color for the alert
                JSSAlertView().show(
                    self,
                    title: "We Got a Winner!",
                    text: "Yay! \(boardModel.winInfo.winnerPlayer?.name! ?? "No name") won this round. One more round?",
                    buttonText: "Ok!",
                    color: customColor,
                    iconImage: customIcon)
            }
            else{
                let currentCell = boardCollectionview.cellForItem(at: indexPath) as! SquareDotCell
                currentCell.loadData(user: boardModel.arrayOfUserDot[indexPath.row])
                
                
            }
            //boardCollectionview.reloadItems(at: [indexPath])
            updatePlayerNameText()
            
        }
        
        else{
            // show an alert
            let customIcon:UIImage = UIImage(named:"trophy_Image")! // your custom icon UIImage
            let customColor:UIColor = UIColorFromHex(0xF3F4F6, alpha: 1) // base color for the alert
            JSSAlertView().show(
                self,
                title: "We Got a Winner!",
                text: "\(boardModel.winInfo.winnerPlayer?.name! ?? "No name") already won this round. You Can Start Another Round ",
                buttonText: "Got It!",
                color: customColor,
                iconImage: customIcon)
        }

    }
    
    @objc func tapTodismiss(){
        self.showOrDismissScoreBoard()
    }
 
    @IBAction func showOrDismissScoreBoard() {
        if scoreBoardIsShown{
            //dismiss it
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0.25, animations: {
                self.scoreBoardBottomConstraint.constant =  self.constantToMoveUpScoreboardBy
                self.scoreBoardBackgroundView.alpha = 0
                self.dismissOrShowButton.transform = self.dismissOrShowButton.transform.rotated(by: (180.0 * CGFloat(Double.pi)) / 180.0)
                // remove shadow
                self.scoreboardView.layer.shadowOpacity = 0.0
                self.view.layoutIfNeeded()
            })
            scoreBoardIsShown = false
        }
        else{
            // then show it
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
                // put here the code you would like to animate
                self.scoreBoardBottomConstraint.constant =  self.constantToDismissScoreboardBy - 10
                self.scoreBoardBackgroundView.alpha = 1
                self.dismissOrShowButton.transform = self.dismissOrShowButton.transform.rotated(by: (180.0 * CGFloat(Double.pi)) / 180.0)
                self.view.layoutIfNeeded()
                
            }, completion: {(finished:Bool) in
                // the code you put here will be compiled once the animation finishes
                UIView.animate(withDuration: 0.06, animations: {
                    self.scoreBoardBottomConstraint.constant =  self.constantToDismissScoreboardBy + 2
                    self.view.layoutIfNeeded()
                }, completion: {(finished:Bool) in
                    // the code you put here will be compiled once the animation finishes
                    UIView.animate(withDuration: 0.05, animations: {
                        self.scoreBoardBottomConstraint.constant =  self.constantToDismissScoreboardBy
                        self.scoreboardView.layer.shadowColor = UIColor.lightGray.cgColor
                        self.scoreboardView.layer.shadowOpacity = 0.1
                        self.scoreboardView.layer.shadowOffset = CGSize.zero
                        self.scoreboardView.layer.shadowRadius = 2
                        
                        //make phone vibrate
                        let generator = UIImpactFeedbackGenerator(style: .light)
                        generator.impactOccurred()
                        
                        //conventional
                        self.view.layoutIfNeeded()
                    })
                })
            })
            
            
            scoreBoardIsShown = true
        }
    }
    
    func setupScoreBoard(){
        scoreBoardBottomConstraint.constant =  constantToMoveUpScoreboardBy
        
        // scoreboard
        scorePlayerOneView.layer.borderWidth = 0.5
        scorePlayerOneView.layer.borderColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1).cgColor
        scorePlayerOneView.layer.cornerRadius = 5
        scorePlayerTwoView.layer.borderWidth = 0.5
        scorePlayerTwoView.layer.borderColor = UIColor(red: 157/255, green: 157/255, blue: 157/255, alpha: 1).cgColor
        scorePlayerTwoView.layer.cornerRadius = 5
        
        //scoreboard data
        scoreBoardPlayerOneName.text = boardModel.playerOne.name
        scoreBoardPlayerTwoName.text = boardModel.playerTwo.name
        updateScoreBoard()
        updatePlayerNameText()
        
        //
        
        
        //blur effect to background
        /*
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark )
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = scoreBoardBackgroundView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scoreBoardBackgroundView.addSubview(blurEffectView)
         */
    }
    func updateScoreBoard() {
            self.playerOneScorePts.text =  String (self.boardModel.playerOne.score)
            self.playerTwoScorePts.text =  String (self.boardModel.playerTwo.score)
        
    }
    
    func updatePlayerNameText(){
        
        if self.boardModel.currentPlayer == self.boardModel.playerOne{
            
            UIView.animate(withDuration: 0.20, animations: {
                self.setLabelPlayerNameToDefault(View: self.playerTwoNameContainer)
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.40, animations: {
                self.setLabelPlayerNameToTurn(View: self.playerOneNameContainer)
                self.view.layoutIfNeeded()
            })
            
            
        }
        else{
            UIView.animate(withDuration: 0.20, animations: {
                self.setLabelPlayerNameToDefault(View: self.playerOneNameContainer)
                self.view.layoutIfNeeded()
            })
            
            UIView.animate(withDuration: 0.40, animations: {
                self.setLabelPlayerNameToTurn(View: self.playerTwoNameContainer)
                self.view.layoutIfNeeded()
            })
            
            
        }
        /*
        UIView.animate(withDuration: 0.35, animations: {
            self.view.layoutIfNeeded()
        })
        */
        
    }
    
    func setLabelPlayerNameToTurn(View: UIView){
        View.layer.borderColor = UIColor.black.cgColor
        View.layer.cornerRadius = 10
        View.layer.backgroundColor = UIColor.black.cgColor
         let labels = View.subviews.flatMap { $0 as? UILabel }
       // label.tex = UIColor.white
        for label in labels{
            label.textColor = UIColor.white
        }
        
    }
    
    func setLabelPlayerNameToDefault( View: UIView){
        View.layer.borderColor = UIColor.black.cgColor
        View.layer.cornerRadius = 10
        View.layer.backgroundColor = UIColor(white: 1, alpha: 0.5).cgColor
        //label.textColor = UIColor.lightGray
        let labels = View.subviews.flatMap { $0 as? UILabel }
        for label in labels{
            label.textColor = UIColor.lightGray
        }
    }
    
    func drawlines(info: winningInfo){
        for i in info.pointsAligned{
            let index: IndexPath = IndexPath.init(row: i, section: 0)
            let square = boardCollectionview.cellForItem(at: index) as! SquareDotCell
            square.drawline(line: info.lineSegment)
            print(square.description) 
        }
    }
    
    func removeLines( info: winningInfo){
        for i in info.pointsAligned{
            let index: IndexPath = IndexPath.init(row: i, section: 0)
            let cell = boardCollectionview.cellForItem(at: index) as! SquareDotCell
            cell.layer.sublayers?.remove(at: 1)
            //cell.layer.sublayers = nil
            print(cell.description)
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
