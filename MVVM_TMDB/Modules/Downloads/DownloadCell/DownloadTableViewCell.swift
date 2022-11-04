//
//  DownloadTableViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 4.11.2022.
//

import UIKit
import SDWebImage

final class DownloadTableViewCell: UITableViewCell {

    @IBOutlet weak private var movieImageView: UIImageView!
    @IBOutlet weak private var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setCell(with data: UpComingResultMovie) {
        movieImageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(data.posterPath)"))
        titleLbl.text = data.title
    }
}
