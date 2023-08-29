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
    
    var bmiWeight:Double?
    var bmiHeight:Double?
    
    var bfpHeight:Double?
    var bfpNeck:Double?
    var bfpWaist:Double?
    var bfpHip:Double?
    
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
        
        bodyMeasurementsTableView.backgroundColor = UIColor.clear
        
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
        
        let alertController = UIAlertController(title: "Body Fat Percentage", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                textfield.placeholder = "Height -- Cm"
                textfield.keyboardType = .numberPad
            }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                textfield.placeholder = "Height -- Inch"
                textfield.keyboardType = .numberPad
            }
        }
        alertController.addTextField { textfield in
            if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                textfield.placeholder = "Neck Circumference -- Cm"
                textfield.keyboardType = .numberPad
            }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                textfield.placeholder = "Neck Circumference -- Inch"
                textfield.keyboardType = .numberPad
            }
        }
        
        alertController.addTextField { textfield in
            if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                textfield.placeholder = "Waist Circumference -- Cm"
                textfield.keyboardType = .numberPad
            }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                textfield.placeholder = "Waist Circumference -- Inch"
                textfield.keyboardType = .numberPad
            }
        }
        
        if UserDefaults.standard.string(forKey: "sex") == "woman" {
            
            alertController.addTextField { textfield in
                if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                    textfield.placeholder = "Hip Circumference -- Cm"
                    textfield.keyboardType = .numberPad
                }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                    textfield.placeholder = "Hip Circumference -- Inch"
                    textfield.keyboardType = .numberPad
                }
            }
            
        }
        let kaydetAction = UIAlertAction(title: "Calculate", style: .destructive){ action in
            if let Height = alertController.textFields?[0].text, !Height.isEmpty,
               let Neck = alertController.textFields?[1].text, !Neck.isEmpty,
               let Waist = alertController.textFields?[2].text, !Waist.isEmpty {
                if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                    self.bfpHeight = Double(Height)
                    self.bfpNeck = Double(Neck)
                    self.bfpWaist = Double(Waist)
                }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                    self.bfpHeight = Double(Height)! * 2.54
                    self.bfpNeck = Double(Neck)! * 2.54
                    self.bfpWaist = Double(Waist)! * 2.54
                }
                if UserDefaults.standard.string(forKey: "sex") == "woman" {
                    if let Hip = alertController.textFields?[3].text, !Hip.isEmpty {
                        if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                            self.bfpHip = Double(Hip)
                        }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                            self.bfpHip = Double(Hip)! * 2.54
                        }
                        let formul = 495 / (1.29579 - 0.35004 * log10(self.bfpWaist! + self.bfpHip! - self.bfpNeck!) + 0.22100 * log10(self.bfpHeight!)) - 450
                        if formul <= 14 {
                            self.InfoAlert(info: "The body has a very low body fat percentage.")
                        }else if 14 < formul && formul <= 20{
                            self.InfoAlert(info: "The body has an ideal body fat percentage for an athlete.")
                        }else if 20 < formul && formul <= 24 {
                            self.InfoAlert(info: "The body has an ideal body fat percentage for a fitness enthusiast.")
                        }else if 24 < formul && formul <= 32 {
                            self.InfoAlert(info: "The body has an ideal body fat percentage.")
                        }else{
                            self.InfoAlert(info: "The body has a very high body fat percentage.")
                        }
                    }else {
                        let errorAlert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                        errorAlert.addAction(okAction)
                        self.present(errorAlert, animated: true, completion: nil)
                    }
                }
                if UserDefaults.standard.string(forKey: "sex") == "man" {
                    let formul = 495 / (1.0324 - 0.19077 * log10(self.bfpWaist! - self.bfpNeck!) + 0.15456 *  log10(self.bfpHeight!)) - 450
                        if formul <= 6 {
                            self.InfoAlert(info: "The body has a very low body fat percentage.")
                        }else if 6 < formul && formul <= 13 {
                            self.InfoAlert(info: "The body has an ideal body fat percentage for an athlete.")
                        }else if 13 < formul && formul <= 17 {
                            self.InfoAlert(info: "The body has an ideal body fat percentage for a fitness enthusiast.")
                        }else if 17 < formul && formul <= 24 {
                            self.InfoAlert(info: "The body has an ideal body fat percentage.")
                        }else{
                            self.InfoAlert(info: "The body has a very high body fat percentage.")
                        }
                }
            } else {
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
                    self.bmiWeight = Double(weight)
                }else if UserDefaults.standard.string(forKey: "agirlik") == "lbs" {
                    self.bmiWeight = Double(weight)! * 0.45359237
                }
                if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
                    self.bmiHeight = Double(height)
                }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
                    self.bmiHeight = Double(height)! * 2.54
                }
                let metre = self.bmiHeight! / 100
                let bmi = self.bmiWeight! / (metre * metre)
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
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor") 
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
}
