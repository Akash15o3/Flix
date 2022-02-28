//
//  ViewController.swift
//  Flixter
//
//  Created by Akash Aggarwal on 2/27/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var moviesTableView: UITableView!
    private var movies = [Movies](){
        didSet{
            moviesTableView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        MoviesService.shared.fetchMovies { movies in
            self.movies = movies
        }
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
        
        cell.configure(with: movies[indexPath.row])
        return cell
    }

}

