//
//  PopularTvTableViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class PopularTvTableViewCell: UITableViewCell {

    private var popularList: [PopularResultTV] = []
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerPopularCell()
    }
    private func registerPopularCell() {
        let cellIdentifier = String(describing: PopularTvCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [PopularResultTV]) {
        self.popularList = model
        collectionView.reloadData()
    }
    
}
extension PopularTvTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularTvCollectionViewCell", for: indexPath) as? PopularTvCollectionViewCell {
            cell.setPopular(with: popularList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
