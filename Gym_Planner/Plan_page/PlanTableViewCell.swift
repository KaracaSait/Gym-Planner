//
//  PlanTableViewCell.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 16.08.2023.
//

import UIKit

class PlanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var planMovementLabel: UILabel!
    @IBOutlet weak var planSetLabel: UILabel!
    
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
