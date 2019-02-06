//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by 임정현 on 06/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    var movieId: String?
    var movieTitle: String?
    var movieGrade: String?
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var writerTextField: UITextField!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var movieGradeImageView: UIImageView!
    
    @IBAction func saveComment(_ sender: Any){
        
        if let writer = writerTextField.text, let contents = commentTextView.text {
         
            let comment = Comment(rating: 10, writer: writer, movieId: movieId, contents: contents)
            postCommentSave(comment: comment){ result, isSucceed in
                if !isSucceed { return }
                DispatchQueue.main.async{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        writerTextField.resignFirstResponder()
        return true
    }
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        commentTextView.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writerTextField.delegate = self
        commentTextView.delegate = self
        
        movieTitleLabel.text = movieTitle
        commentTextView.textColor = UIColor.lightGray
        commentTextView.layer.borderColor = UIColor.lightGray.cgColor
        commentTextView.layer.borderWidth = 0.5
        commentTextView.layer.cornerRadius = 5.0
        
        if let gradeImage = movieGrade {
            movieGradeImageView.image = UIImage(named: gradeImage)
        }
    }
 
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "한줄평을 작성해주세요"
            textView.textColor = UIColor.lightGray
        }
    }
   

}
