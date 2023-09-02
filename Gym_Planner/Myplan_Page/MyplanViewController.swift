//
//  MyplanViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 15.08.2023.
//

import UIKit

protocol MyplanViewControllerDelegate: AnyObject {
    func addListAuto() 
}

class MyplanViewController: UIViewController {
    
    weak var delegate: MyplanViewControllerDelegate?
    
    var dayList = [Day]()
    
    @IBOutlet weak var myplanCollectionViewCell: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate?.addListAuto()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        myplanCollectionViewCell.backgroundColor = .clear
        let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.myplanCollectionViewCell.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.itemSize = CGSize(width: (genislik - 60) , height: (genislik - 60)  / 1.85 )
        tasarim.minimumInteritemSpacing = 5
        tasarim.minimumLineSpacing = 30
        myplanCollectionViewCell.collectionViewLayout = tasarim
        
        myplanCollectionViewCell.dataSource = self
        myplanCollectionViewCell.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        dayList = daydao().veriOkuma()
        myplanCollectionViewCell.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "myplanToPlan" {
            if let parameter = sender as? Int,
               let gidilecekVC = segue.destination as? PlanViewController {
                gidilecekVC.whichDay = parameter
                gidilecekVC.dayListParameter = dayList[parameter]
            }
        }else if segue.identifier == "toPremium" {
            if let premiumViewCont = segue.destination as? PremiumViewController {
                premiumViewCont.delegate = self
            }
        }
    }
}

extension MyplanViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.dayList.count == 9 { // page limit
            return dayList.count
        }else{
            return dayList.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == dayList.count  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addHucre", for: indexPath) as! AddCollectionViewCell
                if UserDefaults.standard.bool(forKey: "premium") == false {
                    if dayList.count == 0 {
                        cell.addButtonImage.image = UIImage(named: "premiumversionplus")
                    }else {
                        cell.addButtonImage.image = UIImage(named: "freeversionplus")
                    }
                } else {
                    cell.addButtonImage.image = UIImage(named: "premiumversionplus")
                }
            return cell
               } else {
                    let part = dayList[indexPath.row]
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "planCell", for: indexPath) as! MyplanCollectionViewCell
                    cell.cellLabel.text = part.day_name
                    cell.renameButtonTappedHandler = {
                        self.editAlert(indeks: indexPath.row, edit: part.day_id!)
                    }
                   cell.cellLabel.textColor = .white
                   cell.cellimage.image = UIImage(named: "blackcell")
                   return cell
               }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == dayList.count {
            if dayList.count == 0 {
                listeEkle()
            }else {
                if UserDefaults.standard.bool(forKey: "premium") == false {
                    performSegue(withIdentifier: "toPremium", sender: nil)
                } else {
                    listeEkle()
                }
            }
        } else {
            performSegue(withIdentifier: "myplanToPlan", sender: indexPath.item)
        }
    }
    
    func listeEkle() {
        let alertController = UIAlertController(title: "Add List", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "List Name"
            textfield.keyboardType = .default
        }
        let kaydetAction = UIAlertAction(title: "Save", style: .destructive){ action in
            if let listName = alertController.textFields?[0].text, !listName.isEmpty {
                daydao().veriEkle(day_name: listName)
                self.dayList = daydao().veriOkuma()
                self.myplanCollectionViewCell.reloadData()
            }else{
                let errorAlert = UIAlertController(title: "Error", message: "Please fill in the field", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(kaydetAction)
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor") 
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
    
     func editAlert(indeks:Int,edit: Int) {
         let alertController = UIAlertController(title: "Edit List", message: "", preferredStyle: .alert)
         alertController.addTextField { textfield in
             textfield.placeholder = "List Name"
             textfield.keyboardType = .default
         }
         let kaydetAction = UIAlertAction(title: "Save", style: .destructive){ action in
             if let ListEditName = alertController.textFields?[0].text, !ListEditName.isEmpty {
                 daydao().veriGüncelle(day_name: ListEditName, day_id: edit)
                 self.dayList = daydao().veriOkuma()
                 self.myplanCollectionViewCell.reloadData()
                 
                 switch indeks {
                 case 0:
                     if UserDefaults.standard.integer(forKey: "Fav") == 0 {
                         UserDefaults.standard.set(ListEditName, forKey: "savedText")
                     }
                 case 1:
                     if UserDefaults.standard.integer(forKey: "Fav") == 1 {
                         UserDefaults.standard.set(ListEditName, forKey: "savedText")
                     }
                 case 2:
                     if UserDefaults.standard.integer(forKey: "Fav") == 2 {
                         UserDefaults.standard.set(ListEditName, forKey: "savedText")
                     }
                 case 3:
                     if UserDefaults.standard.integer(forKey: "Fav") == 3 {
                         UserDefaults.standard.set(ListEditName, forKey: "savedText")
                     }
                 case 4:
                     if UserDefaults.standard.integer(forKey: "Fav") == 4 {
                         UserDefaults.standard.set(ListEditName, forKey: "savedText")
                     }
                 case 5:
                     if UserDefaults.standard.integer(forKey: "Fav") == 5 {
                         UserDefaults.standard.set(ListEditName, forKey: "savedText")
                     }
                 case 6:
                     if UserDefaults.standard.integer(forKey: "Fav") == 6 {
                         UserDefaults.standard.set(ListEditName, forKey: "savedText")
                     }
                 case 7:
                     if UserDefaults.standard.integer(forKey: "Fav") == 7 {
                         UserDefaults.standard.set(ListEditName, forKey: "savedText")
                     }
                 case 8:
                     if UserDefaults.standard.integer(forKey: "Fav") == 8 {
                         UserDefaults.standard.set(ListEditName, forKey: "savedText")
                     }
                 default: break
                 }
                 
              }else{
                  let errorAlert = UIAlertController(title: "Error", message: "Please fill in the field", preferredStyle: .alert)
                  let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                  errorAlert.addAction(okAction)
                  self.present(errorAlert, animated: true, completion: nil)
              }
         }
         let iptalAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
         alertController.addAction(kaydetAction)
         iptalAction.setValue(UIColor.black, forKey: "titleTextColor")
         alertController.addAction(iptalAction)
         self.present(alertController, animated: true)
     }
     
}
extension MyplanViewController: PremiumViewControllerDelegate {
    func premiumDismis() {
        myplanCollectionViewCell.reloadData()
    }
}

