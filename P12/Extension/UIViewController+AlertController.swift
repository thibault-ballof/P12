//
//  Extention.swift
//  P12
//
//  Created by Thibault Ballof on 19/07/2022.
//

import Foundation
import UIKit

extension UIViewController {

  func presentAlert(withTitle title: String, message: String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

