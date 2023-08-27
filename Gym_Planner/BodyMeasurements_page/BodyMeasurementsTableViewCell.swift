//
//  BodyMeasurementsTableViewCell.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 22.08.2023.
//

import UIKit

class BodyMeasurementsTableViewCell: UITableViewCell {

    @IBOutlet weak var addDataButton: UIButton!
    @IBOutlet weak var measurementsLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var addDataButtonTappedHandler: (() -> Void)?
    var actionButtonTappedHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addDataButton.tintColor = .white
        addDataButton.setTitle("Add Data", for: .normal)
        addDataButton.backgroundColor = .black
        addDataButton.layer.cornerRadius = addDataButton.frame.size.width / 15
        
        actionButton.tintColor = .black
        
        self.backgroundColor = UIColor.clear
        self.backgroundView = UIView()
        self.selectedBackgroundView = UIView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addDataButtonAction(_ sender: Any) {
        addDataButtonTappedHandler?()
    }
    @IBAction func actionButttonAction(_ sender: Any) {
        actionButtonTappedHandler?()
    }
}
