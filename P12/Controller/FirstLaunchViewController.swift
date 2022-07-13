//
//  FirstLaunchViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit
enum Games {
    case lol, csgo, ow
}


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
        
        // Do any additional setup after loading the view.
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
