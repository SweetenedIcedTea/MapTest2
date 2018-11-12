//
//  Benchmark.swift
//  TestingOMaps
//
//  Created by Ethan Zhang on 11/12/18.
//  Copyright © 2018 NepinNep. All rights reserved.
//

import Foundation

func getCurrentMillis()-> Int64{
    return(Int64(NSDate().timeIntervalSince1970 * 1000))
}

class NaiveBenchmark{
    var stringList = [String]()
    let chars = Array("abcdefghijklmnopqrstuvwxyz")
    
    let maxSize = 1000000
    let numberGets = 8000
    let numberPuts = 8000
    
    var startTaskMS: Int64 = 0
    var endTaskMS: Int64 = 0
    
    func startTimer(){
        startTaskMS = getCurrentMillis()
    }
    
    func stopTimer(){
        endTaskMS = getCurrentMillis()
    }
    
    func elapsedTimeMS()-> Int{
        return(Int(endTaskMS - startTaskMS))
    }
    
    func elapsedTimeSeconds()-> Int{
        return(elapsedTimeMS() / 1000)
    }
    
    func elapsedTimeTenthsSeconds()-> Int{
        return(elapsedTimeMS() / 100)
    }
    
    func benchmarkMessageTenths(mess: String){
        print("\(mess) took \(elapsedTimeTenthsSeconds()) tenths of a second")
    }
    
    func getRandomInt(range: Int)-> Int{
        return( Int(arc4random_uniform(UInt32(range))) )
    }
    
    func makeString(length: Int)-> String{
        var s = ""
        let numberChars = chars.count
        for _ in 0..<length{
            s.append(chars[getRandomInt(range: numberChars)])
        }
        return(s)
    }
    
    func makeStringList(size: Int){
        stringList = [String]()
        for _ in 0..<size{
            stringList.append(makeString(length: 10))
        }
    }
    
    func testBinary()-> Bool{
        makeStringList(size: maxSize)
        var value = ""
        var key = ""
        var index = 0
        let map = BinaryMap<String, String>()
        
        startTimer()
        for n in 0..<numberPuts{
            map.set(stringList[n], v: stringList[n])
        }
        stopTimer()
        benchmarkMessageTenths(mess: "\(numberPuts) put operations")
        
        startTimer()
        
        for _ in 0..<numberGets{
            index = getRandomInt(range: numberPuts)
            key = stringList[index]
            value = map.get(key)!
            if (!(value == key)){
                return(false)
            }
        }
        
        stopTimer()
        benchmarkMessageTenths(mess: "\(numberGets) get operations")
        return(true)
    }
    
    func testLinear()-> Bool{
        makeStringList(size: maxSize)
        var value = ""
        var key = ""
        var index = 0
        let map = LinearMap<String, String>()
        
        startTimer()
        for n in 0..<numberPuts{
            map.set(stringList[n], v: stringList[n])
        }
        stopTimer()
        benchmarkMessageTenths(mess: "\(numberPuts) put operations")
        
        startTimer()
        
        for _ in 0..<numberGets{
            index = getRandomInt(range: numberPuts)
            key = stringList[index]
            value = map.get(key)!
            if (!(value == key)){
                return(false)
            }
        }
        
        stopTimer()
        benchmarkMessageTenths(mess: "\(numberGets) get operations")
        return(true)
    }
    
    func testHash()-> Bool{
        makeStringList(size: maxSize)
        var value = ""
        var key = ""
        var index = 0
        let map = HashMap<String, String>(initialArraySize: maxSize)
        
        startTimer()
        for n in 0..<numberPuts{
            map.set(stringList[n], v: stringList[n])
        }
        stopTimer()
        benchmarkMessageTenths(mess: "\(numberPuts) put operations")
        
        startTimer()
        
        for _ in 0..<numberGets{
            index = getRandomInt(range: numberPuts)
            key = stringList[index]
            value = map.get(key)!
            if (!(value == key)){
                return(false)
            }
        }
        
        stopTimer()
        benchmarkMessageTenths(mess: "\(numberGets) get operations")
        print("Number of Collisions: \(map.getNumberCollisions())")
        return(true)
    }
}

func doBenchmark(){
    print("Lets go!")
    let nb = NaiveBenchmark()
    
    print("Testing Linear Map: \n")
    if (nb.testLinear()){
        print("Linear Map OK \n")
    } else {
        print("Linear Map Bad \n")
    }
    
    print("Testing Binary Map: \n")
    if (nb.testBinary()){
        print("Binary Map OK \n")
    } else {
        print("Binary Map Bad \n")
    }
    
    print("Testing Hash Map: \n")
    if (nb.testHash()){
        print("Hash Map OK \n")
    } else {
        print("Hash Map Bad \n")
    }
}
