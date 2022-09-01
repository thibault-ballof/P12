//
//  UIViewController+CreateArray.swift
//  P12
//
//  Created by Thibault Ballof on 01/09/2022.
//

import Foundation
import UIKit
extension UIViewController {


    func createGameArray(games: [GamesObject], collectionView: UICollectionView, selectedGame: String) {

        for i in 1..<games.count {
            if selectedGame == games[i-1].name {
                games.remove(at: i-1)
            }
        }
        //games.insert(UserDefaults.standard.object(forKey: "favoriteGames") as! String, at: 0)
        collectionView.reloadData()
    }
}
