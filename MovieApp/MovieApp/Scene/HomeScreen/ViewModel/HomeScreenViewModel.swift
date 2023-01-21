//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Selman ADANİR on 14.01.2023.
//

import Foundation

public enum Movies: CaseIterable {
    case popular
    case nowPlaying
    case upcoming
    case topRated
    
    var title: String {
        switch self {
        case .popular:
            return "popular"
        case .nowPlaying:
            return "nowPlaying"
        case .upcoming:
            return "upcoming"
        case .topRated:
            return "topRated"
        }
    }
}

enum SelectedCollectionView: CaseIterable {
    case popular
    case other
}

protocol HomeScreenViewModelProtocol {
    var delegate: HomeScreenViewModelDelegate? { get set }
    func fetchMovies(input: Movies)
    func getMovieCount(input: Movies) -> Int
    func getMovie(at index: Int, input: Movies) -> MovieModel?
    func getMovieId(at index: Int, input: Movies) -> Int?
}

protocol HomeScreenViewModelDelegate: AnyObject {
    func moviesLoaded(input: SelectedCollectionView)
}

final class HomeScreenViewModel: HomeScreenViewModelProtocol {
    
    weak var delegate: HomeScreenViewModelDelegate?
    private var popularMovies: [MovieModel]?
    private var nowPlayingMovies: [MovieModel]?
    private var upcomingMovies: [MovieModel]?
    private var topRatedMovies: [MovieModel]?
    
    func fetchMovies(input: Movies) {
        switch input {
        case .popular:
            Client.getPopularMovies { [weak self] movies, error in
                guard let self = self else { return }
                self.popularMovies = movies
                self.delegate?.moviesLoaded(input: SelectedCollectionView.popular)
            }
        case .nowPlaying:
            Client.getNowPlayingMovies { [weak self] movies, error in
                guard let self = self else { return }
                self.nowPlayingMovies = movies
                self.delegate?.moviesLoaded(input: SelectedCollectionView.other)
            }
        case .upcoming:
            Client.getUpcomingMovies { [weak self] movies, error in
                guard let self = self else { return }
                self.upcomingMovies = movies
                self.delegate?.moviesLoaded(input: SelectedCollectionView.other)
            }
        case .topRated:
            Client.getUpcomingMovies { [weak self] movies, error in
                guard let self = self else { return }
                self.topRatedMovies = movies
                self.delegate?.moviesLoaded(input: SelectedCollectionView.other)
            }
        }
    }
    
    func getMovieCount(input: Movies) -> Int {
        switch input {
        case .popular:
            return popularMovies?.count ?? 0
        case .nowPlaying:
            return nowPlayingMovies?.count ?? 0
        case .upcoming:
            return upcomingMovies?.count ?? 0
        case .topRated:
            return topRatedMovies?.count ?? 0
        }
    }
    
    func getMovie(at index: Int, input: Movies) -> MovieModel? {
        switch input {
        case .popular:
            return popularMovies?[index]
        case .nowPlaying:
            return nowPlayingMovies?[index]
        case .upcoming:
            return upcomingMovies?[index]
        case .topRated:
            return topRatedMovies?[index]
        }
    }
    
    func getMovieId(at index: Int, input: Movies) -> Int? {
        switch input {
        case .popular:
            return popularMovies?[index].id
        case .nowPlaying:
            return nowPlayingMovies?[index].id
        case .upcoming:
            return upcomingMovies?[index].id
        case .topRated:
            return topRatedMovies?[index].id
        }
    }
}
