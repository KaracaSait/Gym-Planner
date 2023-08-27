//
//  chestdao.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 14.08.2023.
//

import Foundation

class chestpartdao {
    
    let db:FMDatabase?
    
    init() {
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veriTabaniUrl = URL(filePath: hedefYol).appending(path: "gym.sqlite")
        db = FMDatabase(path: veriTabaniUrl.path())
    }
    
    func veriEkle(movement_name:String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO chest (chest_movement) VALUES (?)", values: [movement_name])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func veriOkuma() -> [Movement] {
        var liste = [Movement]()
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM chest", values: nil)
            
            while rs.next() {
                let part = Movement(movement_id: Int(rs.string(forColumn: "chest_id"))!, movement_name: rs.string(forColumn: "chest_movement")!)
                
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
            
            try db!.executeUpdate("DELETE FROM chest WHERE chest_id = ?", values: [movement_id])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func veriGüncelle(body_name:String,body_id:Int) {
        db?.open()
        
        do {
            
            try db!.executeUpdate("UPDATE chest SET chest_movement = ? WHERE chest_id = ?", values: [body_name,body_id])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func temizle(){
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM chest WHERE chest_id > 22 ", values:nil)
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    
    func aramaYap(movement_name:String) -> [Movement] {
        var liste = [Movement]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM chest WHERE chest_movement like '%\(movement_name)%'", values: nil)
            
            while rs.next() {
                let movement = Movement(movement_id: Int(rs.string(forColumn: "chest_id"))!, movement_name: rs.string(forColumn: "chest_movement")!)
                liste.append(movement)
            }
            
            
        } catch  {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }

}


