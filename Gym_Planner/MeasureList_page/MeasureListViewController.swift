//
//  MeasureListViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 22.08.2023.
//

import UIKit

class MeasureListViewController: UIViewController {
    
    @IBOutlet weak var measureListTableView: UITableView!
    @IBOutlet weak var measureListLabel: UILabel!
    @IBOutlet weak var clearListButtonImage: UIBarButtonItem!
    
    var measureRow: Int?
    var measureList = [MeasureSize]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        self.measureListTableView.backgroundColor = UIColor.clear

        switch measureRow {
        case 0:
            measureListLabel.text = "Body Weight"
            measureList = bodyweightsizedao().veriOkuma()
        case 1:
            measureListLabel.text = "Arm Size"
            measureList = armsizedao().veriOkuma()
        case 2:
            measureListLabel.text = "Shoulder Size"
            measureList = shouldersizedao().veriOkuma()
        case 3:
            measureListLabel.text = "Chest Size"
            measureList = chestsizedao().veriOkuma()
        case 4:
            measureListLabel.text = "Waist Size"
            measureList = waistsizedao().veriOkuma()
        case 5:
            measureListLabel.text = "Wrist Size"
            measureList = wristsizedao().veriOkuma()
        case 6:
            measureListLabel.text = "Leg Size"
            measureList = legsizedao().veriOkuma()
        case 7:
            measureListLabel.text = "Hip Size"
            measureList = hipsizedao().veriOkuma()
        default: break
            
        }
        
        measureListTableView.dataSource = self
        measureListTableView.delegate = self
        
    }
    
    @IBAction func clearList(_ sender: Any) {
        switch self.measureRow {
        case 0:
            delAlert(part: "Body Weight List")
        case 1:
            delAlert(part: "Arm Size List")
        case 2:
            delAlert(part: "Shoulder Size List")
        case 3:
            delAlert(part: "Chest Size List")
        case 4:
            delAlert(part: "Waist Size List")
        case 5:
            delAlert(part: "Wrist Size List")
        case 6:
            delAlert(part: "Leg Size List")
        case 7:
            delAlert(part: "Hip Size List")
        default: break
        }
        
    }
    func delAlert(part:String){
        let alertController = UIAlertController(title: part , message: "Any changes you have made will be deleted. Are you sure?", preferredStyle: .alert)
        
        let resAction = UIAlertAction(title: "Yes", style: .destructive){ action in
            switch self.measureRow {
            case 0:
                bodyweightsizedao().temizle()
                self.measureList = bodyweightsizedao().veriOkuma()
            case 1:
                armsizedao().temizle()
                self.measureList = armsizedao().veriOkuma()
            case 2:
                shouldersizedao().temizle()
                self.measureList = shouldersizedao().veriOkuma()
            case 3:
                chestsizedao().temizle()
                self.measureList = chestsizedao().veriOkuma()
            case 4:
                waistsizedao().temizle()
                self.measureList = waistsizedao().veriOkuma()
            case 5:
                wristsizedao().temizle()
                self.measureList = wristsizedao().veriOkuma()
            case 6:
                legsizedao().temizle()
                self.measureList = legsizedao().veriOkuma()
            case 7:
                hipsizedao().temizle()
                self.measureList = hipsizedao().veriOkuma()
            default: break
            }
            self.measureListTableView.reloadData()
            self.clearListButtonImage.isEnabled = false
        }
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(resAction)
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor") 
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        if measureList.count == 0 {
            clearListButtonImage.isEnabled = false
        }
    }
}

extension MeasureListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = measureList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "measureListHucre", for: indexPath) as! MeasureListTableViewCell
        cell.dateLabel.text = part.size_date
        if measureRow == 0 {
            if UserDefaults.standard.string(forKey: "agirlik") == "kg" {
                if part.size_unit == "Kg" {
                    cell.sizeLabel.text = part.size_size
                }else if part.size_unit == "Lbs" {
                    cell.sizeLabel.text = String(format: "%.2f", Double(part.size_size!)! *  0.45359237 )
                }
                cell.CmOrIncLabel.text = "Kg"
            }else if UserDefaults.standard.string(forKey: "agirlik") == "lbs" {
                if part.size_unit == "Kg" {
                    cell.sizeLabel.text = String(format: "%.2f", Double(part.size_size!)! * 2.20462 )
                }else if part.size_unit == "Lbs" {
                    cell.sizeLabel.text = part.size_size
                }
                cell.CmOrIncLabel.text = "Lbs"
            }
        }else{
            if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                if part.size_unit == "Cm" {
                    cell.sizeLabel.text = part.size_size
                }else if part.size_unit == "Inc" {
                    cell.sizeLabel.text = String(format: "%.2f", Double(part.size_size!)! * 2.54 )
                }
                cell.CmOrIncLabel.text = "Cm"
            }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                if part.size_unit == "Cm" {
                    cell.sizeLabel.text = String(format: "%.2f", Double(part.size_size!)! * 0.393701 )
                }else if part.size_unit == "Inc" {
                    cell.sizeLabel.text = part.size_size
                }
                cell.CmOrIncLabel.text = "Inch"
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let silAction = UIContextualAction(style: .destructive, title: "Delete"){ (contextualAction, view, boolValue) in
                let del = self.measureList[indexPath.row].size_id!
                if self.measureRow == 0 {
                    bodyweightsizedao().veriSil(size_id: del)
                    self.measureList = bodyweightsizedao().veriOkuma()
                }else if self.measureRow == 1 {
                    armsizedao().veriSil(size_id: del)
                    self.measureList = armsizedao().veriOkuma()
                }else if self.measureRow == 2 {
                    shouldersizedao().veriSil(size_id: del)
                    self.measureList = shouldersizedao().veriOkuma()
                }else if self.measureRow == 3 {
                    chestsizedao().veriSil(size_id: del)
                    self.measureList = chestsizedao().veriOkuma()
                }else if self.measureRow == 4 {
                    waistsizedao().veriSil(size_id: del)
                    self.measureList = waistsizedao().veriOkuma()
                }else if self.measureRow == 5 {
                    wristsizedao().veriSil(size_id: del)
                    self.measureList = wristsizedao().veriOkuma()
                }else if self.measureRow == 6 {
                    legsizedao().veriSil(size_id: del)
                    self.measureList = legsizedao().veriOkuma()
                }else if self.measureRow == 7 {
                    hipsizedao().veriSil(size_id: del)
                    self.measureList = hipsizedao().veriOkuma()
                }
                UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        }, completion: nil)
                if self.measureList.count == 0 {
                    self.clearListButtonImage.isEnabled = false
                }
                self.measureListTableView.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [silAction])
    }
}
