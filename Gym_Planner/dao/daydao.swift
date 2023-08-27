//
//  daydao.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 16.08.2023.
//

import Foundation

class daydao {
    
    let db:FMDatabase?
    
    init() {
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veriTabaniUrl = URL(filePath: hedefYol).appending(path: "gym.sqlite")
        db = FMDatabase(path: veriTabaniUrl.path())
    }
    
    func veriEkle(day_name:String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO day (day_name) VALUES (?)", values: [day_name] )
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func veriOkuma() -> [Day] {
        var liste = [Day]()
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM day", values: nil)
            
            while rs.next() {
                let part = Day(day_id: Int(rs.string(forColumn: "day_id"))!,day_name: rs.string(forColumn: "day_name")!)
                
                liste.append(part)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
  
    func veriSil(day_id:Int) {
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM day WHERE day_id = ?", values: [day_id])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func temizle(){
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM day ", values:nil)
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func veriGüncelle(day_name:String,day_id:Int) {
        db?.open()
        
        do {
            
            try db!.executeUpdate("UPDATE day SET day_name = ? WHERE day_id = ?", values: [day_name,day_id])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
}
