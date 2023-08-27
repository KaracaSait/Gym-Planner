//
//  AddListViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 19.08.2023.
//

import UIKit

class AddListViewController: UIViewController {
    
    @IBOutlet weak var addListLabel: UILabel!
    @IBOutlet weak var addListCollectionView: UICollectionView!
    var GelenVeri: [String]?
    var dayList = [Day]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        addListCollectionView.backgroundColor = .clear
        
        let tasarim:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let genislik = self.addListCollectionView.frame.size.width
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        tasarim.itemSize = CGSize(width: (genislik - 60) , height: (genislik - 60)  / 1.85 )
        tasarim.minimumInteritemSpacing = 5
        tasarim.minimumLineSpacing = 30
        addListCollectionView.collectionViewLayout = tasarim
        
        addListCollectionView.dataSource = self
        addListCollectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dayList = daydao().veriOkuma()
        addListLabel.text = "Select List" 
        addListCollectionView.reloadData()
    }
}
extension AddListViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let part = dayList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "addListHucre", for: indexPath) as! AddListCollectionViewCell
        cell.cellLabel.text = part.day_name
        cell.cellLabel.textColor = .white
        cell.cellimage.image = UIImage(named: "blackcell")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectRow = indexPath.row
        if selectRow == 0 {
            myplandao().veriEkle(movement_name: GelenVeri![0], set1: GelenVeri![1], set2: GelenVeri![2])
            dismiss(animated: true, completion: nil)
        }else if selectRow == 1 {
            myplandao1().veriEkle(movement_name: GelenVeri![0], set1: GelenVeri![1], set2: GelenVeri![2])
            dismiss(animated: true, completion: nil)
        }else if selectRow == 2 {
            myplandao2().veriEkle(movement_name: GelenVeri![0], set1: GelenVeri![1], set2: GelenVeri![2])
            dismiss(animated: true, completion: nil)
        }else if selectRow == 3 {
            myplandao3().veriEkle(movement_name: GelenVeri![0], set1: GelenVeri![1], set2: GelenVeri![2])
            dismiss(animated: true, completion: nil)
        }else if selectRow == 4 {
            myplandao4().veriEkle(movement_name: GelenVeri![0], set1: GelenVeri![1], set2: GelenVeri![2])
            dismiss(animated: true, completion: nil)
        }else if selectRow == 5 {
            myplandao5().veriEkle(movement_name: GelenVeri![0], set1: GelenVeri![1], set2: GelenVeri![2])
            dismiss(animated: true, completion: nil)
        }else if selectRow == 6 {
            myplandao6().veriEkle(movement_name: GelenVeri![0], set1: GelenVeri![1], set2: GelenVeri![2])
            dismiss(animated: true, completion: nil)
        }else if selectRow == 7 {
            myplandao7().veriEkle(movement_name: GelenVeri![0], set1: GelenVeri![1], set2: GelenVeri![2])
            dismiss(animated: true, completion: nil)
        }else if selectRow == 8 {
            myplandao8().veriEkle(movement_name: GelenVeri![0], set1: GelenVeri![1], set2: GelenVeri![2])
            dismiss(animated: true, completion: nil)
        }
    }
}
