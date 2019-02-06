//
//  CommentCell.swift
//  BoxOffice
//
//  Created by 임정현 on 05/02/2019.
//  Copyright © 2019 임정현. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

   
    @IBOutlet var writerLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    
    func configure(_ data: Comment) {
        writerLabel.text = data.writer
        contentsLabel.text = data.contents

        if let timestamp = data.timestamp {
            let date = Date(timeIntervalSince1970: timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateToString = dateFormatter.string(from: date)
            dateLabel.text = dateToString
        }
    }
}
