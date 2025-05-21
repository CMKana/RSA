//
//  main.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

import Foundation

let limit: UInt128 = UInt128.max

let p: UInt64
let q: UInt64
let n: UInt128
let fn: UInt128

(p, q) = generatePQ()
n = UInt128(p) * UInt128(q)
fn = (UInt128(p) - 1) * (UInt128(q) - 1)

print("P|Q|N|φ(N)|")
print("\(p)|\(q)|\(n)|\(fn)|")
