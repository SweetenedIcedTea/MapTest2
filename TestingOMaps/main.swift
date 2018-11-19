//
//  main.swift
//  TestingOMaps
//
//  Created by Ethan Zhang on 11/2/18.
//  Copyright © 2018 NepinNep. All rights reserved.
//

import Foundation

var setCsvText = "Number Operations, Time(ms)\n"
var getCsvText = "Number Operations, Time(ms)\n"
var hashSetCsvText = ""
var hashGetCsvText = ""

doBenchmark()

do {
    try setCsvText.write(to: setPath, atomically: true, encoding: String.Encoding.utf8)
} catch {
    print("Failed to create set csv")
    print("\(error)")
}

do {
    try getCsvText.write(to: getPath, atomically: true, encoding: String.Encoding.utf8)
} catch {
    print("Failed to create set csv")
    print("\(error)")
}

do {
    try hashSetCsvText.write(to: hashSetPath, atomically: true, encoding: String.Encoding.utf8)
} catch {
    print("Failed to create set csv")
    print("\(error)")
}

do {
    try hashGetCsvText.write(to: hashGetPath, atomically: true, encoding: String.Encoding.utf8)
} catch {
    print("Failed to create set csv")
    print("\(error)")
}

