//  UpcomingViewController.swift
//  MoviesApp
//  Created by Doston Rustamov on 05/03/22.

import UIKit
import SnapKit

class UpcomingViewController: ParentViewController {

    var moviesTableView  : UITableView!
    var upcomingViewModel : UpcomingViewModel!
    
    static var shared = UpcomingViewController()
    
    override func viewDidLoad() {
        
        /** Creating singleton class and assign it to itseld to update
         tableview when data from api comes*/
        UpcomingViewController.shared = self
        
        super.viewDidLoad()
        upcomingViewModel = UpcomingViewModel()
        
    }
    
    /** Placing tableview into the scene*/
    override func setupViewComponents() {
        
        moviesTableView = UITableView()
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
        moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.cell)
        view.addSubview(moviesTableView)
        moviesTableView.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    /** Downloading all images asyncronously, because if we will
     load them during cell initialization we will get memory lack*/
    func downloadAllImages() {
        for image in upcomingViewModel.movies {
            DispatchQueue.global(qos: .userInitiated).async {
                self.upcomingViewModel.getImage(from: image.image!) { _ in }
            }
        }
    }
}

extension UpcomingViewController: UITableViewDataSource, UITableViewDelegate {
    
    /** Setup cell ui with data from api and prepare images for reuse.*/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.cell, for: indexPath) as! MovieTableViewCell
        let movie = upcomingViewModel.movies[indexPath.row]
        
        
        cell.setupWithComponents(
            title: movie.title ?? "Unknown",
            date: "Date: \(movie.date ?? "Unknown")",
            rating: "Rating: \(movie.rating ?? 0)☆"
        )
        
        upcomingViewModel.getImage(from: movie.image!) { (image) in
            DispatchQueue.main.async {
                cell.posterView.image = image
            }
        }
                
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movieController = MovieViewController()
        movieController.id = upcomingViewModel.movies[indexPath.row].id
        present(movieController, animated: true, completion: nil)
    }
}
