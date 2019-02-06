//
//  DetailInfoCell.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import UIKit

class DetailInfoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var gradeImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var reservationGradeLabel: UILabel!
    @IBOutlet var reservationRateLabel: UILabel!
    @IBOutlet var userRatingLabel: UILabel!
    @IBOutlet var audienceLabel: UILabel!
    @IBOutlet var synopsisLabel: UILabel!
    @IBOutlet var directorLabel: UILabel!
    @IBOutlet var actorLabel: UILabel!
    
    
    func configure(_ movieDetail: MovieDetail) {
        if let date = movieDetail.date, let duration = movieDetail.duration, let reservationGrade = movieDetail.reservationGrade, let reservationRate = movieDetail.reservationRate, let userRating = movieDetail.userRating, let audience = movieDetail.audience {
        
            titleLabel.text = movieDetail.title
            releaseDateLabel.text = date + "개봉"
            genreLabel.text = movieDetail.genre
            durationLabel.text = String(duration) + "분"
            reservationGradeLabel.text = String(reservationGrade) + "위"
            reservationRateLabel.text = String(reservationRate) + "%"
            userRatingLabel.text = String(userRating)
            audienceLabel.text = String(audience)
            synopsisLabel.text = movieDetail.synopsis
            directorLabel.text = movieDetail.director
            actorLabel.text = movieDetail.actor
            posterImageView.image = UIImage(named:"img_placeholder")
            gradeImageView.image = UIImage(named: movieDetail.gradeImage)
        }
    }
}
