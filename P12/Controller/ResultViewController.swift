//
//  ResultViewController.swift
//  P12
//
//  Created by Thibault Ballof on 06/06/2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!


    var data: [PandaJson]!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultCell")
        Service.shared.fetch(ingredient: ["String"]) { (success, match) in
           
            print(match)

        }

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


extension ResultViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as! ResultTableViewCell


           // cell.t1Label.text = "\(data![indexPath.row].opponents[0].opponent.name) - \(data![indexPath.row].opponents[1].opponent.name)"
            //Service.shared.fetchImage(url: data![indexPath.row].opponents[0].opponent.imageURL!, image: cell.homeImage)
          //  Service.shared.fetchImage(url: data![indexPath.row].opponents[1].opponent.imageURL!, image: cell.visitorImage)

       //  data[indexPath.row].opponents[0].opponent.name

        return cell
    }



}


