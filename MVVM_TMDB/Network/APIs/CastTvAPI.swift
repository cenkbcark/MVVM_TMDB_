//
//  CastTvAPI.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 4.11.2022.
//

import Foundation

protocol CastTvFetchable {
    func retrieveCast(request: CastTvRequestModel, completion: @escaping (Result<MovieCastModel, ApiError>) -> Void)
}

final class CastTvAPI: CastTvFetchable {
    
    private let networkMAnager: Networking
    
    init(networkMAnager: Networking) {
        self.networkMAnager = networkMAnager
    }
    
    func retrieveCast(request: CastTvRequestModel, completion: @escaping (Result<MovieCastModel, ApiError>) -> Void) {
        networkMAnager.request(request: request, completion: completion)
    }
}
