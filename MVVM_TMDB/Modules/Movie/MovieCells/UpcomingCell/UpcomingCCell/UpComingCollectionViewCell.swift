//
//  UpComingCollectionViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit
import SDWebImage

final class UpComingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpComing(from data: UpComingResultMovie) {
        imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(data.posterPath)"))
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
    func configureCell(from cell: UpComingCollectionViewCell){
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.red.cgColor
    }
    

}
