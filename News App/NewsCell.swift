//
//  NewsCell.swift
//  News App
//
//  Created by Марк Курлович on 6/21/21.
//  Copyright © 2021 Марк Курлович. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
