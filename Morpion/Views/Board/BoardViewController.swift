//
//  BoardViewController.swift
//  Morpion
//
//  Created by Jonathan on 11/2/17.
//  Copyright © 2017 Ansilans. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewBoard: UICollectionView!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var boardCollectionview: UICollectionView!
    @IBOutlet weak var scoreBoardContainerHeight: NSLayoutConstraint!
    @IBOutlet weak var boardCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scoreBoardBottomConstraint: NSLayoutConstraint!
    
    let constantToMoveUpScoreboardBy: CGFloat = UIScreen.main.bounds.height * 0.9
    let constantToDismissScoreboardBy: CGFloat = UIScreen.main.bounds.height * 0.2
    
    //
    var scoreBoardIsShown: Bool = false
    
    var cellInfo : CellSizeInfo?
    let boardModel: BoardModel
    
    @IBOutlet weak var playerOneNametext: UILabel!
    @IBOutlet weak var playerTwoNametext: UILabel!
    
    
    init(playerOne: User, playerTwo: User) {
        self.boardModel = BoardModel(player1: playerOne, player2: playerTwo, cellCount: Int(Constant.numberOfColumn)*Int(Constant.numberOfRow))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScoreBoard()
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
        var cellDimension: CGFloat = screenWidth / Constant.numberOfColumn
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
        let cellMinSpacing = (screenWidth - (cellDimension * Constant.numberOfColumn)) / Constant.numberOfColumn
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
        
        if boardModel.didUserWin(indexPath: indexPath){
            // user wins code
            let currentCell = boardCollectionview.cellForItem(at: indexPath) as! SquareDotCell
            currentCell.loadData(user: boardModel.arrayOfUserDot[indexPath.row])
            // win
            let alert = UIAlertController(title: "We Got A Winner", message: "Congrats! \(boardModel.currentPlayer.name!)", preferredStyle: UIAlertControllerStyle.alert)
            
            /*
             // testing add image in alertview
            let imgTitle = UIImage(named:"dot")
            let imgViewTitle = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
            imgViewTitle.image = imgTitle
            alert.view.addSubview(imgViewTitle)
             */
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let currentCell = boardCollectionview.cellForItem(at: indexPath) as! SquareDotCell
            currentCell.loadData(user: boardModel.arrayOfUserDot[indexPath.row])
            
            
        }
        boardCollectionview.reloadItems(at: [indexPath])
        boardModel.changeUserTurn()
        
    }
 
    @IBAction func showOrDismissScoreBoard() {
        if scoreBoardIsShown{
            //dismiss it
            UIView.animate(withDuration: 0.35, animations: {
                self.scoreBoardBottomConstraint.constant =  self.constantToMoveUpScoreboardBy
                self.view.layoutIfNeeded()
            })
            scoreBoardIsShown = false
        }
        else{
            // then show it
            UIView.animate(withDuration: 0.35, animations: {
                self.scoreBoardBottomConstraint.constant =  self.constantToDismissScoreboardBy
                self.view.layoutIfNeeded()
            })
            scoreBoardIsShown = true
        }
    }
    
    func setupScoreBoard(){
        scoreBoardBottomConstraint.constant =  constantToMoveUpScoreboardBy
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
