//
//  DetailViewModel.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import Foundation

protocol CastViewModelInput {
    var output: CastViewModelOutput? { get set }
    var selectedMovie: DetailData? { get set }
    
    func viewDidLoad()
    func retrieveCastList(for movie: DetailData)
}

protocol CastViewModelOutput: AnyObject {
    func home(_home viewModel: CastViewModelInput, castListDidLoad list: [MovieCastResult])
}

final class CastViewModel: CastViewModelInput {
 
    var castList: [MovieCastResult] = []
    private let castAPI: CastFetchable
    var selectedMovie: DetailData?
    var output: CastViewModelOutput?
    
    init(castAPI: CastAPI,selectedMovie: DetailData) {
        self.castAPI = castAPI
        self.selectedMovie = selectedMovie
    }
    
    func viewDidLoad() {
        retrieveCastList(for: selectedMovie!)
    }
    
    func retrieveCastList(for movie: DetailData) {
        LoadingManager.shared.show()
        castAPI.retrieveCast(request: CastRequestModel(moviePath: Constant.MOVIECAST.credits, movieID: movie.id)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let castList):
                self.castList.append(contentsOf: castList.cast)
                self.output?.home(_home: self, castListDidLoad: castList.cast)
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    
}
