//
//  MovieViewController.swift
//  MoviesApp
//
//  Created by Doston Rustamov on 05/03/22.
//

import Foundation
import SnapKit

class MovieViewController: ParentViewController {

    var id: Int = 0
    var movieViewModel: MovieViewModel!
    
    var castCollectionView: UICollectionView!
    static var shared = MovieViewController()
    
    var movieDescription = UITextView()
    var movieTitle = UILabel()
    var budget = UILabel()
    var date = UILabel()
    var rating = UILabel()
    var castTitle = UILabel()
    
    override func viewDidLoad() {
        MovieViewController.shared = self
        
        movieViewModel = MovieViewModel(id: id)
        super.viewDidLoad()
    }
    
    override func setupViewComponents() {
        
        
        movieTitle.text = "Unknown"
        movieTitle.font = .systemFont(ofSize: 20, weight: .bold)
        movieTitle.textAlignment = .center
        movieTitle.numberOfLines = 2
        
        view.addSubview(movieTitle)
        movieTitle.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        
        movieDescription.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ullamcorper arcu quis semper tincidunt. Vivamus id commodo purus. Aliquam erat volutpat. Integer tincidunt, ante a tristique tincidunt, metus diam sagittis mi, at convallis augue mauris ut sem."
        movieDescription.textAlignment = .justified
        movieDescription.font = .systemFont(ofSize: 14, weight: .regular)
        movieDescription.isEditable = false
        
        view.addSubview(movieDescription)
        movieDescription.snp.makeConstraints {
            $0.top.equalTo(movieTitle.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(5)
            $0.right.equalToSuperview().offset(-5)
            $0.height.lessThanOrEqualTo(200)
        }
        
        
        budget.text = "Budget: $10000000"
        budget.font = .systemFont(ofSize: 16, weight: .semibold)
        
        view.addSubview(budget)
        budget.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalTo(movieDescription.snp.bottom).offset(10)
        }
        
        
        rating.text = "Rating: 9.0☆"
        rating.font = .systemFont(ofSize: 16, weight: .semibold)
        
        view.addSubview(rating)
        rating.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalTo(budget.snp.bottom).offset(5)
        }
        
        
        date.text = "Release date: 5 March 2022"
        date.font = .systemFont(ofSize: 16, weight: .semibold)
        
        view.addSubview(date)
        date.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.top.equalTo(rating.snp.bottom).offset(5)
        }
        
       
        castTitle.text = "Cast"
        castTitle.font = .systemFont(ofSize: 20, weight: .bold)
        castTitle.textAlignment = .center
        
        view.addSubview(castTitle)
        castTitle.snp.makeConstraints {
            $0.centerY.equalTo(date.snp.bottom).offset(40)
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
        }
        
        let castCollectionLayout = UICollectionViewFlowLayout()
        castCollectionLayout.scrollDirection = .horizontal
        
        castCollectionView = UICollectionView(frame: .zero, collectionViewLayout: castCollectionLayout)
        
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.showsHorizontalScrollIndicator = false
        castCollectionView.register(ActorCollectionViewCell.self, forCellWithReuseIdentifier: ActorCollectionViewCell.cell)
        
        view.addSubview(castCollectionView)
        castCollectionView.snp.makeConstraints {
            $0.top.equalTo(castTitle.snp.bottom).offset(10)
            $0.width.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        movieViewModel.loadingDelegate = self
        loadingIcon.startAnimating()
    
        view.addSubview(loadingIcon)
        loadingIcon.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension MovieViewController: MovieViewModelDelegate {
    
    /** Refreshing all ui elements after  downloading movie and actor details from api*/
    func refreshView() {
        castCollectionView.reloadData()
        movieTitle.text = movieViewModel.selectedMovie?.title
        movieDescription.text = movieViewModel.selectedMovie?.description
        budget.text = "Budget: $\(movieViewModel.selectedMovie?.budget ?? 0)"
        rating.text = "Rating: \(movieViewModel.selectedMovie?.rating ?? 0)☆"
        date.text = "Release date : " + (DateFormatter.getFormated(
            date: (movieViewModel.selectedMovie?.date ?? "0"),
            with: "MMM dd, yyyy"
        ) ?? "unknown")
    }
    
    /** Dowloading all image to not freeze UI in future cases*/
    func downloadAllImages() {
        for movieActor in movieViewModel.castList.cast {
            DispatchQueue.global(qos: .userInitiated).async {
                if let image = movieActor.picture {
                    self.movieViewModel.getImage(from: image) { _ in }
                }
            }
        }
    }
}

extension MovieViewController : UICollectionViewDataSource {
    
    /** Number of cell items in this table*/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieViewModel.castList.cast.count
    }
    
    /** Initializing and shown cell data and ui in the tableView*/
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActorCollectionViewCell.cell, for: indexPath) as! ActorCollectionViewCell
        cell.setupWithAttributes(with: movieViewModel.castList.cast[indexPath.row].name)

        
        if let pictureUrl = movieViewModel.castList.cast[indexPath.row].picture {
            movieViewModel.getImage(from: pictureUrl) { (image) in
                cell.pictureView.image = image
            }
        } else {
            cell.pictureView.image = UIImage(named: "default-image")
        }
        
        return cell
    }

    /** Initializing and presenting actorViewController, which
     will show actor info details and his movies */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actorController = ActorViewController()
        actorController.id = movieViewModel.castList.cast[indexPath.row].id
        present(actorController, animated: true, completion: nil)
    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout {
    
    /** Used to set size of the cell of this table*/
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 180)
    }
}

extension MovieViewController: UICollectionViewDelegate { }
