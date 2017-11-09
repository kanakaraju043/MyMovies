//
//  MovieDetailViewController.swift
//  MyMovies
//
//  Created by KANAKARAJU GANDREDDI on 11/8/17.
//  Copyright © 2017 RelianceJio. All rights reserved.
//

import UIKit
import Kingfisher
let imageURLPrefixMedium = "https://image.tmdb.org/t/p/w500"

class MovieDetailViewController: UIViewController {
   
     @IBOutlet weak var originalTitleLabel : UILabel!
    @IBOutlet weak var synopsisLabel : UILabel!
    @IBOutlet weak var ratingLabel : UILabel!
    @IBOutlet weak var releaseDateLabel : UILabel!
    @IBOutlet weak var posterImageView : UIImageView!
    
    var movieData: MovieManager?

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let thedata = movieData {
            
            navigationItem.title = thedata.title
            originalTitleLabel.text = thedata.originalTitle
            
            let urlRequest = "\(imageURLPrefixMedium)\(thedata.posterPath)"
            
            let url:URL = URL.init(string: urlRequest)!
            let r = ImageResource(downloadURL: url, cacheKey: nil)
            
            posterImageView.kf.setImage(with: r, placeholder: nil)
            
            posterImageView.kf.setImage(with: r)
            
            synopsisLabel.text = thedata.overView
            ratingLabel.text = "\(thedata.voteAverage)"
            releaseDateLabel.text = thedata.releaseDate
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
