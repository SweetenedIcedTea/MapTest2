//
//  BinaryMap.swift
//  TestingOMaps
//
//  Created by Ethan Zhang on 11/12/18.
//  Copyright © 2018 NepinNep. All rights reserved.
//

import Foundation

class BinaryMap<K: Comparable, V>: FakeMap<K, V>{
    var keys = [K]()
    var values = [V]()
    
    override func set(_ k: K, v: V){
        var index = 0
        if count == 0{
            keys.append(k)
            values.append(v)
            count += 1
            return
        }
        if let index = findKeyIndex(k){
            values[index] = v
            return
        }
        for key in keys{
            if k > key{
                index += 1
            } else {
                keys.insert(k, at: index)
                values.insert(v, at: index)
                count += 1
                return
            }
            if index == keys.count{
                keys.insert(k, at: index)
                values.insert(v, at: index)
                count += 1
            }
        }
    }
    
    override func remove(_ k: K){
        let keyIndex = findKeyIndex(k)
        if keyIndex == nil{
            print("Could not find \(k)")
            return
        }
        keys.remove(at: keyIndex!)
        values.remove(at: keyIndex!)
        count -= 1
    }
    
    override func get(_ k: K)-> V?{
        let index = findKeyIndex(k)
        if index == nil{
            return(nil)
        } else {
            return(values[index!])
        }
    }
    
    func findKeyIndex(_ k: K)-> Int?{
        return(binarySearch(keys, key: k, range: 0..<keys.count))
    }
    
    override subscript(index: K) -> V? {
        get {
            return(get(index))
        }
        set(newValue) {
            set(index, v: newValue!)
        }
    }
    
    func binarySearch(_ a: [K], key: K, range: Range<Int>) -> Int? {
        if range.lowerBound >= range.upperBound {
            // If we get here, then the search key is not present in the array.
            return nil
        } else {
            // Calculate where to split the array.
            let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
            
            // Is the search key in the left half?
            if a[midIndex] > key {
                return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
                
                // Is the search key in the right half?
            } else if a[midIndex] < key {
                return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
                // If we get here, then we've found the search key!
            } else {
                return midIndex
            }
        }
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
