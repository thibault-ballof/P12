//
//  FirstLaunchViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit


class FirstLaunchViewController: UIViewController {
    //MARK: Properties
    var selectedGames: String = ""
    var selectedLeagues: String = ""
    //MARK: OUTLETS
    @IBOutlet var gamebuttons: [UIButton]!
    
    //MARK: Set UserDefault with favorite selected games
    @IBAction func addingGameToFavorite(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            selectedGames = "csgo"
            selectedLeagues = "IEM Cologne"
            
        case 2:
            selectedGames = "ow"
            selectedLeagues = "OW League"
            
        case 3:
            selectedGames = "lol"
            selectedLeagues = "LFL"
        case 4:
            selectedGames = "r6"
            selectedLeagues = "Europeen League"
            
        default:
            break
        }
        UserDefaults.standard.set(selectedGames, forKey: "favoriteGames")
        UserDefaults.standard.set(selectedLeagues, forKey: "favoriteLeagues")
        self.performSegue(withIdentifier: "segueIdentifier", sender: self)
        UserDefaults.standard.set(true, forKey: "alreadyLaunched")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .dark  
        // Do any additional setup after loading the view.
    }
    
}
