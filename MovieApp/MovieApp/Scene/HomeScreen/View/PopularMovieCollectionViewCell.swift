//
//  PopularMovieCollectionViewCell.swift
//  MovieApp
//
//  Created by Selman ADANİR on 16.01.2023.
//

import UIKit
import AlamofireImage

class PopularMovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(image: MovieModel) {
        guard let url = URL(string: Client.IMAGE_BASE_URL + image.poster) else { return }
        moviePosterImageView.af.setImage(withURL: url)
    }

}
