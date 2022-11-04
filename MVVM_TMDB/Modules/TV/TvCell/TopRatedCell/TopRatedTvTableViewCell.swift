//
//  TopRatedTvTableViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class TopRatedTvTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    private var topRatedList: [TopRatedResultTV] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerTopRatedCell()
    }
    private func registerTopRatedCell() {
        let cellIdentifier = String(describing: TopRatedTvCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [TopRatedResultTV]) {
        self.topRatedList = model
        collectionView.reloadData()
    }
}
extension TopRatedTvTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topRatedList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopRatedTvCollectionViewCell", for: indexPath) as? TopRatedTvCollectionViewCell {
            cell.setTopRated(with: topRatedList[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
