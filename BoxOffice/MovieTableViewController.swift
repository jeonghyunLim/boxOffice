//
//  MovieTableViewController.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import UIKit

class MovieTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movieList: [Movie] = []
    let cellIdentifier = "MovieTableCell"
    var orderType: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movieList[indexPath.row]
        
        if let reservationGrade = movie.reservationGrade, let date = movie.date, let userRating = movie.userRating, let reservationRate = movie.reservationRate {
            cell.titleLabel.text = movie.title
            cell.reservationGradeLabel.text = String(reservationGrade)
            cell.releaseDateLabel.text = String(date)
            cell.userLatingLabel.text = String(userRating)
            cell.reservationRateLabel.text = String(reservationRate)
            cell.posterImageView.image = UIImage(named: "img_placeholder")
            cell.gradeImageView.image = UIImage(named: movie.gradeImage)
        }
    
        DispatchQueue.global().async {
            guard let thumb = movie.thumb else { return }
            guard let thumbImageURL = URL(string: thumb) else {
                return
            }
            
            guard let thumbImageData = try? Data(contentsOf: thumbImageURL) else {
                return
            }
            
            DispatchQueue.main.async {
                if let index = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.posterImageView.image = UIImage(data: thumbImageData)
                    }
                }
            }
        }
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadMovieList(orderType: orderType)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getMovieInfo(orderType: orderType) { result, isSucceed in
            if !isSucceed { return }
            guard let result = result else { return }

            self.movieList = result
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailInfoViewController = segue.destination as? DetailInfoViewController else {
            return
        }
        
        guard let selectedRowIndex = tableView.indexPathForSelectedRow?.row else { return }
        
        detailInfoViewController.movieId = movieList[selectedRowIndex].id
        detailInfoViewController.navigationItem.title = movieList[selectedRowIndex].title
    }
    
    
    private func reloadMovieList(orderType: Int) {
       
        getMovieInfo(orderType: orderType) { result, isSucceed in
            
            if !isSucceed { return }
            
            guard let result = result else { return }
            self.movieList = result
            
            let navigationTitle: String
            
            switch orderType {
            case 0:
                navigationTitle = "예매율순"
            case 1:
                navigationTitle = "큐레이션순"
            case 2:
                navigationTitle = "개봉일순"
            default:
                navigationTitle = "예매율순"
            }
            
            self.navigationController?.navigationBar.topItem?.title = navigationTitle
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func showOrderType(_ sender: Any) {
        
        let orderSettingAlertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        
        let sortByRateAction = UIAlertAction(title: "예매율순", style: .default) { (action) in
            self.orderType = 0
            self.reloadMovieList(orderType: 0)
        }
        
        let sortByCurationAction = UIAlertAction(title: "큐레이션순", style: .default) { (action) in
            self.orderType = 1
            self.reloadMovieList(orderType: 1)
        }
        
        let sortByDateAction = UIAlertAction(title: "개봉일순", style: .default) { (action) in
            self.orderType = 2
            self.reloadMovieList(orderType:2)
        }
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel) { (action) in
            self.orderType = 0
        }
        
        orderSettingAlertController.addAction(sortByRateAction)
        orderSettingAlertController.addAction(sortByCurationAction)
        orderSettingAlertController.addAction(sortByDateAction)
        orderSettingAlertController.addAction(cancleAction)
        
        present(orderSettingAlertController, animated: true, completion: nil)
    }
}
