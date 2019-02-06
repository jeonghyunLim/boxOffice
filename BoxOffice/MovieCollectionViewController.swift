//
//  MovieCollectionViewController.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import UIKit

class MovieCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    var movieList: [Movie] = []
    let cellIdentifier = "MovieCollectionCell"
    var orderType: Int = 0

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadMovieList(orderType: orderType)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = movieList[indexPath.item]
        
        if let reservationGrade = movie.reservationGrade, let date = movie.date, let userRating = movie.userRating, let reservationRate = movie.reservationRate {
            
            cell.titleLabel.text = movie.title
            cell.reservationGradeLabel.text = String(reservationGrade) + "위"
            cell.releaseDateLabel.text = String(date)
            cell.userRatingLabel.text = "(" + String(userRating) + ")"
            cell.reservationRateLabel.text = String(reservationRate) + "%"
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
                if let index = collectionView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.posterImageView.image = UIImage(data: thumbImageData)
                    }
                }
            }
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailInfoViewController = segue.destination as? DetailInfoViewController else { return }
        
        guard let cell = sender as? MovieCollectionViewCell else { return }
        
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let selectedIndex = indexPath.row
        
        detailInfoViewController.movieId = movieList[selectedIndex].id
        detailInfoViewController.navigationItem.title = movieList[selectedIndex].title
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
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBAction func showOrderType(_ sender: Any) {
        let orderSettingAlertController = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        
        let sortByReservationRate = UIAlertAction(title: "예매율순", style: .default) { (action) in
            self.orderType = 0
            self.reloadMovieList(orderType: 0)
        }
        
        let sortByCuration = UIAlertAction(title: "큐레이션순", style: .default) { (action) in
            self.orderType = 1
            self.reloadMovieList(orderType: 1)
        }
        
        let sortByReleaseDate = UIAlertAction(title: "개봉일순", style: .default) { (action) in
            self.orderType = 2
            self.reloadMovieList(orderType: 2)
        }
        
        let cancle = UIAlertAction(title: "취소", style: .cancel) { (action) in
            self.orderType = 0
        }
        
        orderSettingAlertController.addAction(sortByReservationRate)
        orderSettingAlertController.addAction(sortByCuration)
        orderSettingAlertController.addAction(sortByReleaseDate)
        orderSettingAlertController.addAction(cancle)
        
        present(orderSettingAlertController, animated: true, completion: nil)
    }
   
}
