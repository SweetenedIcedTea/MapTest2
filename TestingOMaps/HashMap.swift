//
//  HashMap.swift
//  TestingOMaps
//
//  Created by Ethan Zhang on 11/12/18.
//  Copyright © 2018 NepinNep. All rights reserved.
//

import Foundation

class HashMap<K: Hashable, V>: FakeMap<K, V>{
    var numberCollisions = 0
    var keys: [K?]
    var values: [V?]
    var colMap = LinearMap<K, V>()
    
    init(initialArraySize: Int){
        keys = Array(repeating: nil, count: initialArraySize)
        values = Array(repeating: nil, count: initialArraySize)
    }
    
    override init(){
        keys = Array(repeating: nil, count: 100)
        values = Array(repeating: nil, count: 100)
    }
    
    func findKeyIndex(_ k: K)-> Int{
        return(absVal(k.hashValue % keys.count))
    }
    
    override func getNumberCollisions()-> Int{
        return(numberCollisions)
    }
    
    override func set(_ k: K, v: V){
        if keys[findKeyIndex(k)] == nil{
            keys[findKeyIndex(k)] = Optional(k)
            values[findKeyIndex(k)] = Optional(v)
            count += 1
            return
        }
        if keys[findKeyIndex(k)]! != k{
            if colMap[k] == nil{
                numberCollisions += 1
                count += 1
                colMap[k] = v
                return
            }
            numberCollisions += 1
            colMap[k] = v
            return
        }
        values[findKeyIndex(k)] = Optional(v)
    }
    
    override func remove(_ k: K){
        if keys[findKeyIndex(k)] == nil{
            return
        }
        if keys[findKeyIndex(k)]! != k{
            colMap.remove(k)
            count -= 1
            return
        }
        keys[findKeyIndex(k)] = nil
        values[findKeyIndex(k)] = nil
        count -= 1
    }
    
    override func get(_ k: K)-> V?{
        if keys[findKeyIndex(k)] == nil{
            return(nil)
        }
        if keys[findKeyIndex(k)]! != k{
            numberCollisions += 1
            return(colMap[k])
        }
        return(values[findKeyIndex(k)])
    }
    
    override subscript(index: K) -> V? {
        get {
            return(get(index))
        }
        set(newValue) {
            set(index, v: newValue!)
        }
    }
    
    func absVal(_ x: Int)->Int{
        if x < 0{
            return(x * -1)
        }
        return(x)
    }
    
    var debugPrint: String{
        var result = "Hash Dictionary: \n"
        result += "[ \n"
        for keyValue in 0..<keys.count{
            if keys[keyValue] != nil{
                result += "\(keys[keyValue]!): \(values[keyValue]!)\n"
            }
        }
        result += "]\n"
        result += "Collisions:\n"
        result += "\(colMap)"
        return(result)
    }
    
    override var description: String{
        var desc = "["
        desc += colMap.rawString + ", "
        for n in 0..<keys.count{
            if keys[n] != nil{
                desc += "\(keys[n]!): \(values[n]!), "
            }
        }
        if desc.count != 1{
            desc = String(desc.dropLast(2))
        }
        return desc + "]"
    }
}
