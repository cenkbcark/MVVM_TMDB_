//
//  PopularTableViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class PopularTableViewCell: UITableViewCell {
    
    private var popularList: [PopularResultMovie] = []
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerPopularCell()
    }
    private func registerPopularCell() {
        let cellIdentifier = String(describing: PopularCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [PopularResultMovie]) {
        self.popularList = model
        collectionView.reloadData()
    }
    
}
extension PopularTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as? PopularCollectionViewCell {
            cell.setPopular(with: popularList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let castApi = CastAPI(networkManager: networkManager)
        let detailData = DetailData(image: popularList[indexPath.row].backdropPath, content: popularList[indexPath.row].overview, date: popularList[indexPath.row].releaseDate, title: popularList[indexPath.row].title, id: popularList[indexPath.row].id)
        let detailViewModel = CastViewModel(castAPI: castApi, selectedMovie: detailData)
        let vc = DetailsViewController(selectedMovie: detailData, viewModel: detailViewModel)
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
