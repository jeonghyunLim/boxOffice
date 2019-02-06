//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    
    let audience : Int?
    let actor : String?
    let duration : Int?
    let director : String?
    let synopsis : String?
    let genre : String?
    let grade : Int?
    let image : String?
    let reservationGrade : Int?
    let title : String?
    let reservationRate : Double?
    let userRating : Double?
    let date : String?
    let id : String?
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
       
        audience = try values.decodeIfPresent(Int.self, forKey: .audience)
        actor = try values.decodeIfPresent(String.self, forKey: .actor)
        duration = try values.decodeIfPresent(Int.self, forKey: .duration)
        director = try values.decodeIfPresent(String.self, forKey: .director)
        synopsis = try values.decodeIfPresent(String.self, forKey: .synopsis)
        genre = try values.decodeIfPresent(String.self, forKey: .genre)
        grade = try values.decodeIfPresent(Int.self, forKey: .grade)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        reservationGrade = try values.decodeIfPresent(Int.self, forKey: .reservationGrade)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        reservationRate = try values.decodeIfPresent(Double.self, forKey: .reservationRate)
        userRating = try values.decodeIfPresent(Double.self, forKey: .userRating)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }
}
extension MovieDetail {
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



