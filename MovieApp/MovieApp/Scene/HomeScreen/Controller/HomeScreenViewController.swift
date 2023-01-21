//
//  ViewController.swift
//  MovieApp
//
//  Created by Selman ADANİR on 14.01.2023.
//

import UIKit

class HomeScreenViewController: UIViewController {

    @IBOutlet private weak var popularMoviesListCollectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            popularMoviesListCollectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    @IBOutlet private weak var otherMoviesCollectionView: UICollectionView! {
        didSet {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            otherMoviesCollectionView.setCollectionViewLayout(layout, animated: true)
        }
    }
    @IBOutlet private weak var moviesSegmentedController: UISegmentedControl!
    
    private var popularMoviesViewModel: HomeScreenViewModelProtocol = HomeScreenViewModel()
    private var otherMoviesViewModel: HomeScreenViewModelProtocol = HomeScreenViewModel()
    var movies: Movies?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popularMoviesViewModel.delegate = self
        popularMoviesViewModel.fetchMovies(input: .popular)
        
        otherMoviesViewModel.delegate = self
        moviesSegmentedController.addTarget(self, action: #selector(handleSegmentChange), for: .valueChanged)
    }
    
    @objc private func handleSegmentChange() {
        switch moviesSegmentedController.selectedSegmentIndex {
        case 0:
            otherMoviesViewModel.fetchMovies(input: .nowPlaying)
            movies = .nowPlaying
        case 1:
            otherMoviesViewModel.fetchMovies(input: .upcoming)
            movies = .upcoming
        case 2:
            otherMoviesViewModel.fetchMovies(input: .topRated)
            movies = .topRated
            
        default:
            otherMoviesViewModel.fetchMovies(input: .nowPlaying)
            movies = .nowPlaying
        }
    }
}

extension HomeScreenViewController: HomeScreenViewModelDelegate {
    
    func moviesLoaded() {
        popularMoviesListCollectionView.reloadData()
        popularMoviesListCollectionView.register(UINib(nibName: "PopularMovieCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "PopularMovieCollectionViewCell")
        
        otherMoviesCollectionView.reloadData()
        otherMoviesCollectionView.register(UINib(nibName: "OtherMoviesCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "OtherMoviesCollectionViewCell")
        //let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
        //layout.minimumInteritemSpacing = 20
        //layout.minimumLineSpacing = 5
        //popularMoviesListCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.popularMoviesListCollectionView {
            return popularMoviesViewModel.getMovieCount(input: movies ?? .popular) }
        
        else if collectionView == self.otherMoviesCollectionView {
            return otherMoviesViewModel.getMovieCount(input: movies ?? .nowPlaying)
        }
        
        else { return 0 }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.popularMoviesListCollectionView {
            
            guard let cell = popularMoviesListCollectionView.dequeueReusableCell(withReuseIdentifier: "PopularMovieCollectionViewCell", for: indexPath) as? PopularMovieCollectionViewCell,
                  let model = popularMoviesViewModel.getMovie(at: indexPath.row, input: movies ?? .popular)
            else { return UICollectionViewCell() }
            cell.configureCell(image: model)
            return cell
        }
        
        else {
            guard let cell = otherMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: "OtherMoviesCollectionViewCell", for: indexPath) as? OtherMoviesCollectionViewCell,
                  let model = otherMoviesViewModel.getMovie(at: indexPath.row, input: movies ?? .nowPlaying)
            else { return UICollectionViewCell() }
            cell.configureCell(image: model)
            return cell
        }
    }
}

extension HomeScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == self.popularMoviesListCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        else {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.popularMoviesListCollectionView {
            
            let gridLayout = collectionViewLayout as? UICollectionViewFlowLayout
            let withPerItem = (collectionView.frame.width / 2) - 20 - (gridLayout?.minimumInteritemSpacing ?? CGFloat())
            return CGSize(width: withPerItem, height: 300)
        }
        
        else {
            let gridLayout = collectionViewLayout as? UICollectionViewFlowLayout
            let withPerItem = collectionView.frame.width / 3 - (gridLayout?.minimumInteritemSpacing ?? CGFloat())
            return CGSize(width: withPerItem, height: 165)
        }
        
    }
    
}
