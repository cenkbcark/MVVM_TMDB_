//
//  ViewController.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 15.10.2022.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkManager = NetworkManager(session: .shared)
        //MARK: - MOVIE
        let movieApi = MovieAPI(networkManager: networkManager)
        let movieViewModel = MovieViewModel(movieAPI: movieApi)
        let movieViewController = MovieViewController(viewModel: movieViewModel)
        //MARK: - TV
        let tvApi = TvAPI(networkManager: networkManager)
        let tvViewModel = TvViewModel(tvAPI: tvApi)
        let tvViewController = TvViewController(viewModel: tvViewModel)
        //MARK: - DOWNLOADS
        let downloadViewController = DownloadViewController()
        //MARK: - SET TITLES
        movieViewController.title = "Movie"
        tvViewController.title = "Tv's"
        downloadViewController.title = "Downloads"
        self.setViewControllers([movieViewController,tvViewController,downloadViewController], animated: true)
        guard let items = self.tabBar.items else { return }
        let images = ["tv.and.mediabox","play.tv.fill","square.and.arrow.down.fill"]
        for x in 0...2 {
            items[x].image = UIImage(systemName: images[x])
        }
        self.tabBar.tintColor = .red
        self.tabBar.barTintColor = .black
    }
}


