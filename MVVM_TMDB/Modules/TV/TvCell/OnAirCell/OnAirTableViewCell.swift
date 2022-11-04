//
//  OnAirTableViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class OnAirTableViewCell: UITableViewCell {

    @IBOutlet weak private var collectionView: UICollectionView!
    private var onAirList: [OnAirResultTV] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerOnAirCell()
    }
    private func registerOnAirCell() {
        let cellIdentifier = String(describing: OnAirCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [OnAirResultTV]) {
        self.onAirList = model
        collectionView.reloadData()
    }
    
}
extension OnAirTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onAirList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnAirCollectionViewCell", for: indexPath) as? OnAirCollectionViewCell {
            cell.setUpComing(from: onAirList[indexPath.row])
            cell.configureCell(from: cell)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let castApi = CastTvAPI(networkMAnager: networkManager)
        let detailData = DetailData(image: onAirList[indexPath.row].backdropPath!, content: onAirList[indexPath.row].overview, date: onAirList[indexPath.row].firstAirDate, title: onAirList[indexPath.row].name, id: onAirList[indexPath.row].id)
        //let detailViewModel = CastViewModel(castAPI: castApi, selectedMovie: detailData)
        //let vc = DetailsViewController(selectedMovie: detailData, viewModel: detailViewModel)
        //UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
}
