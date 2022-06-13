//
//  RankingViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit

class RankingViewController: UIViewController  {
    
    
    @IBOutlet weak var gameCollectionView: UICollectionView!
    
    @IBOutlet weak var leaguesCollectionView: UICollectionView!
    
    private let gamesCellIdentifier = "GamesCell"
    private let leaguesCellIdentifier = "LeaguesCell"
    private var selectedGame = "LoL"
    private let games = ["LoL", "CSGO", "OW", "R6", "Valorant"]
    private var slug = ""
    private var leagues: [String] = []
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leaguesCollectionView.register(UINib.init(nibName: "LeaguesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: leaguesCellIdentifier)
        
        
    }
    

   

}
extension RankingViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.gameCollectionView {
            let gameCell =  gameCollectionView.dequeueReusableCell(withReuseIdentifier: gamesCellIdentifier, for: indexPath) as! GamesCollectionViewCell
            gameCell.Label.text = games[indexPath.row]
            gameCell.gameImage.image = UIImage(named: "\(games[indexPath.row])")
            return gameCell
        } else {
            let leagueCell = leaguesCollectionView.dequeueReusableCell(withReuseIdentifier: leaguesCellIdentifier, for: indexPath) as! LeaguesCollectionViewCell
            switch selectedGame {
            case "LoL":
                print("cc")
                leagues = ["lfl", "lec"]
            default:
                print("pa cc")
            }
            
            leagueCell.label.text = "BG"
            leagueCell.leagueImage.image = UIImage(named: "\(games[indexPath.row])")
            return leagueCell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.gameCollectionView {
            return games.count
        }
        return leagues.count
    }
    
    
}
extension RankingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gameCollectionView.deselectItem(at: indexPath as IndexPath, animated: true)
         selectedGame = games[indexPath.row]
        leaguesCollectionView.reloadData()
    }
}
