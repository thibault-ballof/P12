//
//  FirstLaunchViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit


class FirstLaunchViewController: UIViewController {
    var selectedGames: String = ""
    var selectedLeagues: String = ""
    
    @IBOutlet var gamebuttons: [UIButton]!
    
    
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
