//
//  OnAirCollectionViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class OnAirCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var onAirImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setUpComing(from data: OnAirResultTV) {
        onAirImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(data.posterPath)"))
        onAirImageView.layer.cornerRadius = onAirImageView.frame.height / 2
    }
    func configureCell(from cell: OnAirCollectionViewCell){
        cell.layer.cornerRadius = cell.frame.height / 2
        cell.layer.borderWidth = 1.5
        cell.layer.borderColor = UIColor.red.cgColor
    }

}
