//
//  LinearMap.swift
//  TestingOMaps
//
//  Created by Ethan Zhang on 11/12/18.
//  Copyright © 2018 NepinNep. All rights reserved.
//

import Foundation

class LinearMap<K: Hashable, V>: FakeMap<K, V>{
    var keys = [K]()
    var values = [V]()
    
    func findKeyIndex(_ k: K)-> Int?{
        var result = 0
        for key in keys{
            if key == k{
                return(result)
            }
            result += 1
        }
        return(nil)
    }
    
     override func set(_ k: K, v: V){
        if get(k) == nil{
            keys.append(k)
            values.append(v)
            count += 1
        } else {
            values[findKeyIndex(k)!] = v
            return
        }
    }
    
    override func remove(_ k: K){
        let index = findKeyIndex(k)
        if index == nil{
            print("Unable to find key: \(k)")
            return
        } else {
            print("Removed at index: \(index!)")
            keys.remove(at: index!)
            values.remove(at: index!)
            count -= 1
        }
    }
    
    override func get(_ k: K)-> V?{
        let index = findKeyIndex(k)
        if index == nil{
            return(nil)
        } else {
            return(values[index!])
        }
    }
    
    override subscript(index: K) -> V? {
        get {
            return(get(index))
        }
        set(newValue) {
            set(index, v: newValue!)
        }
    }
    
    var rawString: String{
        var desc = ""
        for n in 0..<keys.count{
            desc += "\(keys[n]): \(values[n]), "
        }
        if desc.count != 1{
            desc = String(desc.dropLast(2))
        }
        return desc
    }
    
    override var description: String{
        var desc = "["
        for n in 0..<keys.count{
            desc += "\(keys[n]): \(values[n]), "
        }
        if desc.count != 1{
            desc = String(desc.dropLast(2))
        }
        return desc + "]"
    }
}
