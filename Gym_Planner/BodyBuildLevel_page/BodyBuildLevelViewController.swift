//
//  BodyBuildLevelViewController.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 26.08.2023.
//

import UIKit

class BodyBuildLevelViewController: UIViewController {

    @IBOutlet weak var BodyBuildLevelTableView: UITableView!
    
    var listBodyLevel = [bodyBuildLevel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.frame = self.view.bounds
        backgroundImageView.contentMode = .scaleAspectFill
        self.view.insertSubview(backgroundImageView, at: 0)

        
        if UserDefaults.standard.string(forKey: "sex") == "man" {
            let a1 = bodyBuildLevel(level: "Beginner", duration: "12 Weeks", dpw: "3 Days", type: "Full Body", tpw: "90 Minutes", goal: "Increase Strength")
            let a2 = bodyBuildLevel(level: "Intermediate", duration: "9 Weeks", dpw: "4 Days", type: "Split", tpw: "60 Minutes", goal: "Strength") // bunu düzenle
            let a3 = bodyBuildLevel(level: "Advanced", duration: "10 Weeks", dpw: "4 Days", type: "Split", tpw: "50 Minutes", goal: "Build Muscle")
            
            listBodyLevel.append(a1)
            listBodyLevel.append(a2)
            listBodyLevel.append(a3)
        }else if UserDefaults.standard.string(forKey: "sex") == "woman" {
            let a1 = bodyBuildLevel(level: "Beginner", duration: "12 Weeks", dpw: "5 Days", type: "Split", tpw: "45-60 minutes", goal: "Lose Fat")
            let a2 = bodyBuildLevel(level: "Intermediate", duration: "12 Weeks", dpw: "6 Days", type: "Split", tpw: "45-75 minutes", goal: "Build Muscle")
            let a3 = bodyBuildLevel(level: "Intermediate", duration: "12 Weeks", dpw: "4 Days", type: "Split", tpw: "45-60 minutes", goal: "Lose Fat")
            
            listBodyLevel.append(a1)
            listBodyLevel.append(a2)
            listBodyLevel.append(a3)
        }
        
       
        
        BodyBuildLevelTableView.dataSource = self
        BodyBuildLevelTableView.delegate = self
    }
    

}
extension BodyBuildLevelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBodyLevel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let part = listBodyLevel[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "bodyBuildLevelHucre", for: indexPath) as! BodyBuildLevelTableViewCell
        cell.levelLabel.text = part.level
        cell.durationLabel.text = part.duration
        cell.daysPerWeekLabel.text = part.dpw
        cell.workoutTypeLabel.text = part.type
        cell.timePerWorkoutLabel.text = part.tpw
        cell.mainGoalLabel.text = part.goal
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let part = listBodyLevel[indexPath.row]
        //print(indexPath.row)
        performSegue(withIdentifier: "bodyLevelToDetay", sender: indexPath.row)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bodyLevelToDetay" {
            if let destinationVC = segue.destination as? LevelDetayViewController {
                if let data = sender as? Int {
                    destinationVC.gelenVeri = data
                }
            }
        }
    }
}
