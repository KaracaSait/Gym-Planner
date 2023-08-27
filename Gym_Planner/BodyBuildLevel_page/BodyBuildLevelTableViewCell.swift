//
//  BodyBuildLevelTableViewCell.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 26.08.2023.
//

import UIKit

class BodyBuildLevelTableViewCell: UITableViewCell {

    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var daysPerWeekLabel: UILabel!
    @IBOutlet weak var workoutTypeLabel: UILabel!
    @IBOutlet weak var timePerWorkoutLabel: UILabel!
    @IBOutlet weak var mainGoalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
