//
//  LaunchViewController.swift
//  P12
//
//  Created by Thibault Ballof on 22/08/2022.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {
    

    //MARK: OUTLETS
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        if !InternetConnectionManager.isConnectedToNetwork(){
            presentAlert(withTitle: "No connection", message: "You must be connected to the internet to use our app")
        }
        super.viewDidLoad()
        //hide Back Button
        self.tabBarController?.navigationItem.hidesBackButton = true

        animationView.contentMode = .scaleAspectFill
        animationView.animationSpeed = 1.0
        animationView.play { (finished) in
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
            self.present(vc, animated: true)
        }

    }
    
}
