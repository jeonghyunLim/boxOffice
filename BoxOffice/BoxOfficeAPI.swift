//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import Foundation

let BASE_URL = "http://connect-boxoffice.run.goorm.io/"

func getMovieInfo(orderType: Int, completion: @escaping ([Movie]?, Bool) -> Void) {
    
    guard let url = URL(string: BASE_URL + "movies?order_type=\(orderType)") else { return }
    
    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else { return }
        do {
            let decoder: JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movieInfoList: MovieInfoList = try decoder.decode(MovieInfoList.self, from: data)
            completion(movieInfoList.movies, true)
        } catch let error {
            print(error.localizedDescription)
            completion(nil, false)
        }
    }
    dataTask.resume()
}

func getMovieDetailInfo(id: String,  completion: @escaping (MovieDetail?, Bool) -> Void) {
    
    guard let url = URL(string: BASE_URL + "movie?id=\(id)") else { return }
    
    let session = URLSession(configuration: .default)
    
    let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else { return }
        do {
            let decoder: JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let movieDetailInfo: MovieDetail = try decoder.decode(MovieDetail.self, from: data)
            completion(movieDetailInfo, true)
            
        } catch let error {
            print(error.localizedDescription)
            completion(nil, false)
        }
    }
    dataTask.resume()
}

func getCommentList(id: String, completion: @escaping ([Comment]?, Bool) -> Void) {

    guard let url = URL(string: BASE_URL + "comments?movie_id=\(id)") else { return }
    
    let session = URLSession(configuration: .default)
    
    let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else { return }
        
        do {
            let decoder: JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let commentInfoList: CommentInfoList = try decoder.decode(CommentInfoList.self, from: data)
            
            guard let commentList = commentInfoList.comments else { return }
            completion(commentList, true)
            
        } catch let error {
            print(error.localizedDescription)
            completion(nil, false)
        }
    }
    dataTask.resume()
}

func postCommentSave(comment: Comment, completion: @escaping (Comment?, Bool) -> Void) {
    guard let url = URL(string: BASE_URL + "comment") else { return }
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    urlRequest.setValue("application/json", forHTTPHeaderField: "Content-type")
    
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    do {
        let commentData = try encoder.encode(comment)
        urlRequest.httpBody = commentData
    } catch {
        print(error.localizedDescription)
    }

    let session = URLSession(configuration: .default)
    let dataTask = session.dataTask(with: urlRequest) { (data: Data?, response: URLResponse?, error: Error?) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else { return }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
        }
        
        do {
            let decoder: JSONDecoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let savedComment: Comment = try decoder.decode(Comment.self, from: data)
            completion(savedComment, true)
            
        } catch let error {
            print(error.localizedDescription)
            completion(nil, false)
        }
    }
    dataTask.resume()
}
