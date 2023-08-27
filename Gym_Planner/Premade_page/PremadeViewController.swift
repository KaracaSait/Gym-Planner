//
//  PremadeViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 27.08.2023.
//

import UIKit

class PremadeViewController: UIViewController {
    @IBOutlet weak var premadeTableView: UITableView!
    @IBOutlet weak var dayLabel: UILabel!
    
    var data:Int?
    var List = [premade]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        self.premadeTableView.backgroundColor = UIColor.clear
        
        premadeTableView.dataSource = self
        premadeTableView.delegate = self
        
        if UserDefaults.standard.string(forKey: "sex") == "man" {
            if UserDefaults.standard.string(forKey: "level") == "beginnerMale" {
                switch data {
                case 0: dayLabel.text = "Monday"
                    List = beginnermaledao().veriOkumaA()
                case 1: dayLabel.text = "Wednesday"
                    List = beginnermaledao().veriOkumaB()
                case 2: dayLabel.text = "Friday"
                    List = beginnermaledao().veriOkumaA()
                default: break
                }
            }else if UserDefaults.standard.string(forKey: "level") == "IntermediateMale" {
                switch data {
                case 0: dayLabel.text = "Monday"
                    List = intermediatemaledao().veriOkumaA()
                case 1: dayLabel.text = "Tuesday"
                    List = intermediatemaledao().veriOkumaB()
                case 2: dayLabel.text = "Thursday"
                    List = intermediatemaledao().veriOkumaC()
                case 3: dayLabel.text = "Friday"
                    List = intermediatemaledao().veriOkumaD()
                default: break
                }
            }else if UserDefaults.standard.string(forKey: "level") == "AdvancedMale" {
                switch data {
                case 0: dayLabel.text = "Monday"
                    List = advancedmaledao().veriOkumaA()
                case 1: dayLabel.text = "Tuesday"
                    List = advancedmaledao().veriOkumaB()
                case 2: dayLabel.text = "Thursday"
                    List = advancedmaledao().veriOkumaC()
                case 3: dayLabel.text = "Friday"
                    List = advancedmaledao().veriOkumaD()
                default: break
                }
            }
        }else if UserDefaults.standard.string(forKey: "sex") == "woman" {
            switch data {
            case 0: print("beginner sayfası kadın")
            case 1: print("orta sayfası kadın")
            case 2: print("woaw sayfası kadın")
            default: break
            }
        }
        
    }
    
    @IBAction func infoButton(_ sender: Any) {
        let alert = UIAlertController(title: "Info", message: "(+)-->Drop Set (^)-->Adding Weight ", preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(okeyAction)
        self.present(alert,animated: true)
    }
    
}

extension PremadeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return List.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = List[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "premadeHucre", for: indexPath) as! PremadeTableViewCell
        //cell.detayLabel.text = part.movement_name
        cell.label.text = part.movement
        if let set = part.sets, let rep = part.reps {
            cell.setrepLabel.text = "\(set) x \(rep)"
        }
        
        return cell
    }
}
