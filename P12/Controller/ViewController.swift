//
//  ViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit

class ViewController: UIViewController {
    let service = Service()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        service.fetchMatch(typeOfMatch: "running") { data in
            print(data?.count)
        }
       
        service.fetchMatch(typeOfMatch: "upcoming") { data in
            print(data?.count)
        }
        
        
    }
    
}
