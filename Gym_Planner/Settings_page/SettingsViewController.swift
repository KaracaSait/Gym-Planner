//
//  SettingsViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 18.08.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingsBackImage: UIImageView!
    @IBOutlet weak var MainLabelSettings: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var premiumLabel: UILabel!
    @IBOutlet weak var userNameChangeButtonImage: UIButton!
    @IBOutlet weak var premiumButtonImage: UIButton!
    @IBOutlet weak var resetButtonImage: UIButton!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var cmToInc: UISegmentedControl!
    @IBOutlet weak var kgToLbs: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        
        //logoImage.image = UIImage(named: "icon_white")
        
        MainLabelSettings.textColor = .white
        userNameLabel.textColor = .white
        premiumLabel.textColor = .white
        versionLabel.textColor = .white
        
        userNameChangeButtonImage.tintColor = .black
        userNameChangeButtonImage.setTitle("Change", for: .normal)
        userNameChangeButtonImage.backgroundColor = .white
        userNameChangeButtonImage.layer.cornerRadius = userNameChangeButtonImage.frame.size.width / 7
        
        premiumButtonImage.tintColor = .black
        premiumButtonImage.setTitle("Get Premium", for: .normal)
        premiumButtonImage.backgroundColor = .white
        premiumButtonImage.layer.cornerRadius = premiumButtonImage.frame.size.width / 7
        
        resetButtonImage.tintColor = .white
        resetButtonImage.setTitle("Reset", for: .normal)
        resetButtonImage.backgroundColor = .red
        resetButtonImage.layer.cornerRadius = resetButtonImage.frame.size.width / 7
        
        if let kaydedilmisVeri = UserDefaults.standard.string(forKey: "KisiAdi") {
            userNameLabel.text = "Your Name :\(kaydedilmisVeri)"
        }
        
        if UserDefaults.standard.bool(forKey: "premium") == false {
            premiumLabel.text = "Your Plan : Free"
        } else {
            premiumLabel.text = "Your Plan : Premium"
            premiumButtonImage.isEnabled = false
        }
        
        settingsBackImage.image = UIImage(named: "settingsbackgroundimage")
        
        if UserDefaults.standard.string(forKey: "uzunluk") == "cm" {
            cmToInc.selectedSegmentIndex = 0
        }else if UserDefaults.standard.string(forKey: "uzunluk") == "inc" {
            cmToInc.selectedSegmentIndex = 1
        }
        if UserDefaults.standard.string(forKey: "agirlik") == "kg" {
            kgToLbs.selectedSegmentIndex = 0
        }else if UserDefaults.standard.string(forKey: "agirlik") == "lbs" {
            kgToLbs.selectedSegmentIndex = 1
        }
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
                versionLabel.text = "v \(version)"
            } else {
                versionLabel.text = "Version information not found"
            }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsToPremium" {
            if let premiumViewCont = segue.destination as? PremiumViewController {
                premiumViewCont.delegate = self
            }
        }
    }
    
    @IBAction func userNameChangeButton(_ sender: Any) {
        changeName()
        UIView.animate(withDuration: 0.5, animations: {
            self.userNameChangeButtonImage.alpha = 0
        }, completion: nil )
    }
    
    @IBAction func resetButton(_ sender: Any) {
        resetAlert()
    }
    @IBAction func premiumButton(_ sender: Any) {
        performSegue(withIdentifier: "settingsToPremium", sender: nil)
    }
    
    @IBAction func cmSelectInc(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set("cm", forKey: "uzunluk")
        }else if sender.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("inc", forKey: "uzunluk")
        }
    }
    
    @IBAction func kgSelectLbs(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            UserDefaults.standard.set("kg", forKey: "agirlik")
        }else if sender.selectedSegmentIndex == 1 {
            UserDefaults.standard.set("lbs", forKey: "agirlik")
        }
    }
    
    func changeName() {
        let alertController = UIAlertController(title: "Your Name", message: "", preferredStyle: .alert)
        alertController.addTextField { textfield in
            textfield.placeholder = "Your Name"
            textfield.keyboardType = .default
        }
        let kaydetAction = UIAlertAction(title: "Save", style: .destructive){ action in
            if let userName = alertController.textFields?[0].text, !userName.isEmpty {
                UserDefaults.standard.set(userName, forKey: "KisiAdi")
                self.userNameLabel.text = "Your Name : \(userName)"
                UIView.animate(withDuration: 0.5, animations: {
                    self.userNameChangeButtonImage.alpha = 1
                }, completion: nil )
            }else{
                let errorAlert = UIAlertController(title: "Error", message: "Please fill in the field", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                errorAlert.addAction(okAction)
                self.present(errorAlert, animated: true, completion: nil)
                UIView.animate(withDuration: 0.5, animations: {
                    self.userNameChangeButtonImage.alpha = 1
                }, completion: nil )
            }
        }
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
            UIView.animate(withDuration: 0.5, animations: {
                self.userNameChangeButtonImage.alpha = 1
            }, completion: nil )
        }
        alertController.addAction(kaydetAction)
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor") // iptal tuşunu siyah yaptık
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
    func resetAlert(){
        let alertController = UIAlertController(title: "Reset", message: "Any changes you have made will be deleted. Are you sure?", preferredStyle: .alert)
        
        let resAction = UIAlertAction(title: "Yes", style: .destructive){ action in
            self.resetIslemler()
            self.performSegue(withIdentifier: "toReset", sender: nil)
        }
        let iptalAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(resAction)
        iptalAction.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(iptalAction)
        self.present(alertController,animated: true)
    }
    func resetIslemler(){
        let keysToKeep = ["premium"]
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            if !keysToKeep.contains(key) {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
        UserDefaults.standard.synchronize() // userDefaults premium hariç sıfırlandı

        bodyweightsizedao().temizle()
        armsizedao().temizle()
        shouldersizedao().temizle()
        chestsizedao().temizle()
        waistsizedao().temizle()
        wristsizedao().temizle()
        legsizedao().temizle()
        hipsizedao().temizle()  // ölçü listeleri sıfırlandı
        
        daydao().temizle()
        daydao().veriEkle(day_name: "Day 1") // plan listeleri sıfırlandı
        
        myplandao().temizle()
        myplandao1().temizle()
        myplandao2().temizle()
        myplandao3().temizle()
        myplandao4().temizle()
        myplandao5().temizle()
        myplandao6().temizle()
        myplandao7().temizle()
        myplandao8().temizle()  // plan listelerinin içi sıfırlandı
        
        shoulderpartdao().temizle()
        backpartdao().temizle()
        chestpartdao().temizle()
        tricepspartdao().temizle()
        bicepspartdao().temizle()
        legpartdao().temizle()
        abdomenpartdao().temizle()
        
    }
}

extension SettingsViewController: PremiumViewControllerDelegate {
    func premiumDismis() {
        premiumLabel.text = "Your Plan : Premium"
        premiumButtonImage.isEnabled = false
    }
}
