//
//  textWrite.swift
//  TestingOMaps
//
//  Created by Ethan Zhang on 11/12/18.
//  Copyright © 2018 NepinNep. All rights reserved.
//

import Foundation

let getPath = URL(string: "file:///Users/sweetenedicedtea/Desktop/AdvProgram/TestingOMaps/getData.csv")!
let setPath = URL(string: "file:///Users/sweetenedicedtea/Desktop/AdvProgram/TestingOMaps/setData.csv")!
let hashSetPath = URL(string: "file:///Users/sweetenedicedtea/Desktop/AdvProgram/TestingOMaps/hashSetData.csv")!
let hashGetPath = URL(string: "file:///Users/sweetenedicedtea/Desktop/AdvProgram/TestingOMaps/hashGetData.csv")!
let magnitude = 4

func power(num: Int, power: Int)-> Int{
    var result = num
    for _ in 1..<power{
        result *= num
    }
    return(result)
}

func getNumber(first: Int, pow: Int)-> Int{
    let expo = power(num: 10, power: pow)
    return(first * expo)
}
