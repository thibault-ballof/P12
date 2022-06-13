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
    var selectedGames: [String] = []
    
    @IBOutlet var gamebuttons: [UIButton]!
    
    
    @IBAction func addingGameToFavorite(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            if selectedGames.contains("r6-siege") == false {
                selectedGames.append("r6-siege")
            }
            
        case 2:
            if selectedGames.contains("dota-2") == false {
                selectedGames.append("dota-2")
            }
           
        case 3:
            if selectedGames.contains("league-of-legends") == false {
                selectedGames.append("league-of-legends")
            }
            
        default:
            break
        }
        print(selectedGames)
    }
    
    @IBAction func button(_ sender: Any) {
        
        UserDefaults.standard.set(selectedGames, forKey: "favoriteGames")
        self.performSegue(withIdentifier: "segueIdentifier", sender: self)
        
        UserDefaults.standard.set(true, forKey: "alreadyLaunched")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func appendFavoriteGames() {
        let selectedGames: Games = .lol

        switch selectedGames {
        case .lol:
            print("")
        case .csgo:
            print("")
        case .ow:
            print("")
        }
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
