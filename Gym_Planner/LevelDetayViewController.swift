//
//  LevelDetayViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 26.08.2023.
//

import UIKit

class LevelDetayViewController: UIViewController {

    var gelenVeri:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)
        //print(gelenVeri!)

        if UserDefaults.standard.string(forKey: "sex") == "man" {
            
            switch gelenVeri {
            case 0: print("beginner sayfası erkek") // listeyi ona göre okut yazdır sayfaya
            case 1: print("orta sayfası erkek")
            case 2: print("woaw sayfası erkek")
            default: break
            }
            
            
        }else if UserDefaults.standard.string(forKey: "sex") == "woman" {
            
            
            switch gelenVeri {
            case 0: print("beginner sayfası kadın")
            case 1: print("orta sayfası kadın")
            case 2: print("woaw sayfası kadın")
            default: break
            }
            
            
        }
            
            
            
    }
    


}
