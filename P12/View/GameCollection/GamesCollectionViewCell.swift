//
//  GamesCollectionViewCell.swift
//  P12
//
//  Created by Thibault Ballof on 13/06/2022.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell{
    
    
    private var cornerRadius: CGFloat = 5
    


    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var view: UIView!
    



    override func draw(_ rect: CGRect) { //Your code should go here.
        super.draw(rect)
            self.layer.cornerRadius = self.frame.size.width / 2

        }
    override class func awakeFromNib() {
    }

    override var isHighlighted: Bool {
           didSet {
               if self.isSelected {
                   print("yes")
                   self.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
                   self.layer.borderWidth = 1
                   //view.layer.borderColor = CGColor(red: 255, green: 0, blue: 0, alpha: 1)
                   //setupcolor(view: view)
                  // view.layer.borderWidth = 5
               } else {
                   print("no")
                   self.layer.borderWidth = 0
                   view.layer.borderColor = nil
               }
           }
       }

    func setupcolor(view: UIView) {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.view.frame.size)
        gradient.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]

        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(rect: self.view.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.view.layer.addSublayer(gradient)
    }



}

