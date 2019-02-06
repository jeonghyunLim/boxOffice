//
//  DetailInfoViewController.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import UIKit

class DetailInfoViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var movieDetail: MovieDetail?
    var commentList: [Comment] = []
    var movieId: String?
    
    @IBOutlet var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        guard let movieId = movieId else { return }
        
        getCommentList(id: movieId) { result, isSucceed in
            if !isSucceed { return }
            guard let result = result else { return }
            self.commentList = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movieId = movieId else { return }
    
        getMovieDetailInfo(id: movieId) { result, isSucceed in
         
            if !isSucceed { return }
            guard let result = result else { return }
            
            self.movieDetail = result
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return commentList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell", for: indexPath) as? DetailInfoCell else { return UITableViewCell() }
            
            if let movieDetail = movieDetail {
                cell.configure(movieDetail)
            }
            
            DispatchQueue.global().async {
                guard let image = self.movieDetail?.image, let imageURL = URL(string: image), let imageData = try? Data(contentsOf: imageURL) else { return }
                
                DispatchQueue.main.async {
                    cell.posterImageView.image = UIImage(data: imageData)
                }
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as? CommentCell else { return UITableViewCell() }
            let comment = commentList[indexPath.row]
            cell.configure(comment)
            
            return cell
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let commentViewController = segue.destination as? CommentViewController else {
            return
        }
    
        commentViewController.movieId = movieId
        commentViewController.movieTitle = movieDetail?.title
        commentViewController.movieGrade = movieDetail?.gradeImage
    }
}

