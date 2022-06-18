//
//  RankingViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit

class RankingViewController: UIViewController  {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var leaguesCollectionView: UICollectionView!
    
    
    //MARK: - Properties
    private let gamesCellIdentifier = "GamesCell"
    private let leaguesCellIdentifier = "LeaguesCell"
    private let rankingCellIdentifier = "RankingCell"
    private var selectedGame = "lol"
    private let games = ["lol", "CSGO", "OW", "R6", "Valorant"]
    private var slug = ""
    private var leagues: [String] = []
    private var rankingCount = 0
    private var rankingData = [RankingData]()
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getRanking()
        leaguesCollectionView.register(UINib.init(nibName: "LeaguesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: leaguesCellIdentifier)
        tableView.register(UINib.init(nibName: "RankingTableViewCell", bundle: nil), forCellReuseIdentifier: rankingCellIdentifier)
        gameCollectionView.showsHorizontalScrollIndicator = false
        leaguesCollectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func getRanking() {
        Service.shared.fetchRanking { ranking in
            self.rankingData = ranking!
            self.tableView.reloadData()
            
        }
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
            Service.shared.fetchLeagues(game: games[indexPath.row]) { leagues in
                leagueCell.label.text = "\(leagues![indexPath.row].league.name)"
            }
            
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
        return 5
        
    }
    
    
}
extension RankingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        gameCollectionView.deselectItem(at: indexPath as IndexPath, animated: true)
        selectedGame = games[indexPath.row]
        
        leaguesCollectionView.reloadData()
    }
}

extension RankingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rankingCellIdentifier, for: indexPath) as! RankingTableViewCell
        cell.teamLabel.text = rankingData[indexPath.row].team.name
        cell.rankLabel.text = "\(rankingData[indexPath.row].rank)"
        cell.scoreLabel.text = "\(rankingData[indexPath.row].wins)" + " - " + "\(rankingData[indexPath.row].losses)"
        Service.shared.fetchImage(url: rankingData[indexPath.row].team.imageURL, image: cell.teamImage!)
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
