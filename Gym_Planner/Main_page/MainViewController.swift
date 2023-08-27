//
//  ViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 14.08.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    var dayList = [Day]()
    var userName:String?
    var body = [bodypart]()
    var plan = [Movement]()
    var selectedCells0: [IndexPath] = []
    var selectedCells1: [IndexPath] = []
    var selectedCells2: [IndexPath] = []
    var selectedCells3: [IndexPath] = []
    var selectedCells4: [IndexPath] = []
    var selectedCells5: [IndexPath] = []
    var selectedCells6: [IndexPath] = []
    var selectedCells7: [IndexPath] = []
    var selectedCells8: [IndexPath] = []
    let calendar = Calendar.current
    let now = Date()
    
    @IBOutlet weak var programLabel: UILabel!
    @IBOutlet weak var labelMain: UILabel!
    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var ProgramTableView: UITableView!
    @IBOutlet weak var BodyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        body = bodypartdao().veriOkuma()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = "" // back button yazısını siliyoz
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        self.ProgramTableView.backgroundColor = UIColor.clear // table view background rengi
        let backgroundImageTableView = UIImage(named: "tableviewprogram") // table view background resmi
        let backgroundViewTableView = UIImageView(image: backgroundImageTableView)
        ProgramTableView.backgroundView = backgroundViewTableView
        
        BodyCollectionView.backgroundColor = UIColor.clear //  arka plan rengi
        
        ProgramTableView.dataSource = self
        ProgramTableView.delegate = self
        BodyCollectionView.dataSource = self
        BodyCollectionView.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mainToDetay" {
        let indeks = sender as? Int
        let gidilecekVC = segue.destination as! DetayViewController
        gidilecekVC.whichBodyPart = body[indeks!]
        }else if segue.identifier == "mainToFavSec" {
            if let favSecViewCont = segue.destination as? FavSecViewController {
                favSecViewCont.delegate = self
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dayList = daydao().veriOkuma()
        clockLabel()
        if let savedText = UserDefaults.standard.string(forKey: "savedText") {
                    programLabel.text = savedText
                }
        
        if UserDefaults.standard.integer(forKey: "Fav") == 0 {
            plan = myplandao().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 1 {
            plan = myplandao1().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 2 {
            plan = myplandao2().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 3 {
            plan = myplandao3().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 4 {
            plan = myplandao4().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 5 {
            plan = myplandao5().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
            plan = myplandao6().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
            plan = myplandao7().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
            plan = myplandao8().veriOkuma()
        }else {
            plan = [Movement]()
        }
        ProgramTableView.reloadData()
        
        let whichMainImage = Int.random(in: 1...4)
        if whichMainImage == 1 {
            imageMain.image = UIImage(named: "getup")
        }else if whichMainImage == 2 {
            imageMain.image = UIImage(named: "ican")
        }else if whichMainImage == 3{
            imageMain.image = UIImage(named: "work")
        }else if whichMainImage == 4 {
            imageMain.image = UIImage(named: "think")
        }
    }
    
    func clockLabel(){
        let startDate = calendar.date(bySettingHour: 6, minute: 0, second: 0, of: now)!
        let midDate = calendar.date(bySettingHour: 11, minute: 0, second: 0, of: now)!
        let mid2Date = calendar.date(bySettingHour: 17, minute: 0, second: 0, of: now)!
        let endDate = calendar.date(bySettingHour: 23, minute: 0, second: 0, of: now)!
        if now >= startDate && now <= midDate {
            if let kaydedilmisVeri = UserDefaults.standard.string(forKey: "KisiAdi") {
                labelMain.text = "Good morning, \(kaydedilmisVeri)!"
            }
        }else if now >= midDate && now <= mid2Date {
            if let kaydedilmisVeri = UserDefaults.standard.string(forKey: "KisiAdi")  {
                    labelMain.text = "Good afternoon, \(kaydedilmisVeri)!"
            }
        }else if now >= mid2Date && now <= endDate {
            if let kaydedilmisVeri = UserDefaults.standard.string(forKey: "KisiAdi")  {
                    labelMain.text = "Good evening, \(kaydedilmisVeri)!"
            }
        }else {
            if let kaydedilmisVeri = UserDefaults.standard.string(forKey: "KisiAdi")  {
                    labelMain.text = "Goodnight, \(kaydedilmisVeri)!"
            }
        }
    }
    
    @IBAction func bodyMeasurementsButton(_ sender: Any) {
        if UserDefaults.standard.bool(forKey: "premium") == false {
            performSegue(withIdentifier: "mainToPremium", sender: nil) // premium hesap iste
        } else {
            performSegue(withIdentifier: "mainToBodyMeasurements", sender: nil)
        }
    }
}

extension MainViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plan.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0.0 // İlk hücrenin yukarıdan görünmez hücreye boşluk miktarı
        }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return UIView() // Boş görünüm boşluk için
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = plan[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "programHucre", for: indexPath) as! ProgramTableViewCell
        cell.missionLabel.text = part.movement_name
        cell.missionLabel.textColor = .white
        cellFor(indexPath: indexPath, cell: cell)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ProgramTableViewCell {
            didSelect(indexPath: indexPath, cell: cell)
               tableView.deselectRow(at: indexPath, animated: true)
           }
        tableView.reloadRows(at: [indexPath], with: .automatic) // tıklama efektini kaldırıyo
    }
    func cellFor(indexPath:IndexPath,cell:ProgramTableViewCell){
        if UserDefaults.standard.integer(forKey: "Fav") == 0 {
            selectCell(cellFor: indexPath, cell: cell, selectedCells: &selectedCells0)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 1 {
            selectCell(cellFor: indexPath, cell: cell, selectedCells: &selectedCells1)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 2 {
            selectCell(cellFor: indexPath, cell: cell, selectedCells: &selectedCells2)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 3 {
            selectCell(cellFor: indexPath, cell: cell, selectedCells: &selectedCells3)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 4 {
            selectCell(cellFor: indexPath, cell: cell, selectedCells: &selectedCells4)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 5 {
            selectCell(cellFor: indexPath, cell: cell, selectedCells: &selectedCells5)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
            selectCell(cellFor: indexPath, cell: cell, selectedCells: &selectedCells6)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
            selectCell(cellFor: indexPath, cell: cell, selectedCells: &selectedCells7)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
            selectCell(cellFor: indexPath, cell: cell, selectedCells: &selectedCells8)
        }
    }
    func didSelect(indexPath:IndexPath,cell:ProgramTableViewCell){
        if UserDefaults.standard.integer(forKey: "Fav") == 0 {
            selectCellDidSelect(indexPath: indexPath, cell: cell, selectedCells: &selectedCells0)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 1 {
            selectCellDidSelect(indexPath: indexPath, cell: cell, selectedCells: &selectedCells1)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 2 {
            selectCellDidSelect(indexPath: indexPath, cell: cell, selectedCells: &selectedCells2)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 3 {
            selectCellDidSelect(indexPath: indexPath, cell: cell, selectedCells: &selectedCells3)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 4 {
            selectCellDidSelect(indexPath: indexPath, cell: cell, selectedCells: &selectedCells4)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 5 {
            selectCellDidSelect(indexPath: indexPath, cell: cell, selectedCells: &selectedCells5)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
            selectCellDidSelect(indexPath: indexPath, cell: cell, selectedCells: &selectedCells6)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
            selectCellDidSelect(indexPath: indexPath, cell: cell, selectedCells: &selectedCells7)
        }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
            selectCellDidSelect(indexPath: indexPath, cell: cell, selectedCells: &selectedCells8)
        }
    }
    func selectCell(cellFor indexPath: IndexPath, cell: ProgramTableViewCell, selectedCells: inout [IndexPath]) {
        if selectedCells.contains(indexPath) {
            cell.checkmarkImageView.image = UIImage(named: "tick_2")
        } else {
            cell.checkmarkImageView.image = UIImage(named: "tick_1")
        }
    }
    func selectCellDidSelect(indexPath: IndexPath, cell: ProgramTableViewCell, selectedCells: inout [IndexPath]) {
        if let index = selectedCells.firstIndex(of: indexPath) {
            cell.checkmarkImageView.image = UIImage(named: "tick_1")
            selectedCells.remove(at: index)
        } else {
            cell.checkmarkImageView.image = UIImage(named: "tick_2")
            selectedCells.append(indexPath)
        }
        if selectedCells.firstIndex(of: indexPath) == plan.count-1 {
            programComplete()
        }
    }
    func programComplete(){
        let alertController = UIAlertController(title: "Are You Completed?", message: "", preferredStyle: .alert)
        let removeAllCells: () -> Void = {
            switch UserDefaults.standard.integer(forKey: "Fav") {
            case 0: self.selectedCells0.removeAll()
            case 1: self.selectedCells1.removeAll()
            case 2: self.selectedCells2.removeAll()
            case 3: self.selectedCells3.removeAll()
            case 4: self.selectedCells4.removeAll()
            case 5: self.selectedCells5.removeAll()
            case 6: self.selectedCells6.removeAll()
            case 7: self.selectedCells7.removeAll()
            case 8: self.selectedCells8.removeAll()
            default: break
            }
            self.ProgramTableView.reloadData()
        }
        let removeLastCells: () -> Void = {
            switch UserDefaults.standard.integer(forKey: "Fav") {
            case 0: self.selectedCells0.remove(at: self.plan.count-1)
            case 1: self.selectedCells1.remove(at: self.plan.count-1)
            case 2: self.selectedCells2.remove(at: self.plan.count-1)
            case 3: self.selectedCells3.remove(at: self.plan.count-1)
            case 4: self.selectedCells4.remove(at: self.plan.count-1)
            case 5: self.selectedCells5.remove(at: self.plan.count-1)
            case 6: self.selectedCells6.remove(at: self.plan.count-1)
            case 7: self.selectedCells7.remove(at: self.plan.count-1)
            case 8: self.selectedCells8.remove(at: self.plan.count-1)
            default: break
            }
            self.ProgramTableView.reloadData()
        }
        let kaydetAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            if UserDefaults.standard.bool(forKey: "premium") == false {
                removeAllCells() // tüm tikleri sil
            } else {
                removeAllCells() // tüm tikleri sil
                if self.dayList.count > 1 {
                    self.performSegue(withIdentifier: "mainToFavSec", sender: nil)
                }
            }
        }
        let iptalAction = UIAlertAction(title: "No", style: .cancel) { action in
            removeLastCells() //print("son tiki sil")
        }
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(kaydetAction)
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return body.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bodyHucre", for: indexPath) as! BodyCollectionViewCell
        cell.hareketLabel.text = body[indexPath.row].body_name
        //cell.bodyPic.image = UIImage(named: "bicepspic")
        cell.bodyPic.image = UIImage(named: body[indexPath.row].body_pic!)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "mainToDetay", sender: indexPath.row)
    }
}

extension MainViewController: FavSecViewControllerDelegate {
    func didDismissFavSecViewControllerWithReloadData() {
        if let savedText = UserDefaults.standard.string(forKey: "savedText") {
                    programLabel.text = savedText
                }
        if UserDefaults.standard.integer(forKey: "Fav") == 0 {
            plan = myplandao().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 1 {
            plan = myplandao1().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 2 {
            plan = myplandao2().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 3 {
            plan = myplandao3().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 4 {
            plan = myplandao4().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 5 {
            plan = myplandao5().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 6 {
            plan = myplandao6().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 7 {
            plan = myplandao7().veriOkuma()
        }else if UserDefaults.standard.integer(forKey: "Fav") == 8 {
            plan = myplandao8().veriOkuma()
        }else {
            plan = [Movement]()
        }
        ProgramTableView.reloadData()
    }
}

