//
//  HomeTableViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak private var homeImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setHomePage(){
        homeImageView.image = UIImage(named: "dahmer")
    }
    
}
