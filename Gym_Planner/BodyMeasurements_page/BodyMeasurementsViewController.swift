//
//  BodyMeasurementsViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 18.08.2023.
//

import UIKit

class BodyMeasurementsViewController: UIViewController {
    
    @IBOutlet weak var bodyMeasurementsTableView: UITableView!
    @IBOutlet weak var bodyMass: UIButton!
    @IBOutlet weak var bodyFat: UIButton!
    
    var a:Double?
    var b:Double?
    
    var measureListe = [measure]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        bodyMass.tintColor = .white
        bodyMass.setTitle("Body Mass Index", for: .normal)
        bodyMass.backgroundColor = .black
        bodyMass.layer.cornerRadius = bodyMass.frame.size.width / 15
        
        bodyFat.tintColor = .white
        bodyFat.setTitle("Body Fat Percentage", for: .normal)
        bodyFat.backgroundColor = .black
        bodyFat.layer.cornerRadius = bodyFat.frame.size.width / 15
        
        bodyMeasurementsTableView.backgroundColor = UIColor.clear // table view background rengi
        
        bodyMeasurementsTableView.delegate = self
        bodyMeasurementsTableView.dataSource = self
        
        let m0 = measure(name: "Body Weight")
        let m1 = measure(name: "Arm Size")
        let m2 = measure(name: "Shoulder Size")
        let m3 = measure(name: "Chest Size")
        let m4 = measure(name: "Waist Size") 
        let m5 = measure(name: "Wrist Size")
        let m6 = measure(name: "Leg Size")
        let m7 = measure(name: "Hip Size")
        measureListe.append(m0)
        measureListe.append(m1)
        measureListe.append(m2)
        measureListe.append(m3)
        measureListe.append(m4)
        measureListe.append(m5)
        measureListe.append(m6)
        if UserDefaults.standard.string(forKey: "sex") == "woman" {
            measureListe.append(m7)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "measureToMeasureList" {
            if let destinationVC = segue.destination as? MeasureListViewController {
                if let data = sender as? Int {
                    destinationVC.measureRow = data
                }
            }
        }
    }
    
    @IBAction func bodyMassButton(_ sender: Any) {
        bodyMassAlert()
    }
    
