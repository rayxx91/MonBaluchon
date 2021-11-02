//
//  WeatherTableViewCell.swift
//  odysee
//
//  Created by chaleroux on 30/09/2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var townLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var weatherImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
