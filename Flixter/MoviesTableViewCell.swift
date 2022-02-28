//
//  MoviesTableViewCell.swift
//  Flixter
//
//  Created by Akash Aggarwal on 2/27/22.
//

import UIKit

import AlamofireImage

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var moviesNameLabel: UILabel!
    @IBOutlet weak var moviesDescriptionLabel: UILabel!
    @IBOutlet weak var moviesImageLabel: UIImageView!
    
    
    func configure (with movies: Movies) {
        moviesNameLabel.text = movies.name
        moviesDescriptionLabel.text = movies.description
        moviesImageLabel.af.setImage(withURL: URL(string: movies.imageURL)!)
    }

}
