//
//  PlanViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 16.08.2023.
//

import UIKit

class PlanViewController: UIViewController {
    
    var PlanList = [Plan]()
    var whichDay:Int?
    var dayListParameter:Day?
    @IBOutlet weak var favButtonImage: UIButton!
    @IBOutlet weak var planTableView: UITableView!
    @IBOutlet weak var planLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        self.planTableView.backgroundColor = UIColor.clear
        
        favS()
        
        planTableView.dataSource = self
        planTableView.delegate = self
        
    }
    
    @IBAction func favButton(_ sender: Any) {
        if let witchDay = whichDay, witchDay >= 0, witchDay <= 8 {
            let newSystemImage = UIImage(systemName: "star.fill")
            favButtonImage.setImage(newSystemImage, for: .normal)
            
            UserDefaults.standard.set(witchDay, forKey: "Fav")
            
            if let newText = dayListParameter?.day_name {
                UserDefaults.standard.set(newText, forKey: "savedText")
            }
        }
    }
    @IBAction func sayfaSil(_ sender: Any) {
        let del = self.dayListParameter?.day_id
        showDeleteAlert(day_id: del!)
    }
    func showDeleteAlert(day_id:Int) {
            let alertController = UIAlertController(title: "Delete Plan", message: "", preferredStyle: .alert)
            let delAction = UIAlertAction(title: "Delete", style: .destructive) { action in
                daydao().veriSil(day_id: day_id)
                if self.whichDay == 0 {
                    myplanMovedao().veriTasi1to0()
                    myplanMovedao().veriTasi2to1()
                    myplanMovedao().veriTasi3to2()
                    myplanMovedao().veriTasi4to3()
                    myplanMovedao().veriTasi5to4()
                    myplanMovedao().veriTasi6to5()
                    myplanMovedao().veriTasi7to6()
                    myplanMovedao().veriTasi8to7()
                    if UserDefaults.standard.integer(forKey: "Fav") == 0 {
                        UserDefaults.standard.set( 9 , forKey: "Fav")
                        self.favDel()
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 1 {
                        UserDefaults.standard.set( 0 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 2 {
                        UserDefaults.standard.set( 1 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 3 {
                        UserDefaults.standard.set( 2 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 4 {
                        UserDefaults.standard.set( 3 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 5 {
                        UserDefaults.standard.set( 4 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
                        UserDefaults.standard.set( 5 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
                        UserDefaults.standard.set( 6 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                        UserDefaults.standard.set( 7 , forKey: "Fav")
                    }
                }else if self.whichDay == 1 {
                    myplanMovedao().veriTasi2to1()
                    myplanMovedao().veriTasi3to2()
                    myplanMovedao().veriTasi4to3()
                    myplanMovedao().veriTasi5to4()
                    myplanMovedao().veriTasi6to5()
                    myplanMovedao().veriTasi7to6()
                    myplanMovedao().veriTasi8to7()
                    if UserDefaults.standard.integer(forKey: "Fav") == 1 {
                        UserDefaults.standard.set( 9 , forKey: "Fav")
                        self.favDel()
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 2 {
                        UserDefaults.standard.set( 1 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 3 {
                        UserDefaults.standard.set( 2 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 4 {
                        UserDefaults.standard.set( 3 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 5 {
                        UserDefaults.standard.set( 4 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
                        UserDefaults.standard.set( 5 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
                        UserDefaults.standard.set( 6 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                        UserDefaults.standard.set( 7 , forKey: "Fav")
                    }
                }else if self.whichDay == 2 {
                    myplanMovedao().veriTasi3to2()
                    myplanMovedao().veriTasi4to3()
                    myplanMovedao().veriTasi5to4()
                    myplanMovedao().veriTasi6to5()
                    myplanMovedao().veriTasi7to6()
                    myplanMovedao().veriTasi8to7()
                    if UserDefaults.standard.integer(forKey: "Fav") == 2 {
                        UserDefaults.standard.set( 9 , forKey: "Fav")
                        self.favDel()
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 3 {
                        UserDefaults.standard.set( 2 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 4 {
                        UserDefaults.standard.set( 3 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 5 {
                        UserDefaults.standard.set( 4 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
                        UserDefaults.standard.set( 5 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
                        UserDefaults.standard.set( 6 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                        UserDefaults.standard.set( 7 , forKey: "Fav")
                    }
                }else if self.whichDay == 3 {
                    myplanMovedao().veriTasi4to3()
                    myplanMovedao().veriTasi5to4()
                    myplanMovedao().veriTasi6to5()
                    myplanMovedao().veriTasi7to6()
                    myplanMovedao().veriTasi8to7()
                    if UserDefaults.standard.integer(forKey: "Fav") == 3 {
                        UserDefaults.standard.set( 9 , forKey: "Fav")
                        self.favDel()
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 4 {
                        UserDefaults.standard.set( 3 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 5 {
                        UserDefaults.standard.set( 4 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
                        UserDefaults.standard.set( 5 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
                        UserDefaults.standard.set( 6 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                        UserDefaults.standard.set( 7 , forKey: "Fav")
                    }
                }else if self.whichDay == 4 {
                    myplanMovedao().veriTasi5to4()
                    myplanMovedao().veriTasi6to5()
                    myplanMovedao().veriTasi7to6()
                    myplanMovedao().veriTasi8to7()
                    if UserDefaults.standard.integer(forKey: "Fav") == 4 {
                        UserDefaults.standard.set( 9 , forKey: "Fav")
                        self.favDel()
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 5 {
                        UserDefaults.standard.set( 4 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
                        UserDefaults.standard.set( 5 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
                        UserDefaults.standard.set( 6 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                        UserDefaults.standard.set( 7 , forKey: "Fav")
                    }
                }else if self.whichDay == 5 {
                    myplanMovedao().veriTasi6to5()
                    myplanMovedao().veriTasi7to6()
                    myplanMovedao().veriTasi8to7()
                    if UserDefaults.standard.integer(forKey: "Fav") == 5 {
                        UserDefaults.standard.set( 9 , forKey: "Fav")
                        self.favDel()
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
                        UserDefaults.standard.set( 5 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
                        UserDefaults.standard.set( 6 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                        UserDefaults.standard.set( 7 , forKey: "Fav")
                    }
                }else if self.whichDay == 6 {
                    myplanMovedao().veriTasi7to6()
                    myplanMovedao().veriTasi8to7()
                    if UserDefaults.standard.integer(forKey: "Fav") == 6 {
                        UserDefaults.standard.set( 9 , forKey: "Fav")
                        self.favDel()
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
                        UserDefaults.standard.set( 6 , forKey: "Fav")
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                        UserDefaults.standard.set( 7 , forKey: "Fav")
                    }
                }else if self.whichDay == 7 {
                    myplanMovedao().veriTasi8to7()
                    if UserDefaults.standard.integer(forKey: "Fav") == 7 {
                        UserDefaults.standard.set( 9 , forKey: "Fav")
                        self.favDel()
                    }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                        UserDefaults.standard.set( 7 , forKey: "Fav")
                    }
                }else if self.whichDay == 8 {
                    myplandao8().temizle()
                    if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                        UserDefaults.standard.set( 9 , forKey: "Fav")
                        self.favDel()
                    }
                }
                self.navigationController?.popViewController(animated: true)
            }
            let iptalAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(delAction)
            iptalAction.setValue(UIColor.black, forKey: "titleTextColor")
            alertController.addAction(iptalAction)
            self.present(alertController, animated: true)
        }
    func favDel(){
            let newText = "No Favorite Selected"
            UserDefaults.standard.set(newText, forKey: "savedText")
    }
    func favS() {
        guard whichDay! >= 0 && whichDay! <= 8 else {
            return
        }
        
        let planList: [Plan]
        switch whichDay {
        case 0: planList = myplandao().veriOkumaDetay()
        case 1: planList = myplandao1().veriOkumaDetay()
        case 2: planList = myplandao2().veriOkumaDetay()
        case 3: planList = myplandao3().veriOkumaDetay()
        case 4: planList = myplandao4().veriOkumaDetay()
        case 5: planList = myplandao5().veriOkumaDetay()
        case 6: planList = myplandao6().veriOkumaDetay()
        case 7: planList = myplandao7().veriOkumaDetay()
        case 8: planList = myplandao8().veriOkumaDetay()
        default: return
        }
        PlanList = planList
        planLabel.text = dayListParameter?.day_name!
        let isFavorite = UserDefaults.standard.integer(forKey: "Fav") == whichDay
        let imageName = isFavorite ? "star.fill" : "star"
        let newSystemImage = UIImage(systemName: imageName)
        favButtonImage.setImage(newSystemImage, for: .normal)
    }
}
extension PlanViewController:UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlanList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = PlanList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "planHucre", for: indexPath) as! PlanTableViewCell
        cell.planMovementLabel.text = part.movement_name
        if let setSayi = part.set1, let setSayi2 = part.set2 {
            cell.planSetLabel.text = "\(setSayi) x \(setSayi2)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let silAction = UIContextualAction(style: .destructive, title: "Delete"){ (contextualAction, view, boolValue) in
                let del = self.PlanList[indexPath.row].movement_id!
                if self.whichDay == 0 {
                    myplandao().veriSil(movement_id: del)
                    self.PlanList = myplandao().veriOkumaDetay()
                }else if self.whichDay == 1 {
                    myplandao1().veriSil(movement_id: del)
                    self.PlanList = myplandao1().veriOkumaDetay()
                }else if self.whichDay == 2 {
                    myplandao2().veriSil(movement_id: del)
                    self.PlanList = myplandao2().veriOkumaDetay()
                }else if self.whichDay == 3 {
                    myplandao3().veriSil(movement_id: del)
                    self.PlanList = myplandao3().veriOkumaDetay()
                }else if self.whichDay == 4 {
                    myplandao4().veriSil(movement_id: del)
                    self.PlanList = myplandao4().veriOkumaDetay()
                }else if self.whichDay == 5 {
                    myplandao5().veriSil(movement_id: del)
                    self.PlanList = myplandao5().veriOkumaDetay()
                }else if self.whichDay == 6 {
                    myplandao6().veriSil(movement_id: del)
                    self.PlanList = myplandao6().veriOkumaDetay()
                }else if self.whichDay == 7 {
                    myplandao7().veriSil(movement_id: del)
                    self.PlanList = myplandao7().veriOkumaDetay()
                }else if self.whichDay == 8 {
                    myplandao8().veriSil(movement_id: del)
                    self.PlanList = myplandao8().veriOkumaDetay()
                }
                UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                        }, completion: nil) 
                self.planTableView.reloadData()
            }
            return UISwipeActionsConfiguration(actions: [silAction])
    }
}
