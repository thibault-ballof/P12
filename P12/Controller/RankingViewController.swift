//
//  RankingViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit
import Firebase
import SDWebImage

class RankingViewController: UIViewController  {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var leaguesCollectionView: UICollectionView!
    @IBOutlet weak var leagueLabel: UILabel!

    
    //MARK: - Properties
    private let gamesCellIdentifier = "GamesCell"
    private let leaguesCellIdentifier = "LeaguesCell"
    private let rankingCellIdentifier = "RankingCell"
    private var selectedGame = UserDefaults.standard.object(forKey: "favoriteGames")
    private var selectedLeague = UserDefaults.standard.object(forKey: "favoriteLeagues")
    private var games: [String] = []
    private var leagues: [String] = []
    private var rankingCount = 0
    private var imgURL: [String] = []
    private var rankingData = [RankingData]()
    private let db = Firestore.firestore()
    private var documentData: [[String : Any]] = [[:]]
    private var dataFromDB: URLFromDB?
    private var leaguesFromDB: [URLFromDB]?


    
    override func viewDidLoad() {
        super.viewDidLoad()

        overrideUserInterfaceStyle = .dark


        // Set up XIB
        leaguesCollectionView.register(UINib.init(nibName: "LeaguesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: leaguesCellIdentifier)
        tableView.register(UINib.init(nibName: "RankingTableViewCell", bundle: nil), forCellReuseIdentifier: rankingCellIdentifier)
        gameCollectionView.register(UINib.init(nibName: "GamesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gamesCellIdentifier)


        gameCollectionView.showsHorizontalScrollIndicator = false
        leaguesCollectionView.showsHorizontalScrollIndicator = false
        getGamesList()
        getLeagueName()
        getLeagues(collection: "")
        if let url = leaguesFromDB?.first?.url {
            getRanking(url: url)
        }
        tableView.reloadData()
        if let selectedLeague = selectedLeague {
            leagueLabel.text = "\(selectedLeague)"
        }
    }





    //MARK: Fetch Game
    /// Get game List & game name
    func getGamesList() {
        self.games = [String]()

        Service.shared.fetchGameFromDB { data in

            for i in 1...data.count {

                self.games.append(data[i-1].name)

            }
            self.createGameArray()
            self.gameCollectionView.reloadData()

        }
    }
    //MARK: Set on 1rst position of collection user's favorite game
    func createGameArray() {
        for i in 1..<games.count {
            if selectedGame as! String == games[i-1] {
                games.remove(at: i-1)
            }
        }
        games.insert(UserDefaults.standard.object(forKey: "favoriteGames") as! String, at: 0)
    }

    //MARK: Get leagues for selected game
    func getLeagues(collection: String) {
        Service.shared.fetchLeagueDB(collection: selectedGame as! String) { data in

            self.leaguesFromDB = data
           // DispatchQueue.main.async {
            self.leaguesCollectionView.reloadData()
           // }
        }

        tableView.reloadData()
    }
    
//MARK: Get leagues name for selected game
    func getLeagueName() {
        Service.shared.fetchLeaguesFromDB(collection: selectedGame as! String) { data in
            self.leagues = data
           // DispatchQueue.main.async {
            self.leaguesCollectionView.reloadData()
          //  }
        }
    }
    //MARK: Fetch Ranking
    func getRanking(url: String) {
        NetworkCall.shared.method = .get
        NetworkCall.shared.headers = [:]
        NetworkCall.shared.url = url
        NetworkCall.shared.executeQuery(){
            (result: Result<[RankingData],Error>) in
            switch result{
            case .success(let post):
                self.rankingData = post
                self.leaguesCollectionView.reloadData()
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }

        tableView.reloadData()

    }

}

extension RankingViewController: UICollectionViewDataSource  {


//MARK: Set up CollectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == self.gameCollectionView {
            let gameCell =  gameCollectionView.dequeueReusableCell(withReuseIdentifier: gamesCellIdentifier, for: indexPath) as! GamesCollectionViewCell
            gameCell.gameImage.image = UIImage(named: "\(games[indexPath.row])")
            return gameCell
        } else {

            let leagueCell = leaguesCollectionView.dequeueReusableCell(withReuseIdentifier: leaguesCellIdentifier, for: indexPath) as! LeaguesCollectionViewCell
            leagueCell.leagueImage.sd_setImage(with: URL(string: leaguesFromDB![indexPath.row].imgurl!), placeholderImage: UIImage(named: "placeholder.png"))

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
        return leaguesFromDB?.count ?? 0

    }


}

extension RankingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // Distance Between Item Cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }

    // Cell Margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // gameCollectionView.deselectItem(at: indexPath as IndexPath, animated: true)
        if collectionView == self.gameCollectionView {
            gameCollectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .right)
            selectedGame = games[indexPath.row]
            getLeagueName()
            getLeagues(collection: selectedGame as! String)
            if let selectedLeague = selectedLeague {
                leagueLabel.text = "\(selectedLeague)"
            }

        } else {
            leaguesCollectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .right)
            selectedLeague = leaguesFromDB![indexPath.row].name
            if let selectedLeague = selectedLeague {
                leagueLabel.text = "\(selectedLeague)"
            }

            self.getRanking(url: self.leaguesFromDB![indexPath.row].url ?? "")

        }
    }
}

extension RankingViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingData.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    //MARK: Set up cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: rankingCellIdentifier, for: indexPath) as! RankingTableViewCell
        cell.teamLabel.text = rankingData[indexPath.row].team.name
        cell.rankLabel.text = "\(rankingData[indexPath.row].rank)"
        cell.scoreLabel.text = "\(rankingData[indexPath.row].wins ?? 0)" + " - " + "\(rankingData[indexPath.row].losses ?? 0)"
        
        cell.teamImage.sd_setImage(with: URL(string: rankingData[indexPath.row].team.imageURL), placeholderImage: UIImage(named: "placeholder.png"))

        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}



