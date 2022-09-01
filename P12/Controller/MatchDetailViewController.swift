//
//  MatchDetailViewController.swift
//  P12
//
//  Created by Thibault Ballof on 03/08/2022.
//
import WebKit
import UIKit
import Lottie


class MatchDetailViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var animationView: AnimationView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var liveImage: UIImageView!
    
    @IBOutlet weak var videoPlayer: UIView!
    @IBOutlet weak var matchTypeLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var oppoImage: UIImageView!
    @IBOutlet weak var oppoLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    //MARK: PROPERTIES
    var matchID = ""
    var embedURL = ""
    override func viewDidLoad() {
        //Live Animation
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        animationView.play()
        overrideUserInterfaceStyle = .dark
        
        super.viewDidLoad()

        //Player Video
        let webConf = WKWebViewConfiguration()
        webConf.allowsInlineMediaPlayback = true
        DispatchQueue.main.async {
            let webPlayer = WKWebView(frame: self.videoPlayer.bounds, configuration: webConf)
            self.videoPlayer.addSubview(webPlayer)
            guard let videoURL = URL(string: self.embedURL + "&parent=google.fr") else { return }
            let request = URLRequest(url: videoURL)
            webPlayer.load(request)
        }
        if embedURL == "" {
            self.videoPlayer.isHidden = true
        }
        
        setupUi()
        
      
    }
    //MARK: Make API call and set up UI
    func setupUi() {

        NetworkCall.shared.method = .get
        NetworkCall.shared.headers = [:]
        NetworkCall.shared.url = "https://api.pandascore.co/matches/" + matchID + "?token=gnHS7gmxPbbJ_uzIXUTKQDbOtqH8Z1fr509qur6EB-gvqo3Psh4"
        NetworkCall.shared.executeQuery(){
            (result: Result<PandaJSON,Error>) in
            switch result{
            case .success(let post):
                if let img = post.opponents[0].opponent.image_url {
                    self.homeImage.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "placeholder.png"))
                }
                if let img = post.opponents[1].opponent.image_url {
                    self.oppoImage.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "placeholder.png"))
                }

                if let img = post.league.image_url {
                    self.leagueImage.sd_setImage(with: URL(string: img), placeholderImage: UIImage(named: "placeholder.png"))
                }

                self.titleLabel.text = post.league.name
                self.homeLabel.text = post.opponents[0].opponent.name
                self.oppoLabel.text = post.opponents[1].opponent.name
                self.matchTypeLabel.text = "Best Of \(String(describing: post.number_of_games!))"
                self.resultLabel.text = "\(post.results[0].score!) - \(post.results[1].score!)"
            case .failure(let error):
                print(error)
            }
        }

        
    }
}
