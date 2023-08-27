//
//  FavSecViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 21.08.2023.
//

import UIKit


protocol FavSecViewControllerDelegate: AnyObject {
    func didDismissFavSecViewControllerWithReloadData()
}

class FavSecViewController: UIViewController {
    
    weak var delegate: FavSecViewControllerDelegate?
    
    @IBOutlet weak var favSecCollectionViewCell: UICollectionView!
    @IBOutlet weak var favSecMainLabel: UILabel!
    
    var dayList = [Day]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        favSecCollectionViewCell.backgroundColor = .clear
        
        let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.favSecCollectionViewCell.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.itemSize = CGSize(width: (genislik - 60) , height: (genislik - 60)  / 1.85 )
        tasarim.minimumInteritemSpacing = 5
        tasarim.minimumLineSpacing = 30
        favSecCollectionViewCell.collectionViewLayout = tasarim
        
        favSecCollectionViewCell.dataSource = self
        favSecCollectionViewCell.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        dayList = daydao().veriOkuma()
        favSecMainLabel.text = "Select Any Favorite"
        favSecCollectionViewCell.reloadData()
    }
}
extension FavSecViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let part = dayList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favSecHucre", for: indexPath) as! FavSecCollectionViewCell
        cell.favSecLabel.text = part.day_name
        cell.favSecLabel.textColor = .white
        cell.favSecImage.image = UIImage(named: "blackcell")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectRow = indexPath.row
        
        if selectRow >= 0 && selectRow < dayList.count {
            UserDefaults.standard.set(selectRow, forKey: "Fav")
            
            if let newText = dayList[indexPath.row].day_name {
                UserDefaults.standard.set(newText, forKey: "savedText")
            }
            
            delegate?.didDismissFavSecViewControllerWithReloadData()
            dismiss(animated: true, completion: nil)
        }
    }
}
