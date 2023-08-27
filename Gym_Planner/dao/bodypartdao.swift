//
//  bodypartdao.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 14.08.2023.
//

import Foundation

class bodypartdao {
    
    let db:FMDatabase?
    
    init() {
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veriTabaniUrl = URL(filePath: hedefYol).appending(path: "gym.sqlite")
        db = FMDatabase(path: veriTabaniUrl.path())
    }
    
    func veriEkle(body_name:String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO bodypart (body_name) VALUES (?)", values: [body_name])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func veriOkuma() -> [bodypart] {
        var liste = [bodypart]()
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM bodypart", values: nil)
            
            while rs.next() {
                let part = bodypart(body_id: Int(rs.string(forColumn: "body_id"))!,
                        body_name: rs.string(forColumn: "body_name")!,
                        body_pic: rs.string(forColumn: "body_pic")!)
                
                liste.append(part)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    
    func veriSil(body_id:Int) {
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM bodypart WHERE body_id = ?", values: [body_id])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
}




