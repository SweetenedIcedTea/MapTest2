//
//  FakeMap.swift
//  TestingOMaps
//
//  Created by Ethan Zhang on 11/2/18.
//  Copyright © 2018 NepinNep. All rights reserved.
//

import Foundation

class FakeMap<K, V>: CustomStringConvertible{
    func getNumberCollisions()-> Int {return 0}
    
    func set(_ k: K, v: V) {return}
    
    func remove(_ k : K) {return}
    
    func get(_ k: K)-> V? {return nil}
    
    var count = 0
    
    subscript(index: K) -> V? {return nil}
    
    var description: String{
        return "Fake Map!"
    }
}
