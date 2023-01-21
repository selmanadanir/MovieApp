//
//  GetPopularMoviesResponseModel.swift
//  MovieApp
//
//  Created by Selman ADANİR on 14.01.2023.
//

import Foundation

struct GetPopularMoviesResponseModel: Decodable {
    let results: [MovieModel]
}
