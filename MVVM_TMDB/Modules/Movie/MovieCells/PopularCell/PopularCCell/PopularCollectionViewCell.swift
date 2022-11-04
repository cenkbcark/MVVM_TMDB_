//
//  PopularCollectionViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit
import SDWebImage

final class PopularCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setPopular(with data: PopularResultMovie) {
        imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(data.posterPath)"))
    }

}
