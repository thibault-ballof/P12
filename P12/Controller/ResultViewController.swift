//
//  ResultViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit
import SDWebImage
import Firebase
import Lottie
import SwiftUI



class ResultViewController: UIViewController {
    //MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    //MARK: - Properties
    var data: [PandaJSON]?
    private var matchsArray: [Matchs] = []
    private let gamesCellIdentifier = "GamesCell"
    private var selectedGame = "\(UserDefaults.standard.object(forKey: "favoriteGames") ?? "lol")"
    private var games: [GamesObject] = []
    private var rankingData = [RankingData]()
    private let db = Firestore.firestore()
    private var documentData: [[String : Any]] = [[:]]
    private var dataFromDB: URLFromDB?
    private var leaguesFromDB: [URLFromDB]?
    private var resultUrl: GamesObject?
    private var urlStanding = ""
    private var urlUpcoming = ""
    private var gamesList: [String] = []
    private var urls: [String] = []
    private var gamesObject: [GamesResultObject]?
    private var matchURL = ""
    private var embedURL = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Set dark mode
        overrideUserInterfaceStyle = .dark
        //Delegate
        tableView.dataSource = self
        tableView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        //Set up XIB
        tableView.register(UINib.init(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        collectionView.register(UINib.init(nibName: "GamesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gamesCellIdentifier)


        collectionView.reloadData()
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getGamesList()
        getGamesResultURL()

    }
    //MARK: Send data to MatchDetailVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PassMatchData" {
            let sucessVC = segue.destination as? MatchDetailViewController
            sucessVC?.matchID = matchURL
            sucessVC?.embedURL = embedURL
        }
    }

    //MARK: Format date to Day Month & hours
    func showDate(dateFormJSON: String, label: UILabel) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "d MMM, h:mm"
        guard let dates = dateFormatterGet.date(from: dateFormJSON) else { return }
        label.text = dateFormatterPrint.string(from: dates)

    }

    //MARK: Fetch Game
    /// Get game List & game name
    func getGamesList() {
        
        self.gamesList = [String]()
        Service.shared.fetchGameFromDB { data in

            
            for i in 1...data.count {
                
                self.games.append(data[i-1])
                self.gamesList.append(data[i-1].name)

            }
           // DispatchQueue.main.async {
            self.createGameArray()
            self.collectionView.reloadData()
           // }
        }
    }
    //MARK: get Leagues API Url from Firestore
    func getGamesResultURL(){
        self.urls = [String]()
        Service.shared.fetchLeaguesURLFromDB(document: selectedGame) { data in
            self.urls.append(data.urlStanding)
            self.urls.append(data.urlUpcoming)

            self.fetchMatch()
            //DispatchQueue.main.async {
            self.tableView.reloadData()
            //}
        }
    }
    //MARK: - Fetch Running Matchs
    func fecthRunningMatch() {
        NetworkCall.shared.method = .get
        NetworkCall.shared.headers = [:]
        NetworkCall.shared.url = urls[0]
        NetworkCall.shared.executeQuery(){
            (result: Result<[PandaJSON],Error>) in
            switch result{
            case .success(let post):
                self.data = post
                self.matchsArray.append(Matchs(type: "Matchs en cours", pandaJSON: post))
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    //MARK: Fetch upcoming matchs
    func fecthUpcomingMatch() {
        NetworkCall.shared.method = .get
        NetworkCall.shared.headers = [:]
        NetworkCall.shared.url = urls[1]
        NetworkCall.shared.executeQuery(){
            (result: Result<[PandaJSON],Error>) in
            switch result{
            case .success(let post):
                self.data = post
                self.matchsArray.append(Matchs(type: "Match a venir", pandaJSON: post))
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            case .failure(let error):
                print(error)
            }
        }
    }
    //MARK: Fetch Match
 private func fetchMatch() {
        self.matchsArray = []
        fecthRunningMatch()
        fecthUpcomingMatch()
    }
    //MARK: Set on 1rst position of collection user's favorite game
   private func createGameArray() {
        
        for i in 1..<games.count {
            if selectedGame == games[i-1].name {
                games.remove(at: i-1)
            }
        }
       //games.insert(UserDefaults.standard.object(forKey: "favoriteGames"), at: 0)
        collectionView.reloadData()
    }
    
}



extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return matchsArray[section].pandaJSON.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        
        matchsArray.count
    }
    // Set up Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell
        
        if matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents.count > 1  {
            cell.t1Label.text = matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents[0].opponent.name ?? "Pas encore connu"
            cell.t2Label.text = matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents[1].opponent.name ?? "Pas encore connu"
            cell.visitorImage.sd_setImage(with: URL(string: matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents[0].opponent.image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.homeImage.sd_setImage(with: URL(string: matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents[1].opponent.image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.leagueImage.sd_setImage(with: URL(string: matchsArray[indexPath.section].pandaJSON[indexPath.row].league.image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.leagueLabel.text = matchsArray[indexPath.section].pandaJSON[indexPath.row].league.name
            showDate(dateFormJSON: matchsArray[indexPath.section].pandaJSON[indexPath.row].original_scheduled_at ?? "", label: cell.dateLabel)
            cell.animationView.isHidden = true
            
        } 
        if matchsArray[indexPath.section].type == "Matchs en cours" {
            cell.animationView.isHidden = false
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 127
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if matchsArray[indexPath.section].type == "Matchs en cours" {


        if !matchsArray[indexPath.section].pandaJSON[indexPath.row].games.isEmpty {
            guard let matchurl =  matchsArray[indexPath.section].pandaJSON[indexPath.row].games[indexPath.row].match_id else {return}
            matchURL = "\(matchurl)"
            //"\(String(describing: matchsArray[indexPath.section].pandaJSON[indexPath.row].games[indexPath.row].match_id!))"
            embedURL = matchsArray[indexPath.section].pandaJSON[indexPath.row].live_embed_url ?? ""
        }
        // Send data to other VC
        performSegue(withIdentifier: "PassMatchData", sender: self)
        } else {
            presentAlert(withTitle: "Match pas commencé", message: "Vous devez attendre que le match demarre.")
        }
    }
    // Set up UI between sections
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        //view.backgroundColor =  UIColor(red: 1, green: 0.3653766513, blue: 0.1507387459, alpha: 1)
        
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 10))
        lbl.font = UIFont.systemFont(ofSize: 10)
        lbl.text = matchsArray[section].type
        view.addSubview(lbl)
        return view
    }
    
}

extension ResultViewController: UICollectionViewDataSource  {
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: gamesCellIdentifier, for: indexPath) as! GamesCollectionViewCell
        // gameCell.Label.text = games[indexPath.row]
        cell.gameImage.image = UIImage(named: "\(gamesList[indexPath.row])")
        return  cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gamesList.count
        
    }
    
    
}
extension ResultViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Distance Between Item Cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    // Cell Margin
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .right)
        selectedGame = gamesList[indexPath.row]
        getGamesResultURL()
        
    }
}
