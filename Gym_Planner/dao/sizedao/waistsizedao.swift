//
//  waistsizedao.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 22.08.2023.
//

import Foundation

class waistsizedao {
    
    let db:FMDatabase?
    
    init() {
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veriTabaniUrl = URL(filePath: hedefYol).appending(path: "gym.sqlite")
        db = FMDatabase(path: veriTabaniUrl.path())
    }
    
    func veriEkle(size_size:String,size_unit:String,size_date:String) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO waistsize (size_size,size_unit,size_date) VALUES (?,?,?)", values: [size_size,size_unit,size_date])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func veriOkuma() -> [MeasureSize] {
        var liste = [MeasureSize]()
        db?.open()
        
        do {
            
            let rs = try db!.executeQuery("SELECT * FROM waistsize", values: nil)
            
            while rs.next() {
                let part = MeasureSize(size_id: Int(rs.string(forColumn: "size_id"))!,
                                       size_size: rs.string(forColumn: "size_size")!,
                                       size_unit: rs.string(forColumn: "size_unit")!,
                                       size_date: rs.string(forColumn: "size_date")!)
                liste.append(part)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    
    func veriSil(size_id:Int) {
        
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM waistsize WHERE size_id = ?", values: [size_id])
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    
    func temizle(){
        db?.open()
        
        do {
            
            try db!.executeUpdate("DELETE FROM waistsize ", values:nil)
            
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
}




