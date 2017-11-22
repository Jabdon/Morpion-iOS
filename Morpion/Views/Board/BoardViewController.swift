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
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var boardCollectionview: UICollectionView!
    var cellInfo : CellSizeInfo?
    let boardModel: BoardModel
    
    init(playerOne: User, playerTwo: User) {
        self.boardModel = BoardModel(player1: playerOne, player2: playerTwo, cellCount: Int(Constant.numberOfColumn)*Int(Constant.numberOfRow))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        let sizeToWorkWith: CGFloat = screenHeight * (1 - (topViewHeight.multiplier + bottomViewHeight.multiplier))
        var cellDimension: CGFloat = screenWidth / Constant.numberOfColumn
        var itFits: Bool = true
        while itFits {
            let newHeight = cellDimension * Constant.numberOfRow
            if(newHeight <= sizeToWorkWith){
                itFits = false
            }
            else{
                cellDimension -= 1
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
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }*/
 
    
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
