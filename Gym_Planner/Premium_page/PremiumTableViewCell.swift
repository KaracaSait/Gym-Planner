//
//  PremiumTableViewCell.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 20.08.2023.
//

import UIKit

class PremiumTableViewCell: UITableViewCell {

    @IBOutlet weak var premiumLabel: UILabel!
    @IBOutlet weak var premiumDotImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.backgroundView = UIView()
        self.selectedBackgroundView = UIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
