//
//  myplanMovedao.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 17.08.2023.
//

import Foundation

class myplanMovedao{
    
let db:FMDatabase?

init() {
    
    let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let veriTabaniUrl = URL(filePath: hedefYol).appending(path: "gym.sqlite")
    db = FMDatabase(path: veriTabaniUrl.path())
}

func veriTasi8to7 (){
    var liste = [tasima]()
    db?.open()
    do {
        try db!.executeUpdate("DELETE FROM myplan7 ", values:nil)
    }catch{
        print(error.localizedDescription)
    }
    do {
        let rs = try db!.executeQuery("SELECT * FROM myplan8", values: nil)
        while rs.next() {
            let part = tasima(movement_name: rs.string(forColumn: "myplan_name")!,set1: rs.string(forColumn: "myplan_set1")!,set2: rs.string(forColumn: "myplan_set2")!)
            liste.append(part)
        }
    }catch{
        print(error.localizedDescription)
    }
    for item in liste {
        do {
            try db!.executeUpdate("INSERT INTO myplan7 (myplan_name,myplan_set1,myplan_set2) VALUES (?,?,?)", values: [item.movement_name!, item.set1!, item.set2!])
        } catch {
            print(error.localizedDescription)
        }
    }
    do {
        try db!.executeUpdate("DELETE FROM myplan8 ", values:nil)
    }catch{
        print(error.localizedDescription)
    }
    db?.close()
}
    func veriTasi7to6 (){
        var liste = [tasima]()
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM myplan6 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        do {
            let rs = try db!.executeQuery("SELECT * FROM myplan7", values: nil)
            while rs.next() {
                let part = tasima(movement_name: rs.string(forColumn: "myplan_name")!,set1: rs.string(forColumn: "myplan_set1")!,set2: rs.string(forColumn: "myplan_set2")!)
                liste.append(part)
            }
        }catch{
            print(error.localizedDescription)
        }
        for item in liste {
            do {
                try db!.executeUpdate("INSERT INTO myplan6 (myplan_name,myplan_set1,myplan_set2) VALUES (?,?,?)", values: [item.movement_name!, item.set1!, item.set2!])
            } catch {
                print(error.localizedDescription)
            }
        }
        do {
            try db!.executeUpdate("DELETE FROM myplan7 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func veriTasi6to5 (){
        var liste = [tasima]()
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM myplan5 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        do {
            let rs = try db!.executeQuery("SELECT * FROM myplan6", values: nil)
            while rs.next() {
                let part = tasima(movement_name: rs.string(forColumn: "myplan_name")!,set1: rs.string(forColumn: "myplan_set1")!,set2: rs.string(forColumn: "myplan_set2")!)
                liste.append(part)
            }
        }catch{
            print(error.localizedDescription)
        }
        for item in liste {
            do {
                try db!.executeUpdate("INSERT INTO myplan5 (myplan_name,myplan_set1,myplan_set2) VALUES (?,?,?)", values: [item.movement_name!, item.set1!, item.set2!])
            } catch {
                print(error.localizedDescription)
            }
        }
        do {
            try db!.executeUpdate("DELETE FROM myplan6 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func veriTasi5to4 (){
        var liste = [tasima]()
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM myplan4 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        do {
            let rs = try db!.executeQuery("SELECT * FROM myplan5", values: nil)
            while rs.next() {
                let part = tasima(movement_name: rs.string(forColumn: "myplan_name")!,set1: rs.string(forColumn: "myplan_set1")!,set2: rs.string(forColumn: "myplan_set2")!)
                liste.append(part)
            }
        }catch{
            print(error.localizedDescription)
        }
        for item in liste {
            do {
                try db!.executeUpdate("INSERT INTO myplan4 (myplan_name,myplan_set1,myplan_set2) VALUES (?,?,?)", values: [item.movement_name!, item.set1!, item.set2!])
            } catch {
                print(error.localizedDescription)
            }
        }
        do {
            try db!.executeUpdate("DELETE FROM myplan5 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func veriTasi4to3 (){
        var liste = [tasima]()
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM myplan3 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        do {
            let rs = try db!.executeQuery("SELECT * FROM myplan4", values: nil)
            while rs.next() {
                let part = tasima(movement_name: rs.string(forColumn: "myplan_name")!,set1: rs.string(forColumn: "myplan_set1")!,set2: rs.string(forColumn: "myplan_set2")!)
                liste.append(part)
            }
        }catch{
            print(error.localizedDescription)
        }
        for item in liste {
            do {
                try db!.executeUpdate("INSERT INTO myplan3 (myplan_name,myplan_set1,myplan_set2) VALUES (?,?,?)", values: [item.movement_name!, item.set1!, item.set2!])
            } catch {
                print(error.localizedDescription)
            }
        }
        do {
            try db!.executeUpdate("DELETE FROM myplan4 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func veriTasi3to2 (){
        var liste = [tasima]()
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM myplan2 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        do {
            let rs = try db!.executeQuery("SELECT * FROM myplan3", values: nil)
            while rs.next() {
                let part = tasima(movement_name: rs.string(forColumn: "myplan_name")!,set1: rs.string(forColumn: "myplan_set1")!,set2: rs.string(forColumn: "myplan_set2")!)
                liste.append(part)
            }
        }catch{
            print(error.localizedDescription)
        }
        for item in liste {
            do {
                try db!.executeUpdate("INSERT INTO myplan2 (myplan_name,myplan_set1,myplan_set2) VALUES (?,?,?)", values: [item.movement_name!, item.set1!, item.set2!])
            } catch {
                print(error.localizedDescription)
            }
        }
        do {
            try db!.executeUpdate("DELETE FROM myplan3 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func veriTasi2to1 (){
        var liste = [tasima]()
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM myplan1 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        do {
            let rs = try db!.executeQuery("SELECT * FROM myplan2", values: nil)
            while rs.next() {
                let part = tasima(movement_name: rs.string(forColumn: "myplan_name")!,set1: rs.string(forColumn: "myplan_set1")!,set2: rs.string(forColumn: "myplan_set2")!)
                liste.append(part)
            }
        }catch{
            print(error.localizedDescription)
        }
        for item in liste {
            do {
                try db!.executeUpdate("INSERT INTO myplan1 (myplan_name,myplan_set1,myplan_set2) VALUES (?,?,?)", values: [item.movement_name!, item.set1!, item.set2!])
            } catch {
                print(error.localizedDescription)
            }
        }
        do {
            try db!.executeUpdate("DELETE FROM myplan2 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
    func veriTasi1to0 (){
        var liste = [tasima]()
        db?.open()
        do {
            try db!.executeUpdate("DELETE FROM myplan ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        do {
            let rs = try db!.executeQuery("SELECT * FROM myplan1", values: nil)
            while rs.next() {
                let part = tasima(movement_name: rs.string(forColumn: "myplan_name")!,set1: rs.string(forColumn: "myplan_set1")!,set2: rs.string(forColumn: "myplan_set2")!)
                liste.append(part)
            }
        }catch{
            print(error.localizedDescription)
        }
        for item in liste {
            do {
                try db!.executeUpdate("INSERT INTO myplan (myplan_name,myplan_set1,myplan_set2) VALUES (?,?,?)", values: [item.movement_name!, item.set1!, item.set2!])
            } catch {
                print(error.localizedDescription)
            }
        }
        do {
            try db!.executeUpdate("DELETE FROM myplan1 ", values:nil)
        }catch{
            print(error.localizedDescription)
        }
        db?.close()
    }
}
