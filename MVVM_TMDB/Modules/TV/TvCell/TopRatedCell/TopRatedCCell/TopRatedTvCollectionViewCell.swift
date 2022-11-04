//
//  TopRatedTvCollectionViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class TopRatedTvCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak private var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setTopRated(with data: TopRatedResultTV) {
        imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(data.posterPath)"))
    }

}
