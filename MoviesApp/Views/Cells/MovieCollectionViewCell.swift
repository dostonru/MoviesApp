//  ActorCellView.swift
//  MoviesApp
//  Created by Doston Rustamov on 05/03/22.

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let cell = "movieCell"
    var pictureView = UIImageView()
    var name = UILabel()
    
    
    func setupWithAttributes(with movieName: String?) {
        
        name.text = movieName
        name.textAlignment = .center
        name.font = .systemFont(ofSize: 13, weight: .semibold)
        
        pictureView.contentMode = .scaleAspectFit
        
        contentView.addSubview(pictureView)
        pictureView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(150)
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(name)
        name.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(pictureView.snp.bottom).offset(2)
        }
    }
}
