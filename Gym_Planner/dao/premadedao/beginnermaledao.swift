//
//  beginnermale.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 27.08.2023.
//

import Foundation

class beginnermaledao {
    
    let db:FMDatabase?
    
    init() {
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veriTabaniUrl = URL(filePath: hedefYol).appending(path: "gym.sqlite")
        db = FMDatabase(path: veriTabaniUrl.path())
    }
    
    func veriOkumaA() -> [premade] {
        var liste = [premade]()
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM beginnermale WHERE day = 'a'", values: nil)
            
            while rs.next() {
                let part = premade(id: Int(rs.string(forColumn: "id"))!, movement: rs.string(forColumn: "movement")!, sets: rs.string(forColumn: "sets")!, reps: rs.string(forColumn: "reps")!, day: rs.string(forColumn: "day")!)
                liste.append(part)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    func veriOkumaB() -> [premade] {
        var liste = [premade]()
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM beginnermale WHERE day = 'b'", values: nil)
            
            while rs.next() {
                let part = premade(id: Int(rs.string(forColumn: "id"))!, movement: rs.string(forColumn: "movement")!, sets: rs.string(forColumn: "sets")!, reps: rs.string(forColumn: "reps")!, day: rs.string(forColumn: "day")!)

                liste.append(part)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
}




