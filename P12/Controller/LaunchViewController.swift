//
//  LaunchViewController.swift
//  P12
//
//  Created by Thibault Ballof on 22/08/2022.
//

import UIKit
import Lottie

class LaunchViewController: UIViewController {
    var window: UIWindow?
    
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.0
        animationView.play { (finished) in
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
            self.present(vc, animated: true)
        }

    }
    
}
