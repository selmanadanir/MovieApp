//
//  Client.swift
//  MovieApp
//
//  Created by Selman ADANİR on 14.01.2023.
//

import Foundation
import Alamofire

final class Client {
    static let BASE_URL = "https://api.themoviedb.org/3/movie/"
    static let IMAGE_BASE_URL = "https://image.tmdb.org/t/p/original"
    static let API_KEY = "16e39ba29a1b439ae0b0eacb44faa1ee"
    
    static func getPopularMovies(completion: @escaping ([MovieModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "popular?api_key=" + API_KEY
        handleResponse(urlString: urlString, responseType: GetPopularMoviesResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    static func getNowPlayingMovies(completion: @escaping ([MovieModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "now_playing?api_key=" + API_KEY
        handleResponse(urlString: urlString, responseType: GetPopularMoviesResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    static func getUpcomingMovies(completion: @escaping ([MovieModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "upcoming?api_key=" + API_KEY
        handleResponse(urlString: urlString, responseType: GetPopularMoviesResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    static func getTopRatedMovies(completion: @escaping ([MovieModel]?, Error?) -> Void) {
        let urlString = BASE_URL + "/top_rated?api_key=" + API_KEY
        handleResponse(urlString: urlString, responseType: GetPopularMoviesResponseModel.self) { responseModel, error in
            completion(responseModel?.results, error)
        }
    }
    
    
    /*
    static func getMovieDetail(movieId: Int, completion: @escaping (MovieDetailModel?, Error?) -> Void) {
        let urlString = BASE_URL + "/movie/" + String(movieId) + "?" + "&api_key=" + API_KEY
        handleResponse(urlString: urlString, responseType: MovieDetailModel.self, completion: completion)
    }
    */
    static private func handleResponse<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
        AF.request(urlString).response { response in
            guard let data = response.value else {
                DispatchQueue.main.async {
                    completion(nil, response.error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data!)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
}
