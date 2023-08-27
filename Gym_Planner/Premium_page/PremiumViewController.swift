//
//  PremiumViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 16.08.2023.
//

import UIKit


protocol PremiumViewControllerDelegate: AnyObject {
    func premiumDismis()
}

class PremiumViewController: UIViewController {
    
    weak var delegate: PremiumViewControllerDelegate?

    @IBOutlet weak var premiumLogo: UIImageView!
    @IBOutlet weak var satinAlButtonImage: UIButton!
    @IBOutlet weak var premiumTableView: UITableView!
    
    var featureList = [premium]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        satinAlButtonImage.tintColor = .white
        satinAlButtonImage.setTitle("Get Premium", for: .normal)
        satinAlButtonImage.backgroundColor = .black
        satinAlButtonImage.layer.cornerRadius = satinAlButtonImage.frame.size.width / 20
        
        self.premiumTableView.backgroundColor = UIColor.clear // table view background rengi
        let backgroundImageTableView = UIImage(named: "premiumtable")
        let backgroundViewTableView = UIImageView(image: backgroundImageTableView)
        premiumTableView.backgroundView = backgroundViewTableView
        
        premiumLogo.image = UIImage(named: "icon")
        
        let p1 = premium(feature: "Get more extra plan pages")
        let p2 = premium(feature: "Access your plans directly by selecting your favorite page")
        let p3 = premium(feature: "Save body size with date")
        let p4 = premium(feature: "Get body mass index calculator")
        let p5 = premium(feature: "Get body fat percentage calculator")
        featureList.append(p1)
        featureList.append(p2)
        featureList.append(p3)
        featureList.append(p4)
        featureList.append(p5)
        
        premiumTableView.dataSource = self
        premiumTableView.delegate = self
        
        
    }
    
    @IBAction func SatinAl(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "premium")
        //print("satın alım tamamlandı")
        // premiuma hoş geldin sayfası aç // gerek olmayabilir
        delegate?.premiumDismis()
        dismiss(animated: true, completion: nil)
           }
    }

extension PremiumViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return featureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = featureList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "premiumHucre", for: indexPath) as! PremiumTableViewCell
        cell.premiumLabel.textColor = .white
        cell.premiumLabel.text = part.feature
        return cell
    }
    
}
