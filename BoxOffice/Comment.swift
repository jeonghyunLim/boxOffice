//
//  Comment.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import Foundation

struct CommentInfoList: Codable {
    let comments: [Comment]?
    let movieId: String?
}

struct Comment: Codable {
    
    let rating: Double?
    let timestamp: Double?
    let writer: String?
    let movieId: String?
    let contents: String?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        contents = try values.decodeIfPresent(String.self, forKey: .contents)
        movieId = try values.decodeIfPresent(String.self, forKey: .movieId)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        timestamp = try values.decodeIfPresent(Double.self, forKey: .timestamp)
        writer = try values.decodeIfPresent(String.self, forKey: .writer)
    }
    init(rating: Double?, writer: String?, movieId: String?, contents: String){
        self.rating = rating
        self.timestamp = nil
        self.writer = writer
        self.movieId = movieId
        self.contents = contents
    }
}

