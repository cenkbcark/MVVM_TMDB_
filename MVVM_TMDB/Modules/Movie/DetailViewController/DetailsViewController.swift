//
//  DetailsViewController.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 17.10.2022.
//

import UIKit

final class DetailsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var selectedMovie: DetailData?
    private var castList: [MovieCastResult] = []
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleases: UILabel!
    private var viewModel: CastViewModelInput
    
    init(selectedMovie: DetailData,viewModel: CastViewModelInput) {
        self.selectedMovie = selectedMovie
        self.viewModel = viewModel
        super.init(nibName: "DetailsViewController", bundle: .main)
        self.viewModel.output = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCastCell()
        collectionView.dataSource = self
        collectionView.delegate = self
        viewModel.viewDidLoad()
        guard let selectedMovie = selectedMovie else { return }
        setSelectedMovie(selectedMovie: selectedMovie)
    }
    
    private func setSelectedMovie(selectedMovie: DetailData) {
        movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(selectedMovie.image)"))
        movieImageView.layer.cornerRadius = 10
        overviewLbl.text = selectedMovie.content
        movieTitle.text = selectedMovie.title
        movieReleases.text = "Release on: \(selectedMovie.date)"
        
    }
    
    private func registerCastCell() {
        let cellIdentifier = String(describing: CastCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }

}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as? CastCell {
            cell.setCast(from: castList[indexPath.row])
            cell.configureCell(from: cell)
            return cell
        }
        return UICollectionViewCell()
    }
}
extension DetailsViewController: CastViewModelOutput {
    func home(_home viewModel: CastViewModelInput, castListDidLoad list: [MovieCastResult]) {
        castList = list
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
struct DetailData {
    let image: String
    let content: String
    let date: String
    let title: String
    let id: Int
}

