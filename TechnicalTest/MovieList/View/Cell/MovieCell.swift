//
//  MovieCell.swift
//  TechnicalTest
//
//  Created by Rafael Asencio on 2/12/21.
//

import UIKit

class MovieCell: UITableViewCell {

    //MARK: @IBOutlets
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    
    //MARK: Init
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ivMovie.contentMode = .scaleToFill
        ivMovie.layer.cornerRadius = 60 / 2
        ivMovie.layer.masksToBounds = true
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        ivMovie.image = nil
        lbTitle.text?.removeAll()
        lbYear.text?.removeAll()
    }
    
    //MARK: Helpers
    func configure(movie: Movie) {
        if let url = movie.urlImage {
            ivMovie.setImage(from: url)
        }
        self.lbTitle.text = movie.Title
        self.lbYear.text = movie.Year
    }
}