    @IBAction func bodyFatButton(_ sender: Any) {
        bodyFatAlert()
    }
    func bodyFatAlert(){
        let errorAlert = UIAlertController(title: "Body Fat Percentage", message: "Will be added to the program soon", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func bodyMassAlert(){
        let alertController = UIAlertController(title: "Body Mass Index", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            if UserDefaults.standard.string(forKey: "agirlik") == "kg" {
                textfield.placeholder = "Weight -- Kg"
                textfield.keyboardType = .numberPad
            }else if UserDefaults.standard.string(forKey: "agirlik") == "lbs" {
                textfield.placeholder = "Weight  -- Lbs"
                textfield.keyboardType = .numberPad
            }
        }
        alertController.addTextField { textfield in
            if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                textfield.placeholder = "Height -- Cm"
                textfield.keyboardType = .numberPad
            }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                textfield.placeholder = "Height -- Inch"
                textfield.keyboardType = .numberPad
            }
        }
        let kaydetAction = UIAlertAction(title: "Calculate", style: .destructive){ action in
            if let weight = alertController.textFields?[0].text, !weight.isEmpty,
               let height = alertController.textFields?[1].text, !height.isEmpty {
                if UserDefaults.standard.string(forKey: "agirlik") == "kg" {
                    self.a = Double(weight)
                }else if UserDefaults.standard.string(forKey: "agirlik") == "lbs" {
                    self.a = Double(weight)! * 0.45359237
                }
                if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                    self.b = Double(height)
                }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                    self.b = Double(height)! * 2.54
                }
                let metre = self.b! / 100
                let bmi = self.a! / (metre * metre)
                if bmi <= 18.5 {
                    self.InfoAlert(info:"Under ideal weight")
                }else if 18.5 < bmi && bmi <= 24.9 {
                    self.InfoAlert(info: "At ideal weight")
                }else if 24.9 < bmi && bmi <= 29.9 {
                    self.InfoAlert(info: "Above ideal weight")
                }else if 29.9 < bmi && bmi <= 39.9 {
                    self.InfoAlert(info: "Excessively above ideal weight (Obese)")
                }else if 39.9 < bmi {
                    self.InfoAlert(info: "Well above the ideal weight (Morbid obese)")
                }
            }else {
                let errorAlert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
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
    func InfoAlert(info:String){
        let errorAlert = UIAlertController(title: "Info", message: info , preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
}

extension BodyMeasurementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return measureListe.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = measureListe[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "bodyMeasureHucre", for: indexPath) as! BodyMeasurementsTableViewCell
        cell.measurementsLabel.text = part.name
        cell.addDataButtonTappedHandler = {
            self.addDataAlert(indexPath: indexPath)
            }
        cell.actionButtonTappedHandler = {
            self.performSegue(withIdentifier: "measureToMeasureList", sender: indexPath.item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .automatic) // tıklama efektini kaldırıyo
    }
    
    func addDataAlert(indexPath:IndexPath){
        let alertController = UIAlertController(title: "Value", message: "Please enter the values you want to add to the list.", preferredStyle: .alert)
        alertController.addTextField { textfield in
            
            if indexPath.row == 0 {
                if UserDefaults.standard.string(forKey: "agirlik") == "kg" {
                    textfield.placeholder = "Weight -- Kg"
                }else if UserDefaults.standard.string(forKey: "agirlik") == "lbs" {
                    textfield.placeholder = "Weight -- Lbs"
                }
            }else{
                if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                    textfield.placeholder = "Size -- Cm"
                }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                    textfield.placeholder = "Size -- Inch"
                }
            }
            textfield.keyboardType = .numberPad
        }
        let kaydetAction = UIAlertAction(title: "Save", style: .destructive){ action in
            if let size = alertController.textFields?[0].text, !size.isEmpty,
            let inputValue1 = Int(size),
            (1...999).contains(inputValue1) {
            let yil = Calendar.current.component(.year, from: Date())
            let ay = Calendar.current.component(.month, from: Date())
            let gun = Calendar.current.component(.day, from: Date())
            let tarih = "\(gun)/\(ay)/\(yil)"
                if indexPath.row == 0{
                    if UserDefaults.standard.string(forKey: "agirlik") == "kg" {
                        bodyweightsizedao().veriEkle(size_size: size, size_unit: "Kg", size_date: tarih)
                    }else if UserDefaults.standard.string(forKey: "agirlik") == "lbs" {
                        bodyweightsizedao().veriEkle(size_size: size, size_unit: "Lbs", size_date: tarih)
                    }
                }else if indexPath.row == 1 {
                    if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                        armsizedao().veriEkle(size_size: size, size_unit: "Cm", size_date: tarih)
                    }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                        armsizedao().veriEkle(size_size: size, size_unit: "Inc", size_date: tarih)
                    }
                }else if indexPath.row == 2 {
                    if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                        shouldersizedao().veriEkle(size_size: size, size_unit: "Cm", size_date: tarih)
                    }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                        shouldersizedao().veriEkle(size_size: size, size_unit: "Inc", size_date: tarih)
                    }
                }else if indexPath.row == 3 {
                    if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                        chestsizedao().veriEkle(size_size: size, size_unit: "Cm", size_date: tarih)
                    }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                        chestsizedao().veriEkle(size_size: size, size_unit: "Inc", size_date: tarih)
                    }
                }else if indexPath.row == 4 {
                    if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                        waistsizedao().veriEkle(size_size: size, size_unit: "Cm", size_date: tarih)
                    }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                        waistsizedao().veriEkle(size_size: size, size_unit: "Inc", size_date: tarih)
                    }
                }else if indexPath.row == 5 {
                    if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                        wristsizedao().veriEkle(size_size: size, size_unit: "Cm", size_date: tarih)
                    }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                        wristsizedao().veriEkle(size_size: size, size_unit: "Inc", size_date: tarih)
                    }
                }else if indexPath.row == 6 {
                    if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                        legsizedao().veriEkle(size_size: size, size_unit: "Cm", size_date: tarih)
                    }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                        legsizedao().veriEkle(size_size: size, size_unit: "Inc", size_date: tarih)
                    }
                }else if indexPath.row == 7 {
                    if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                        hipsizedao().veriEkle(size_size: size, size_unit: "Cm", size_date: tarih)
                    }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                        hipsizedao().veriEkle(size_size: size, size_unit: "Inc", size_date: tarih)
                    }
                }
            }else {
                let errorAlert = UIAlertController(title: "Error", message: "Please fill in the blanks correctly.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true, completion: nil)
            }
        }
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(kaydetAction)
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor") // iptal tuşunu siyah yaptık
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
}
