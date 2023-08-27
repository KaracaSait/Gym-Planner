//
//  DetayViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 14.08.2023.
//

import UIKit

class DetayViewController: UIViewController {

    @IBOutlet weak var searchbar: UISearchBar!
    var searchIsContine = false
    var searchWord:String?
    
    var dayList = [Day]()
    var whichBodyPart:bodypart?
    var MovementsList = [Movement]()
    @IBOutlet weak var detayTableView: UITableView!
    @IBOutlet weak var detayLabel: UILabel!
    
    var tapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            view.addGestureRecognizer(tapGesture)
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        self.detayTableView.backgroundColor = UIColor.clear
        
        if whichBodyPart?.body_id == 1{
            MovementsList = shoulderpartdao().veriOkuma() 
            detayLabel.text = "Shoulder"
        }else if whichBodyPart?.body_id == 2 {
            MovementsList = backpartdao().veriOkuma()
            detayLabel.text = "Back"
        }else if whichBodyPart?.body_id == 3 {
            MovementsList = chestpartdao().veriOkuma()
            detayLabel.text = "Chest"
        }else if whichBodyPart?.body_id == 4 {
            MovementsList = tricepspartdao().veriOkuma()
            detayLabel.text = "Triceps"
        }else if whichBodyPart?.body_id == 5 {
            MovementsList = bicepspartdao().veriOkuma()
            detayLabel.text = "Biceps"
        }else if whichBodyPart?.body_id == 6 {
            MovementsList = legpartdao().veriOkuma()
            detayLabel.text = "Leg"
        }else if whichBodyPart?.body_id == 7 {
            MovementsList = abdomenpartdao().veriOkuma()
            detayLabel.text = "Abdomen"
        }
        detayTableView.delegate = self
        detayTableView.dataSource = self
        searchbar.delegate = self
        
    }
    
    @objc func handleTap() {
        view.endEditing(true) 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detayToAddList" {
            if let destinationVC = segue.destination as? AddListViewController {
                if let data = sender as? [String] {
                    destinationVC.GelenVeri = data
                }
            }
        }else if segue.identifier == "detayToMyplan" {
            if let destinationVC = segue.destination as? MyplanViewController {
                destinationVC.delegate = self
            }
        }
    }
    @IBAction func addMoveBarButton(_ sender: Any) {
        searchbar.endEditing(true)
        if whichBodyPart?.body_id == 1{
          alertContShoulder()
      }else if whichBodyPart?.body_id == 2 {
          alertContBack()
      }else if whichBodyPart?.body_id == 3 {
          alertContChest()
      }else if whichBodyPart?.body_id == 4 {
          alertContTriceps()
      }else if whichBodyPart?.body_id == 5 {
          alertContBiceps()
      }else if whichBodyPart?.body_id == 6 {
          alertContLeg()
      }else if whichBodyPart?.body_id == 7 {
          alertContAbdomen()
      }
    }
    
    func showAlertForBodyPart(_ bodyPart: String) {
        let alertController = UIAlertController(title: "Add Movement", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Movement Name"
            textfield.keyboardType = .default
        }
        let kaydetAction = UIAlertAction(title: "Save", style: .destructive) { action in
            if let movementName = alertController.textFields?[0].text, !movementName.isEmpty {
                switch bodyPart {
                case "Shoulder":
                    shoulderpartdao().veriEkle(movement_name: movementName)
                    switch self.searchIsContine {
                    case true: self.MovementsList = shoulderpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = shoulderpartdao().veriOkuma()
                    }
                case "Back":
                    backpartdao().veriEkle(movement_name: movementName)
                    switch self.searchIsContine {
                    case true: self.MovementsList = backpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = backpartdao().veriOkuma()
                    }
                case "Chest":
                    chestpartdao().veriEkle(movement_name: movementName)
                    switch self.searchIsContine {
                    case true: self.MovementsList = chestpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = chestpartdao().veriOkuma()
                    }
                case "Triceps":
                    tricepspartdao().veriEkle(movement_name: movementName)
                    switch self.searchIsContine {
                    case true: self.MovementsList = tricepspartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = tricepspartdao().veriOkuma()
                    }
                case "Biceps":
                    bicepspartdao().veriEkle(movement_name: movementName)
                    switch self.searchIsContine {
                    case true: self.MovementsList = bicepspartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = bicepspartdao().veriOkuma()
                    }
                case "Leg":
                    legpartdao().veriEkle(movement_name: movementName)
                    switch self.searchIsContine {
                    case true: self.MovementsList = legpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = legpartdao().veriOkuma()
                    }
                case "Abdomen":
                    abdomenpartdao().veriEkle(movement_name: movementName)
                    switch self.searchIsContine {
                    case true: self.MovementsList = abdomenpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = abdomenpartdao().veriOkuma()
                    }
                default:
                    break
                }
                self.detayTableView.reloadData()
            } else {
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
    
    func alertContShoulder() {
        showAlertForBodyPart("Shoulder")
    }

    func alertContBack() {
        showAlertForBodyPart("Back")
    }

    func alertContChest() {
        showAlertForBodyPart("Chest")
    }

    func alertContTriceps() {
        showAlertForBodyPart("Triceps")
    }

    func alertContBiceps() {
        showAlertForBodyPart("Biceps")
    }

    func alertContLeg() {
        showAlertForBodyPart("Leg")
    }
    
    func alertContAbdomen() {
        showAlertForBodyPart("Abdomen")
    }

    func noList(){
        let errorAlert = UIAlertController(title: "Error", message: "There is No Usuable List", preferredStyle: .alert) // düzenle karşim
        let okAction = UIAlertAction(title: "Add List", style: .destructive){ action in
            self.performSegue(withIdentifier: "detayToMyplan", sender: nil)
        }
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    func AddListAlert(addMove:String){
        let alertController = UIAlertController(title: "Add to List", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Sets" // kaç set
            textfield.keyboardType = .numberPad // numpad
        }
        alertController.addTextField { textfield in
            textfield.placeholder = "Reps" // kaç tekrar
            textfield.keyboardType = .numberPad // numpad
        }
        let kaydetAction = UIAlertAction(title: "Save", style: .destructive){ action in
             if let set1 = alertController.textFields?[0].text, !set1.isEmpty,
                let set2 = alertController.textFields?[1].text, !set2.isEmpty,
                let inputValue1 = Int(set1),
                (1...99).contains(inputValue1),
                let inputValue2 = Int(set2),
                (1...99).contains(inputValue2) {
                   if UserDefaults.standard.bool(forKey: "premium") == false {
                       if self.dayList.count == 1 {
                           myplandao().veriEkle(movement_name: addMove, set1: set1, set2: set2) // premium hesap yok tek liste var ona eklecek
                       }
                   } else {
                       if self.dayList.count > 1 {
                           self.performSegue(withIdentifier: "detayToAddList", sender: [addMove,set1,set2])
                       }else if self.dayList.count == 1 {
                           myplandao().veriEkle(movement_name: addMove, set1: set1, set2: set2)
                       }
                   }
               }else {
                   let errorAlert = UIAlertController(title: "Error", message: "Please fill in the blanks correctly. Eg(Sets : 4 / Reps : 12)" , preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                   errorAlert.addAction(okAction)
                       self.present(errorAlert, animated: true, completion: nil)
               }
        }
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(kaydetAction)
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dayList = daydao().veriOkuma()
        detayTableView.reloadData()
    }
}

extension DetayViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovementsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = MovementsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "detayHucre", for: indexPath) as! DetayTableViewCell
        cell.detayLabel.text = part.movement_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic) // tıklama efektini kaldırıyo
    }
   
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        self.searchbar.resignFirstResponder()
        let silAction = UIContextualAction(style: .destructive, title: "Delete"){ (contextualAction, view, boolValue) in
                let del = self.MovementsList[indexPath.row].movement_id!
                if self.whichBodyPart?.body_id == 1{
                    shoulderpartdao().veriSil(movement_id: del)
                    switch self.searchIsContine {
                    case true: self.MovementsList = shoulderpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = shoulderpartdao().veriOkuma()
                    }
                }else if self.whichBodyPart?.body_id == 2 {
                    backpartdao().veriSil(movement_id: del)
                    switch self.searchIsContine {
                    case true: self.MovementsList = backpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = backpartdao().veriOkuma()
                    }
                }else if self.whichBodyPart?.body_id == 3 {
                    chestpartdao().veriSil(movement_id: del)
                    switch self.searchIsContine {
                    case true: self.MovementsList = chestpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = chestpartdao().veriOkuma()
                    }
                }else if self.whichBodyPart?.body_id == 4 {
                    tricepspartdao().veriSil(movement_id: del)
                    switch self.searchIsContine {
                    case true: self.MovementsList = tricepspartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = tricepspartdao().veriOkuma()
                    }
                }else if self.whichBodyPart?.body_id == 5 {
                    bicepspartdao().veriSil(movement_id: del)
                    switch self.searchIsContine {
                    case true: self.MovementsList = bicepspartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = bicepspartdao().veriOkuma()
                    }
                }else if self.whichBodyPart?.body_id == 6 {
                    legpartdao().veriSil(movement_id: del)
                    switch self.searchIsContine {
                    case true: self.MovementsList = legpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = legpartdao().veriOkuma()
                    }
                }else if self.whichBodyPart?.body_id == 7 {
                    abdomenpartdao().veriSil(movement_id: del)
                    switch self.searchIsContine {
                    case true: self.MovementsList = abdomenpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = abdomenpartdao().veriOkuma()
                    }
                }
            UIView.transition(with: tableView, duration: 0.3, options: .transitionCrossDissolve, animations: {
                    }, completion: nil) // silme efekti
            self.detayTableView.reloadData()
        }
        let duzenleAction = UIContextualAction(style: .normal, title: "Edit"){ (contextualAction, view, boolValue) in
            let edit = self.MovementsList[indexPath.row].movement_id!
            if self.whichBodyPart?.body_id == 1{
                self.editAlert(bodyPart: "shoulder", edit: edit)
            }else if self.whichBodyPart?.body_id == 2{
                self.editAlert(bodyPart: "back", edit: edit)
            }else if self.whichBodyPart?.body_id == 3{
                self.editAlert(bodyPart: "chest", edit: edit)
            }else if self.whichBodyPart?.body_id == 4{
                self.editAlert(bodyPart: "triceps", edit: edit)
            }else if self.whichBodyPart?.body_id == 5{
                self.editAlert(bodyPart: "biceps", edit: edit)
            }else if self.whichBodyPart?.body_id == 6{
                self.editAlert(bodyPart: "leg", edit: edit)
            }else if self.whichBodyPart?.body_id == 7{
                self.editAlert(bodyPart: "abdomen", edit: edit)
            }
        }
        if let bodyId = whichBodyPart?.body_id,
           let movementId = self.MovementsList[indexPath.row].movement_id {
            var swipeActions: [UIContextualAction] = []
            switch bodyId {
                case 1: swipeActions = movementId > 18 ? [silAction, duzenleAction] : []
                case 2: swipeActions = movementId > 20 ? [silAction, duzenleAction] : []
                case 3: swipeActions = movementId > 22 ? [silAction, duzenleAction] : []
                case 4: swipeActions = movementId > 25 ? [silAction, duzenleAction] : []
                case 5: swipeActions = movementId > 20 ? [silAction, duzenleAction] : []
                case 6: swipeActions = movementId > 18 ? [silAction, duzenleAction] : []
                case 7: swipeActions = movementId > 20 ? [silAction, duzenleAction] : []
                default: break
            }
            return UISwipeActionsConfiguration(actions: swipeActions)
        } else {
            return UISwipeActionsConfiguration(actions: [])
        }
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        self.searchbar.resignFirstResponder()
        let listeyeEkle = UIContextualAction(style: .normal, title: "Add"){ (contextualAction, view, boolValue) in
            let addMove = self.MovementsList[indexPath.row].movement_name!
            if self.dayList.count == 0 {
                self.noList()
            }else{
                self.AddListAlert(addMove: addMove)
            }
            self.detayTableView.isEditing = false
            self.detayTableView.setEditing(false, animated: true) // hücrenin geriye dönmesi için
        }
        return UISwipeActionsConfiguration(actions: [listeyeEkle])
    }
    
    func editAlert(bodyPart: String, edit: Int) {
        let alertController = UIAlertController(title: "Edit Movement", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Movement Name"
            textfield.keyboardType = .default
        }
        let kaydetAction = UIAlertAction(title: "Save", style: .destructive){ action in
            if let movementName = alertController.textFields?[0].text, !movementName.isEmpty {
                switch bodyPart {
                case "shoulder":
                    shoulderpartdao().veriGüncelle(body_name: movementName, body_id: edit)
                    switch self.searchIsContine {
                    case true: self.MovementsList = shoulderpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = shoulderpartdao().veriOkuma()
                    }
                case "back":
                    backpartdao().veriGüncelle(body_name: movementName, body_id: edit)
                    switch self.searchIsContine {
                    case true: self.MovementsList = backpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = backpartdao().veriOkuma()
                    }
                case "chest":
                    chestpartdao().veriGüncelle(body_name: movementName, body_id: edit)
                    switch self.searchIsContine {
                    case true: self.MovementsList = chestpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = chestpartdao().veriOkuma()
                    }
                case "triceps":
                    tricepspartdao().veriGüncelle(body_name: movementName, body_id: edit)
                    switch self.searchIsContine {
                    case true: self.MovementsList = tricepspartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = tricepspartdao().veriOkuma()
                    }
                case "biceps":
                    bicepspartdao().veriGüncelle(body_name: movementName, body_id: edit)
                    switch self.searchIsContine {
                    case true: self.MovementsList = bicepspartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = bicepspartdao().veriOkuma()
                    }
                case "leg":
                    legpartdao().veriGüncelle(body_name: movementName, body_id: edit)
                    switch self.searchIsContine {
                    case true: self.MovementsList = legpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = legpartdao().veriOkuma()
                    }
                case "abdomen":
                    abdomenpartdao().veriGüncelle(body_name: movementName, body_id: edit)
                    switch self.searchIsContine {
                    case true: self.MovementsList = abdomenpartdao().aramaYap(movement_name: self.searchWord!)
                    case false: self.MovementsList = abdomenpartdao().veriOkuma()
                    }
                default:
                    break
                }
                self.detayTableView.reloadData()
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
        self.detayTableView.isEditing = false // hücrenin geriye dönmesi için
        self.detayTableView.setEditing(false, animated: true) // hücrenin geriye dönmesi için
    }
}

extension DetayViewController: MyplanViewControllerDelegate {
    func addListAuto() {
        let alertController = UIAlertController(title: "Add List", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "List Name"
            textfield.keyboardType = .default
        }
        let kaydetAction = UIAlertAction(title: "Save", style: .destructive){ action in
            if let listName = alertController.textFields?[0].text, !listName.isEmpty {
                daydao().veriEkle(day_name: listName)
                self.dayList = daydao().veriOkuma()
                self.navigationController?.popViewController(animated: true)
            }else{
                let errorAlert = UIAlertController(title: "Error", message: "Please fill in the field", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive){ action in
                    self.navigationController?.popViewController(animated: true)
                }
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(kaydetAction)
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
}
extension DetayViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama sonuç : \(searchText)")
        
        searchWord = searchText
        
        if searchText == "" {
            searchIsContine = false
        }else{
            searchIsContine = true
        }
        
        switch whichBodyPart?.body_id {
        case 1: MovementsList = shoulderpartdao().aramaYap(movement_name: searchWord!)
            detayTableView.reloadData()
        case 2: MovementsList = backpartdao().aramaYap(movement_name: searchWord!)
            detayTableView.reloadData()
        case 3: MovementsList = chestpartdao().aramaYap(movement_name: searchWord!)
            detayTableView.reloadData()
        case 4: MovementsList = tricepspartdao().aramaYap(movement_name: searchWord!)
            detayTableView.reloadData()
        case 5: MovementsList = bicepspartdao().aramaYap(movement_name: searchWord!)
            detayTableView.reloadData()
        case 6: MovementsList = legpartdao().aramaYap(movement_name: searchWord!)
            detayTableView.reloadData()
        case 7: MovementsList = abdomenpartdao().aramaYap(movement_name: searchWord!)
            detayTableView.reloadData()
        default: break
        }
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        view.addGestureRecognizer(tapGesture) // Arama çubuğuna tıklandığında tıklama algılansın
        
        self.detayTableView.isEditing = false
        self.detayTableView.setEditing(false, animated: true) // hücrenin geriye dönmesi için
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        view.removeGestureRecognizer(tapGesture) // Arama işlemi bittiğinde tıklama algılansın
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) { // klavyeyi kapatıyo ara ya basınca
        searchbar.resignFirstResponder()
    }
    
}
