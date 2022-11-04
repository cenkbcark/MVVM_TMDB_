//
//  TopRatedTableViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class TopRatedTableViewCell: UITableViewCell {

    private var topRatedList: [TopRatedResultMovie] = []
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerPopularCell()
        
    }
    private func registerPopularCell() {
        let cellIdentifier = String(describing: TopRatedCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [TopRatedResultMovie]) {
        self.topRatedList = model
        collectionView.reloadData()
    }
}
extension TopRatedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topRatedList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedCollectionViewCell", for: indexPath) as? TopRatedCollectionViewCell {
            cell.setTopRated(with: topRatedList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let castApi = CastAPI(networkManager: networkManager)
        let detailData = DetailData(image: topRatedList[indexPath.row].backdrop_path, content: topRatedList[indexPath.row].overview, date: topRatedList[indexPath.row].release_date, title: topRatedList[indexPath.row].title, id: topRatedList[indexPath.row].id)
        let detailViewModel = CastViewModel(castAPI: castApi, selectedMovie: detailData)
        let vc = DetailsViewController(selectedMovie: detailData, viewModel: detailViewModel)
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
