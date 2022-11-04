//
//  UpComingTableViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class UpComingTableViewCell: UITableViewCell {
    
    private var upComingList: [UpComingResultMovie] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerUpcomingCell()
    }
    private func registerUpcomingCell() {
        let cellIdentifier = String(describing: UpComingCollectionViewCell.self)
        let nib = UINib(nibName: cellIdentifier, bundle: .main)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    func prepareCategory(with model: [UpComingResultMovie]) {
        self.upComingList = model
        collectionView.reloadData()
    }

}
extension UpComingTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upComingList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingCollectionViewCell", for: indexPath) as? UpComingCollectionViewCell {
            cell.setUpComing(from: upComingList[indexPath.row])
            cell.configureCell(from: cell)
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let networkManager = NetworkManager(session: .shared)
        let castApi = CastAPI(networkManager: networkManager)
        let detailData = DetailData(image: upComingList[indexPath.row].backdropPath, content: upComingList[indexPath.row].overview, date: upComingList[indexPath.row].releaseDate, title: upComingList[indexPath.row].title, id: upComingList[indexPath.row].id)
        let detailViewModel = CastViewModel(castAPI: castApi, selectedMovie: detailData)
        let vc = DetailsViewController(selectedMovie: detailData, viewModel: detailViewModel)
        UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) {_ in
            
            let open = UIAction(title: "Download", image: UIImage(systemName: "square.and.arrow.down.fill"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .off, handler: {_ in
                print("tiklanildi")
                DownloadList.shared.downloadList.append(self.upComingList[indexPath.row])
            })
            
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [open])
        }
        return config
    }
}
