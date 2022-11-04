//
//  MovieViewModel.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import Foundation

protocol MovieViewModelInput {
    var output: MovieViewModelOutput? { get set }
    
    func viewDidLoad()
    func retrievePopularMovieList()
    func retrieveUpComingMovieList()
    func retrieveTopRatedMovieList()
}

protocol MovieViewModelOutput: AnyObject {
    func home(_home viewModel: MovieViewModelInput, popularMovieListDidLoad list: [PopularResultMovie])
    func upComing(_ upComingViewModel: MovieViewModelInput, upComingMovieListDidLoad list: [UpComingResultMovie])
    func topRated(_ topRatedViewModel: MovieViewModelInput, topRatedMovieListDidLoad list: [TopRatedResultMovie])
}

final class MovieViewModel: MovieViewModelInput {
    
    var popularMovieList: [PopularResultMovie] = []
    var upComingMovieList: [UpComingResultMovie] = []
    var topRatedMovieList: [TopRatedResultMovie] = []
    
    private let movieAPI: MovieFetchable
    var output: MovieViewModelOutput?
    
    init(movieAPI: MovieAPI) {
        self.movieAPI = movieAPI
    }
    
    func viewDidLoad() {
        retrieveUpComingMovieList()
    }
    
    func retrievePopularMovieList() {
        LoadingManager.shared.show()
        movieAPI.retrievePopularMovie(request: MovieRequestModel(page: 1, moviePath: Constant.MOVIEAPI.popular)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let popularList):
                self.popularMovieList.append(contentsOf: popularList.results)
                self.output?.home(_home: self, popularMovieListDidLoad: popularList.results)
                self.retrieveTopRatedMovieList()
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    func retrieveUpComingMovieList() {
        LoadingManager.shared.show()
        movieAPI.retrieveUpComingMovie(request: MovieRequestModel(page: 1, moviePath: Constant.MOVIEAPI.upcoming)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let upComingList):
                self.upComingMovieList.append(contentsOf: upComingList.results)
                self.output?.upComing(self, upComingMovieListDidLoad: upComingList.results)
                self.retrievePopularMovieList()
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    func retrieveTopRatedMovieList() {
        LoadingManager.shared.show()
        movieAPI.retrieveTopRatedMovie(request: MovieRequestModel(page: 1, moviePath: Constant.MOVIEAPI.topRated)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let topRatedList):
                self.topRatedMovieList.append(contentsOf: topRatedList.results)
                self.output?.topRated(self, topRatedMovieListDidLoad: topRatedList.results)
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
}
