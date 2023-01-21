//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Selman ADANİR on 14.01.2023.
//

import UIKit
import AlamofireImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var movieTitle: UILabel!
    
    func configureCell(movie: MovieModel) {
        movieTitle.text = movie.title
        guard let url = URL(string: Client.IMAGE_BASE_URL + movie.poster) else { return }
        movieImage.af.setImage(withURL: url)
    }
    
   
}
