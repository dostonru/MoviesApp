//  MovieCellView.swift
//  MoviesApp
//  Created by Doston Rustamov on 05/03/22.

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    
    static let cell = "moviesCell"
    
    var movieTitle = UILabel()
    var rating = UILabel()
    var date = UILabel()
    var posterView = UIImageView()
    
    func setupWithComponents(title: String, date: String, rating: String) {
        self.movieTitle.text = title
        self.rating.text = rating
        self.date.text = date
        setupView()
    }
    
    func setupView() {
        
        movieTitle.numberOfLines = 2
        movieTitle.font = .systemFont(ofSize: 14, weight: .bold)
        rating.font = .systemFont(ofSize: 14, weight: .medium)
        date.font = .systemFont(ofSize: 14, weight: .medium)
        posterView.layer.cornerRadius = 5
        posterView.contentMode = .scaleAspectFit
        
        contentView.addSubview(movieTitle)
        movieTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(10)
            $0.width.equalToSuperview().multipliedBy(0.7)
        }
        
        contentView.addSubview(rating)
        rating.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.left.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(date)
        date.snp.makeConstraints {
            $0.bottom.equalTo(rating.snp.top).offset(-5)
            $0.left.equalToSuperview().offset(10)
        }
        
        contentView.addSubview(posterView)
        posterView.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(2)
            $0.bottom.equalToSuperview().offset(-2)
            $0.width.equalToSuperview().multipliedBy(0.28)
        }
    }
    
}
