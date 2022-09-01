//
//  GamesCollectionViewCell.swift
//  P12
//
//  Created by Thibault Ballof on 13/06/2022.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell{

    

//MARK: OUTLETS
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var view: UIView!
    


    //MARK: Set up circle cells
    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
            self.layer.cornerRadius = self.frame.size.width / 2

        }
    override class func awakeFromNib() {
    }
    //MARK: Adding border to cell when the cell is selected
    override var isSelected: Bool{
           didSet {
               if self.isSelected {
                   self.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
                   self.layer.borderWidth = 1.5
               } else {
                   self.layer.borderWidth = 0
                   view.layer.borderColor = nil
               }
           }
       }
}

