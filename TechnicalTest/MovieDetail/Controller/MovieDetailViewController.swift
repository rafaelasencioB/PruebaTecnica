//
//  MovieDetailViewController.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 2/12/21.
//

import UIKit

class MovieDetailViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var ivMovieDetail: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbReleased: UILabel!
    @IBOutlet weak var lbRuntime: UILabel!
    @IBOutlet weak var lbGenre: UILabel!
    @IBOutlet weak var lbPlot: UILabel!
    @IBOutlet weak var lbWebsite: UILabel!
    
    //MARK: Properties
    private var movie: MovieDetail?
    
    //MARK: Init
    convenience init(movie: MovieDetail) {
        self.init()
        self.movie = movie
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTapGesture()
    }
    
    //MARK: Helpers
    private func configureUI() {
        if let url = movie?.urlImage {
            ivMovieDetail.setImage(from: url)
        }
        lbTitle.text = movie?.Title
        lbYear.text = movie?.Year
        lbReleased.text = movie?.Released
        lbRuntime.text = movie?.Runtime
        lbGenre.text = movie?.Genre
        lbPlot.text = movie?.Plot
        lbWebsite.text = "Website"
        lbWebsite.textColor = .systemBlue
    }
    
    private func configureTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        lbWebsite.isUserInteractionEnabled = true
        lbWebsite.addGestureRecognizer(gesture)
    }
    
    @objc private func handleTap() {
        
        var item = [Any]()
        
        if let urlWebsite = movie?.urlWebsite, UIApplication.shared.canOpenURL(urlWebsite) {
            item.append(urlWebsite)
        } else if let urlImage = movie?.urlImage {
            item.append(urlImage)
        } else {
            return
        }
        
        let activity = UIActivityViewController(activityItems: item, applicationActivities: nil)
        activity.popoverPresentationController?.sourceView = self.view
        self.present(activity, animated: true)
    }
}
