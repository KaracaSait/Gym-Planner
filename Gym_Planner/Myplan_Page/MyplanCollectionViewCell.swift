//
//  MyplanCollectionViewCell.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 16.08.2023.
//

import UIKit

class MyplanCollectionViewCell: UICollectionViewCell {
    
    var renameButtonTappedHandler: (() -> Void)?
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellimage: UIImageView!
    
    @IBAction func renameButton(_ sender: Any) {
        renameButtonTappedHandler?()
    }
    
}
