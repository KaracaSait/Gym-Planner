//
//  MeasureListTableViewCell.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 22.08.2023.
//

import UIKit

class MeasureListTableViewCell: UITableViewCell {

    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var CmOrIncLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateLabel.textColor = .gray
        
        self.backgroundColor = UIColor.clear // hücre içi renk
        self.backgroundView = UIView()
        self.selectedBackgroundView = UIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
