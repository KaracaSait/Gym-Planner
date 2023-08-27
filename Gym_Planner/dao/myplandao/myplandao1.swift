//
//  myplandao1.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 16.08.2023.
//

import Foundation

class myplandao1 {
    
    let db:FMDatabase?
    
    init() {
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veriTabaniUrl = URL(filePath: hedefYol).appending(path: "gym.sqlite")
        db = FMDatabase(path: veriTabaniUrl.path())
    }
    
    func veriEkle(movement_name:String,set1:String,set2:String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO myplan1 (myplan_name,myplan_set1,myplan_set2) VALUES (?,?,?)", values: [movement_name,set1,set2])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func veriOkuma() -> [Movement] {
        var liste = [Movement]()
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM myplan1", values: nil)
            
            while rs.next() {
                let part = Movement(movement_id: Int(rs.string(forColumn: "myplan_id"))!, movement_name: rs.string(forColumn: "myplan_name")!)
                
                liste.append(part)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    
    func veriOkumaDetay() -> [Plan] {
        var liste = [Plan]()
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM myplan1", values: nil)
            
            while rs.next() {
                let part = Plan(movement_id: Int(rs.string(forColumn: "myplan_id"))!, movement_name: rs.string(forColumn: "myplan_name")!,set1: rs.string(forColumn: "myplan_set1")!,set2: rs.string(forColumn: "myplan_set2")!)
                
                liste.append(part)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    
    func veriSil(movement_id:Int) {
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM myplan1 WHERE myplan_id = ?", values: [movement_id])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func temizle(){
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM myplan1 ", values:nil)
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
}
