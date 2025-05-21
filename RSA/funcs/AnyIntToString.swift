//
//  UInt128toString.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

import Foundation

func AnyIntToString<T: FixedWidthInteger>(_ input: T, _ usingZeros: Bool = false, _ separator: Bool = false) -> String {
        var output: String = String(input)
        
        if usingZeros {
                output = String(output.reversed())
                output = String(output.padding(toLength: String(type(of: input).max).count, withPad: "0", startingAt: 0).reversed())
        }
        
        if separator {
                var temp: String = ""
                
                for (i, c) in output.reversed().enumerated() {
                        temp += String(c)
                        if (i + 1) % 3 == 0 {
                                temp += "_"
                        }
                }
                
                if temp.last == "_" {
                        temp.removeLast()
                }
                
                output = String(temp.reversed())
        }
        
        return output
}
