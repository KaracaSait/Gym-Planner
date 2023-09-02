//
//  FirstViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 14.08.2023.
//

import UIKit

class FirstViewController: UIViewController {
    
    let age: [Int] = Array(10...80)
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var agePickerWiew: UIPickerView!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var startButtonImage: UIButton!
    let calendar = Calendar.current
    let now = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let customBackButtonImage = UIImage(named: "backbutton")
        let customBackButtonMaskImage = UIImage(named: "backbutton")
        navigationController?.navigationBar.backIndicatorImage = customBackButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = customBackButtonMaskImage
        navigationController?.navigationBar.tintColor = .black
        
        let backgroundImage = UIImage(named: "background_black")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        label1.textColor = .gray
        label2.textColor = .white
        label3.textColor = .white
        ageLabel.textColor = .white
        
        startButtonImage.tintColor = .black
        startButtonImage.setTitle("Get Started", for: .normal)
        startButtonImage.backgroundColor = .white
        startButtonImage.layer.cornerRadius = startButtonImage.frame.size.width / 5
        
        clockLabelFirstPage()
        
        agePickerWiew.delegate = self
        agePickerWiew.dataSource = self
        agePickerWiew.selectRow(14, inComponent: 0, animated: false) // start age 24
        
        if UserDefaults.standard.bool(forKey: "firstLaunch") {
            performSegue(withIdentifier: "firstToMain", sender: nil) // !firstLaunch
        } else {
            veriTabaniKopyala() // firstLaunch
            UserDefaults.standard.set( 0 , forKey: "Fav")
            UserDefaults.standard.set("Day 1", forKey: "savedText")
            UserDefaults.standard.set("cm", forKey: "uzunluk")
            UserDefaults.standard.set("kg", forKey: "agirlik")
            UserDefaults.standard.set("man", forKey: "sex")
            UserDefaults.standard.set(24, forKey: "age")
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        alertCont()
        UIView.animate(withDuration: 0.5, animations: {
            self.startButtonImage.alpha = 0
        }, completion: nil )
    }
   
    @IBAction func manSelectWoman(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set("man", forKey: "sex")
        }else if sender.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("woman", forKey: "sex")
        }
    }
    
    func veriTabaniKopyala() {
        let bundleYolu = Bundle.main.path(forResource: "gym", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let kopyalanacakYer = URL(filePath: hedefYol).appending(path: "gym.sqlite")
        if fileManager.fileExists(atPath: kopyalanacakYer.path()) {
            print("veri tabanı zaten var.Kopyalamaya gerek yok")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path())
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func alertCont() {
        let alertController = UIAlertController(title: "Your Name", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Your Name"
            textfield.keyboardType = .default
        }
        let kaydetAction = UIAlertAction(title: "Save", style: .destructive){ action in
             if let userName = alertController.textFields?[0].text, !userName.isEmpty {
                     UserDefaults.standard.set(userName, forKey: "KisiAdi")
                 UserDefaults.standard.set(true, forKey: "firstLaunch")
                 self.performSegue(withIdentifier: "firstToMain", sender: nil)
             }else {
                 let errorAlert = UIAlertController(title: "Error", message: "Please fill in the field", preferredStyle: .alert)
                 let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                 errorAlert.addAction(okAction)
                 self.present(errorAlert, animated: true, completion: nil)
                 UIView.animate(withDuration: 0.5, animations: {
                     self.startButtonImage.alpha = 1
                 }, completion: nil )
             }
        }
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            UIView.animate(withDuration: 0.5, animations: {
                self.startButtonImage.alpha = 1
            }, completion: nil )
        }
        alertController.addAction(kaydetAction)
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
    
    func clockLabelFirstPage(){
        let startDate = calendar.date(bySettingHour: 6, minute: 0, second: 0, of: now)!
        let midDate = calendar.date(bySettingHour: 11, minute: 0, second: 0, of: now)!
        let mid2Date = calendar.date(bySettingHour: 17, minute: 0, second: 0, of: now)!
        let endDate = calendar.date(bySettingHour: 23, minute: 0, second: 0, of: now)!
        if now >= startDate && now <= midDate {
                label1.text = "GOOD MORNING"
        }else if now >= midDate && now <= mid2Date {
                label1.text = "GOOD AFTERNOON"
        }else if now >= mid2Date && now <= endDate {
                label1.text = "GOOD EVENING"
        }else {
                label1.text = "GOODNIGHT"
        }
    }
}
extension FirstViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return age.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(age[row])
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(age[row], forKey: "age")
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
           let text = String( age[row] )
           let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
           return attributedString
       }
}
