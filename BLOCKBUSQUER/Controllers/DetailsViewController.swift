//
//  DetailsViewController.swift
//  BLOCKBUSQUER
//
//  Created by Ryan Araújo on 13/07/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var backdropImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let movie = movie else {
            return
        }

        title = movie.title
        backdropImage.image = UIImage (named: movie.backdropPath)
        titleLabel.text = movie.title
        posterImage.image = UIImage(named: movie.posterPath)
        ratingLabel.text = "Rating:\(movie.voteAverage)/10"
        overviewLabel.text = movie.overview
        
        Task {
            let posterData = await Movie.downloadImageData(withPath: movie.posterPath)
            let poster:UIImage = UIImage(data: posterData) ?? UIImage()
            
            self.posterImage.image = poster
            
            let backdropData = await Movie.downloadImageData(withPath: movie.backdropPath)
            
            let backdrop:UIImage = UIImage(data: backdropData) ?? UIImage()
            
            self.backdropImage.image = backdrop
        }
    
    }
    

}
