//
//  main.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

import Foundation

let limit: UInt128 = UInt128.max
print(AnyIntToString(limit,false,false))
print(AnyIntToString(limit,false,true))
print(AnyIntToString(limit,true,false))
print(AnyIntToString(limit,true,true))
