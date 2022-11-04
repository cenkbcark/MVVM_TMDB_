//
//  CastCell.swift
//  MVVM_TMDB
//
//  Created by Cenk Bahadır Çark on 17.10.2022.
//

import UIKit

final class CastCell: UICollectionViewCell {
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak var castCharacter: UILabel!
    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var castType: UILabel!
    
    func setCast(from cast: MovieCastResult){
        guard let image = cast.profilePath else {
            return imageView.image = UIImage(named: "questionmark")
        }
        imageView.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/original\(image)")!)
        castType.text = cast.knownForDepartment
        castCharacter.text = cast.character
        castName.text = cast.originalName
        
    }
    func configureCell(from cell: CastCell){
            cell.layer.cornerRadius = 15.0
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = UIColor.white.cgColor
    }
}
