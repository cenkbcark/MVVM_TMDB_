//
//  TvAPI.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import Foundation

protocol TvFetchable {
    
    func retrieveTopRatedTV(request: TVRequestModel, completion: @escaping (Result<TopRatedTVModel, ApiError>) -> Void)
    func retrievePopularTV(request: TVRequestModel, completion: @escaping (Result<PopularTVModel, ApiError>) -> Void)
    func retrieveOnAir(request: TVRequestModel, completion: @escaping (Result<OnAirTVModel, ApiError>) -> Void)
    
}

final class TvAPI: TvFetchable {
    
    private let networkManager: Networking
    
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func retrieveOnAir(request: TVRequestModel, completion: @escaping (Result<OnAirTVModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
    
    func retrievePopularTV(request: TVRequestModel, completion: @escaping (Result<PopularTVModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
    
    func retrieveTopRatedTV(request: TVRequestModel, completion: @escaping (Result<TopRatedTVModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
