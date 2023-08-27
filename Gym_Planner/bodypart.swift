//
//  bodypart.swift
//  Gym_Planner
//
//  Created by Sait KARACA on 14.08.2023.
//

import Foundation

class bodypart {
    var body_id:Int?
    var body_name:String?
    var body_pic:String?
    
    init() {

    }
    
    init(body_id:Int, body_name:String, body_pic:String) {
        self.body_id = body_id
        self.body_name = body_name
        self.body_pic = body_pic
    }
}

class Movement {
    var movement_id:Int?
    var movement_name:String?
    
    init() {

    }
    
    init(movement_id:Int, movement_name:String) {
        self.movement_id = movement_id
        self.movement_name = movement_name
    }
}

class Plan {
    var movement_id:Int?
    var movement_name:String?
    var set1:String?
    var set2:String?
    
    init() {

    }
    
    init(movement_id:Int, movement_name:String, set1:String, set2:String) {
        self.movement_id = movement_id
        self.movement_name = movement_name
        self.set1 = set1
        self.set2 = set2
    }
}

class Day {
    var day_id:Int?
    var day_name:String?
    
    init() {

    }
    
    init(day_id:Int,day_name:String) {
        self.day_id = day_id
        self.day_name = day_name
    }
}

class tasima {
    var movement_name:String?
    var set1:String?
    var set2:String?
    
    init() {

    }
    
    init(movement_name:String, set1:String, set2:String) {
        self.movement_name = movement_name
        self.set1 = set1
        self.set2 = set2
    }
}

class measure {
    var name:String?
    
    init() {

    }
    
    init(name:String) {
        self.name = name
    }
}

class MeasureSize {
    var size_id:Int?
    var size_size:String?
    var size_unit:String?
    var size_date:String?
    
    init() {

    }
    
    init(size_id:Int, size_size:String, size_unit:String, size_date:String) {
        self.size_id = size_id
        self.size_size = size_size
        self.size_unit = size_unit
        self.size_date = size_date
    }
}

class premium {
    var feature:String?
    
    init() {
    
    }
    
    init (feature:String){
        self.feature = feature
    }
}


class bodyBuildLevel {
    var level:String?
    var duration:String?
    var dpw:String?
    var type:String?
    var tpw:String?
    var goal:String?
    
    
    init() {
    
    }
    
    init (level:String,duration:String,dpw:String,type:String,tpw:String,goal:String){
        self.level = level
        self.duration = duration
        self.dpw = dpw
        self.type = type
        self.tpw = tpw
        self.goal = goal
    }
}
