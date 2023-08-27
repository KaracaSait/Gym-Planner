//
//  LevelDetayViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 26.08.2023.
//

import UIKit

class LevelDetayViewController: UIViewController {

    var gelenVeri:Int?
    var day = [level]()
    
    @IBOutlet weak var LevelCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        LevelCollectionView.backgroundColor = .clear
        
        let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.LevelCollectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.itemSize = CGSize(width: (genislik - 60) , height: (genislik - 60)  / 1.85 )
        tasarim.minimumInteritemSpacing = 5
        tasarim.minimumLineSpacing = 30
        LevelCollectionView.collectionViewLayout = tasarim
        
        LevelCollectionView.dataSource = self
        LevelCollectionView.delegate = self

        if UserDefaults.standard.string(forKey: "sex") == "man" {
            
            switch gelenVeri {
            case 0:
                let a1 = level(days: "Monday")
                let a2 = level(days: "Wednesday")
                let a3 = level(days: "Friday")
                
                day.append(a1)
                day.append(a2)
                day.append(a3)
                
                UserDefaults.standard.set("beginnerMale", forKey: "level")
                
            case 1:
                let a1 = level(days: "Monday")
                let a2 = level(days: "Tuesday")
                let a3 = level(days: "Thursday")
                let a4 = level(days: "Friday")
                
                day.append(a1)
                day.append(a2)
                day.append(a3)
                day.append(a4)
                
                UserDefaults.standard.set("IntermediateMale", forKey: "level")
                
            case 2:
                let a1 = level(days: "Monday")
                let a2 = level(days: "Tuesday")
                let a3 = level(days: "Thursday")
                let a4 = level(days: "Friday")
                
                day.append(a1)
                day.append(a2)
                day.append(a3)
                day.append(a4)
                
                UserDefaults.standard.set("AdvancedMale", forKey: "level")
                
            default: break
            }
        }else if UserDefaults.standard.string(forKey: "sex") == "woman" {
            
            switch gelenVeri {
            case 0:
                let a1 = level(days: "Monday")
                let a2 = level(days: "Tuesday")
                let a3 = level(days: "Wednesday")
                let a4 = level(days: "Thursday")
                let a5 = level(days: "Friday")
                
                day.append(a1)
                day.append(a2)
                day.append(a3)
                day.append(a4)
                day.append(a5)
                
                UserDefaults.standard.set("beginnerFemale", forKey: "level")
                
            case 1: print("orta sayfası kadın")
                let a1 = level(days: "Monday")
                let a2 = level(days: "Tuesday")
                let a3 = level(days: "Thursday")
                let a4 = level(days: "Friday")
                
                day.append(a1)
                day.append(a2)
                day.append(a3)
                day.append(a4)
                
                UserDefaults.standard.set("IntermediateFemale", forKey: "level")
                
            default: break
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPremade" {
            if let destinationVC = segue.destination as? PremadeViewController {
                if let data = sender as? Int {
                    destinationVC.data = data
                }
            }
        }
    }
}

extension LevelDetayViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return day.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let part = day[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "levelHucre", for: indexPath) as! LevelDetayCollectionViewCell
        cell.label.text = part.days
        cell.label.textColor = .white
        cell.image.image = UIImage(named: "blackcell")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPremade", sender: indexPath.row)
    }
}
