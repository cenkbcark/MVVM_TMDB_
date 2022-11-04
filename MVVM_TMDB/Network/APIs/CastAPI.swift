//
//  CastAPI.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import Foundation

protocol CastFetchable {
    func retrieveCast(request: CastRequestModel, completion: @escaping (Result<MovieCastModel, ApiError>) -> Void)
}

final class CastAPI: CastFetchable {
    
    private let networkManager: Networking
     
    init(networkManager: Networking) {
        self.networkManager = networkManager
    }
    
    func retrieveCast(request: CastRequestModel, completion: @escaping (Result<MovieCastModel, ApiError>) -> Void) {
        networkManager.request(request: request, completion: completion)
    }
}
