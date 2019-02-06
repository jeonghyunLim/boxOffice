//
//  MovieCollectionViewCell.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var gradeImageView: UIImageView!
    @IBOutlet var userRatingLabel: UILabel!
    @IBOutlet var reservationGradeLabel: UILabel!
    @IBOutlet var reservationRateLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
}
