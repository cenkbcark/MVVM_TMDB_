//
//  HomPageTableViewCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 3.11.2022.
//

import UIKit

final class HomPageTableViewCell: UITableViewCell {

    @IBOutlet weak var homePageImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setHomePage(){
        homePageImage.image = UIImage(named: "deneme")
    }
    
}
