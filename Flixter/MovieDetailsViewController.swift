//
//  MovieDetailsViewController.swift
//  Flixter
//
//  Created by Akash Aggarwal on 3/4/22.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var backdropView: UIImageView!
    var movie : [String:Any]!
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        titleLabel.sizeToFit()
        synopsisLabel.sizeToFit()
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterURL = baseUrl+posterPath
        posterView.af.setImage(withURL: URL(string: posterURL)!)
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = "https://image.tmdb.org/t/p/w780" + backdropPath
        backdropView.af.setImage(withURL: URL(string: backdropURL)!)
        
        
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
