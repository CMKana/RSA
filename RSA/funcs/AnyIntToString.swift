//
//  UInt128toString.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

import Foundation

enum LeadingZeros {
        case yes
        case no
}

enum Separators {
        case underscore
        case space
        case none
}

func AnyIntToString<T: FixedWidthInteger>(_ input: T, _ leadingZeros: LeadingZeros = .no, _ separators: Separators = .none) -> String {
        var output: String = String(input)
        
        switch leadingZeros {
        case .yes:
                output = String(output.reversed())
                output = String(output.padding(toLength: String(type(of: input).max).count, withPad: "0", startingAt: 0).reversed())
        case .no:
                break
        }
        
        switch separators {
        case .underscore:
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
        case .space:
                var temp: String = ""
                
                for (i, c) in output.reversed().enumerated() {
                        temp += String(c)
                        if (i + 1) % 3 == 0 {
                                temp += " "
                        }
                }
                
                if temp.last == " " {
                        temp.removeLast()
                }
                
                output = String(temp.reversed())
        case .none:
                break
        }
        
        return output
}
