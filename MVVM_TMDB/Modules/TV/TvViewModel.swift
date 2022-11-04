//
//  TvViewModel.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import Foundation

protocol TvViewModelInput {
    var output: TvViewModelOutput? { get set }
    
    func viewDidLoad()
    func retrievePopularTvList()
    func retrieveOnAirTvList()
    func retrieveTopRatedList()
}

protocol TvViewModelOutput: AnyObject {
    func popularTv(_home viewModel: TvViewModelInput, popularTvListDidLoad list: [PopularResultTV])
    func onAirTv(_home viewModel: TvViewModelInput, onAirTvListDidLoad list: [OnAirResultTV])
    func topRatedTv(_home viewModel: TvViewModelInput, topRatedTvListDidLoad list: [TopRatedResultTV])
}

final class TvViewModel: TvViewModelInput {
    
    var popularTvList: [PopularResultTV] = []
    var onAirTvList: [OnAirResultTV] = []
    var topRatedTvList: [TopRatedResultTV] = []
    
    private let tvAPI: TvFetchable
    var output: TvViewModelOutput?
    
    init(tvAPI: TvAPI){
        self.tvAPI = tvAPI
    }
    
    func viewDidLoad() {
        retrieveOnAirTvList()
    }
    
    func retrievePopularTvList() {
        LoadingManager.shared.show()
        tvAPI.retrievePopularTV(request: TVRequestModel(page: 1, tvPath: Constant.TVAPI.popular)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let popularList):
                self.popularTvList.append(contentsOf: popularList.results)
                self.output?.popularTv(_home: self, popularTvListDidLoad: popularList.results)
                self.retrieveTopRatedList()
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    
    func retrieveOnAirTvList() {
        LoadingManager.shared.show()
        tvAPI.retrieveOnAir(request: TVRequestModel(page: 1, tvPath: Constant.TVAPI.onTheAir)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let onAirList):
                self.onAirTvList.append(contentsOf: onAirList.results)
                self.output?.onAirTv(_home: self, onAirTvListDidLoad: onAirList.results)
                self.retrievePopularTvList()
            case .failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
    
    func retrieveTopRatedList() {
        LoadingManager.shared.show()
        tvAPI.retrieveTopRatedTV(request: TVRequestModel(page: 1, tvPath: Constant.TVAPI.topRated)) { [weak self] result in
            LoadingManager.shared.hide()
            guard let self = self else { return }
            switch result {
            case .success(let topRatedList):
                self.topRatedTvList.append(contentsOf: topRatedList.results)
                self.output?.topRatedTv(_home: self, topRatedTvListDidLoad: topRatedList.results)
            case . failure(let error):
                AlertManager.shared.showAlert(with: error)
            }
        }
    }
}
