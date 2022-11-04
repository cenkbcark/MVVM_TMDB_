//
//  MovieAPI.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import Foundation

protocol MovieFetchable {
    func retrieveUpComingMovie(request: MovieRequestModel, completion: @escaping (Result<UpcomingMovieModel, ApiError>) -> Void)
    func retrievePopularMovie(request: MovieRequestModel, completion: @escaping (Result<PopularMovieModel, ApiError>) -> Void)
    func retrieveTopRatedMovie(request: MovieRequestModel, completion: @escaping (Result<TopRatedMovieModel, ApiError>) -> Void)
}

final class MovieAPI: MovieFetchable {
    
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func retrieveUpComingMovie(request: MovieRequestModel, completion: @escaping (Result<UpcomingMovieModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
    
    func retrievePopularMovie(request: MovieRequestModel, completion: @escaping (Result<PopularMovieModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
    
    func retrieveTopRatedMovie(request: MovieRequestModel, completion: @escaping (Result<TopRatedMovieModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
