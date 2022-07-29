//
//  ResultViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit
import SDWebImage
import Firebase

class ResultViewController: UIViewController {

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


    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark
        //createGameArray()
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib.init(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
       collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "GamesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gamesCellIdentifier)
        collectionView.reloadData()
        collectionView.showsHorizontalScrollIndicator = false
        //getGamesResultURL()


       /* NetworkCall(url: "https://api.pandascore.co/matches/upcoming?sort=&page=1&per_page=50&token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4", service: .posts, method: .get).executeQuery(){
                    (result: Result<[PandaJSON],Error>) in
                    switch result{
                    case .success(let post):
                        print("ICI LA REPONSE : \(post)")
                        
                    case .failure(let error):
                        print(error)
                    }
                }*/

        }
    override func viewWillAppear(_ animated: Bool) {
        getGamesList()
        getGamesResultURL()
    }

    func getGamesList() {

        self.gamesList = [String]()
        Service.shared.fetchGameFromDB { data in
            //print("Data : \(data)")

            for i in 1...data.count {

                self.games.append(data[i-1])
                self.gamesList.append(data[i-1].name)
                //self.urls.append([data[i-1].urlStanding] + [data[i-1].urlUpcoming])
                //self.urls.append()

            }
            print("URLS : \(self.urls)")
            //self.createGameArray()
            self.fetchMatch()


            self.collectionView.reloadData()
        }
    }
    func getGamesResultURL(){
        self.urls = [String]()
        Service.shared.fetchLeaguesURLFromDB(document: selectedGame) { data in
            self.urls.append(data.urlStanding)
            self.urls.append(data.urlUpcoming)
            print("URLS: \(self.urls)")
            self.fetchMatch()
            self.tableView.reloadData()
        }
    }

    func fetchMatch() {
        self.matchsArray = []

           Service.shared.fetchMatch(url: urls[0]) {  match in

                self.data = match

                self.matchsArray.append(Matchs(type: "Matchs en cours", pandaJSON: match!))

                print("Matchs data : \(self.matchsArray)")
                    self.tableView.reloadData()


        }
           Service.shared.fetchMatch(url: urls[1]) {  match in

                self.data = match

                self.matchsArray.append(Matchs(type: "Match à venir", pandaJSON: match!))

                print("Matchs data : \(self.matchsArray)")
                    self.tableView.reloadData()


        }





    }

    func createGameArray() {

        for i in 1..<games.count {
            if selectedGame as! String == games[i-1].name {
                games.remove(at: i-1)
            }
        }
        //games.insert(UserDefaults.standard.object(forKey: "favoriteGames") as! String, at: 0)
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell

        if matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents.count == 0 {
             print("pas de match")
        } else {
            cell.t1Label.text = matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents[0].opponent.name ?? "Pas encore connu"
            cell.t2Label.text = matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents[1].opponent.name ?? "Pas encore connu"
            cell.visitorImage.sd_setImage(with: URL(string: matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents[0].opponent.image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.homeImage.sd_setImage(with: URL(string: matchsArray[indexPath.section].pandaJSON[indexPath.row].opponents[1].opponent.image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
           /*cell.t1Label.text = data?[indexPath.row].opponents[0].opponent.name ?? "Pas encore connu"
            cell.t2Label.text = data?[indexPath.row].opponents[1].opponent.name ?? "Pas encore connu"
            cell.visitorImage.sd_setImage(with: URL(string: data?[indexPath.row].opponents[1].opponent.image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
            cell.homeImage.sd_setImage(with: URL(string: data?[indexPath.row].opponents[0].opponent.image_url ?? ""), placeholderImage: UIImage(named: "placeholder.png"))*/
        }


       //  data[indexPath.row].opponents[0].opponent.name

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 127
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
           view.backgroundColor =  UIColor(red: 1, green: 0.3653766513, blue: 0.1507387459, alpha: 1)

           let lbl = UILabel(frame: CGRect(x: 15, y: 0, width: view.frame.width - 15, height: 40))
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
       // gameCollectionView.deselectItem(at: indexPath as IndexPath, animated: true)

            collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: .right)
            selectedGame = gamesList[indexPath.row]
            getGamesResultURL()
        tableView.reloadData()
            //getLeaguesImageURL()
    }
}
