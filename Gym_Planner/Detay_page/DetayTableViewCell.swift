//
//  DetayTableViewCell.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 14.08.2023.
//

import UIKit

class DetayTableViewCell: UITableViewCell {

    @IBOutlet weak var detayLabel: UILabel!
    @IBOutlet weak var dot: UIImageView!
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
