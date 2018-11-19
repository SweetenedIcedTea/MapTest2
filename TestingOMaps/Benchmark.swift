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
    
    func benchmarkMessage(mess: String){
        print("\(mess) took \(elapsedTimeMS()) thousandaths of a second")
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
    
    func power(num: Int, power: Int)-> Int{
        var result = num
        for _ in 1..<power{
            result *= num
        }
        return(result)
    }
    
    func getListSize(first: Int, pow: Int)-> Int{
        let expo = power(num: 10, power: pow)
        return(first * expo)
    }
    
    func testLinear(){
        setCsvText += "Linear Set, \n"
        getCsvText += "Linear Get, \n"
        for pow in 1...magnitude{
                let numOperations = getListSize(first: 1, pow: pow)
                setCsvText += "\(numOperations),"
                makeStringList(size: numOperations)
                let map = LinearMap<String, String>()
                
                startTimer()
                for n in 0..<numOperations{
                    map.set(stringList[n], v: stringList[n])
                }
                stopTimer()
                
                setCsvText += "\( elapsedTimeMS() )\n"
                benchmarkMessage(mess: "Linear \(numOperations) set operations")
                
                var value = ""
                var key = ""
                var index = 0
                getCsvText += "\(numOperations),"
                
                startTimer()
                for _ in 0..<numOperations{
                    index = getRandomInt(range: numOperations)
                    key = stringList[index]
                    value = map.get(key)!
                }
                stopTimer()
                
                getCsvText += "\( elapsedTimeMS() )\n"
                benchmarkMessage(mess: "Linear \(numOperations) get operations")
        }
    }
    
    func testBinary(){
        setCsvText += "Binary Set, \n"
        getCsvText += "Binary Get, \n"
        for pow in 1...magnitude{
                let numOperations = getListSize(first: 1, pow: pow)
                setCsvText += "\(numOperations),"
                makeStringList(size: numOperations)
                let map = BinaryMap<String, String>()
                
                startTimer()
                for n in 0..<numOperations{
                    map.set(stringList[n], v: stringList[n])
                }
                stopTimer()
                
                setCsvText += "\( elapsedTimeMS() )\n"
                benchmarkMessage(mess: "Binary \(numOperations) set operations")
                
                var value = ""
                var key = ""
                var index = 0
                getCsvText += "\(numOperations),"
                
                startTimer()
                for _ in 0..<numOperations{
                    index = getRandomInt(range: numOperations)
                    key = stringList[index]
                    value = map.get(key)!
                }
                stopTimer()
                
                getCsvText += "\( elapsedTimeMS() )\n"
                benchmarkMessage(mess: "Binary \(numOperations) get operations")
        }
    }
    
    func testHash(){
        hashSetCsvText += "Hash Set, \n"
        hashGetCsvText += "Hash Get, \n"
        for sizeMag in 1...magnitude{
            print("Array Size: \( power(num: 10, power: sizeMag * 2) )\n")
            hashSetCsvText += "Array Size, \( power(num: 10, power: sizeMag * 2) )\n"
            hashGetCsvText += "Array Size, \( power(num: 10, power: sizeMag * 2) )\n"
            for pow in 1...magnitude{
                    let numOperations = getListSize(first: 1, pow: pow)
                    hashSetCsvText += "\(numOperations),"
                    makeStringList(size: numOperations)
                    let map = HashMap<String, String>(initialArraySize: power(num: 10, power: sizeMag * 2))
                    
                    startTimer()
                    for n in 0..<numOperations{
                        map.set(stringList[n], v: stringList[n])
                    }
                    stopTimer()
                    
                    hashSetCsvText += "\( elapsedTimeMS() )\n"
                    benchmarkMessage(mess: "Hash \(numOperations) set operations")
                    
                    var value = ""
                    var key = ""
                    var index = 0
                    hashGetCsvText += "\(numOperations),"
                    
                    startTimer()
                    for _ in 0..<numOperations{
                        index = getRandomInt(range: numOperations)
                        key = stringList[index]
                        value = map.get(key)!
                    }
                    stopTimer()
                    
                    hashGetCsvText += "\( elapsedTimeMS() )\n"
                    benchmarkMessage(mess: "Hash \(numOperations) get operations")
            }
        }
    }
}

func doBenchmark(){
    print("Lets go!")
    let nb = NaiveBenchmark()
    
    print("Testing Linear Map: \n")
    nb.testLinear()
    
    print("Testing Binary Map: \n")
    nb.testBinary()
    
    print("Testing Hash Map: \n")
    nb.testHash()

}
