//
//  ViewController.swift
//  Flixter
//
//  Created by Akash Aggarwal on 2/27/22.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movies = [[String:Any]]()
    @IBOutlet weak var moviesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("lola")
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                 print(dataDictionary)
                    self.movies = dataDictionary["results"] as! [[String:Any]]
                    self.moviesTableView.reloadData()
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
        // Do any additional setup after loading the view.
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"MoviesTableViewCell") as? MoviesTableViewCell
                        
                else {
                    return UITableViewCell()
                }
                
                
                let movie = movies[indexPath.row]
                let title = movie["title"] as! String
                let description = movie["overview"] as! String
                let baseUrl = "https://image.tmdb.org/t/p/w185"
                let posterPath = movie["poster_path"] as! String
                let posterURL = baseUrl+posterPath
                cell.moviesNameLabel.text = title
                cell.moviesDescriptionLabel.text = description
                cell.moviesImageLabel.af.setImage(withURL: URL(string: posterURL)!)
                return cell
            }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! MoviesTableViewCell
        let indexPath = moviesTableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        
        let detailsViewController = segue.destination as! MovieDetailsViewController
        
        detailsViewController.movie = movie
        
        moviesTableView.deselectRow(at: indexPath, animated: true)
        
        
    }

}

