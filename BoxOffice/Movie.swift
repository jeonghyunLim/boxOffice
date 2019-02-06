//
//  Movie.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import Foundation

struct MovieInfoList: Codable {
    let orderType: Int
    let movies: [Movie]
}

struct Movie: Codable {
    
    let grade: Int?
    let thumb: String?
    let reservationGrade: Int?
    let title: String?
    let reservationRate: Double?
    let userRating: Double?
    let date: String?
    let id: String?
    
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        grade = try values.decodeIfPresent(Int.self, forKey: .grade)
        thumb = try values.decodeIfPresent(String.self, forKey: .thumb)
        reservationGrade = try values.decodeIfPresent(Int.self, forKey: .reservationGrade)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        reservationRate = try values.decodeIfPresent(Double.self, forKey: .reservationRate)
        userRating = try values.decodeIfPresent(Double.self, forKey: .userRating)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }
}
extension Movie {
    var gradeImage : String {
        switch self.grade {
        case 0:
            return "ic_allages"
        case 12:
            return "ic_12"
        case 15:
            return "ic_15"
        case 19:
            return "ic_19"
        default:
            return  "ic_allages"
        }
    }
}
