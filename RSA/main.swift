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

print("P|Q|n|φ(n)|")
print("\(p)|\(q)|\(n)|\(fn)|")
print()

let pString: String = AnyIntToString(p, false, true)
let qString: String = AnyIntToString(q, false, true)
let nString: String = AnyIntToString(n, false, true)
let fnString: String = AnyIntToString(fn, false, true)

let pHead: String = "P".padding(toLength: pString.count, withPad: " ", startingAt: 0)
let qHead: String = "Q".padding(toLength: qString.count, withPad: " ", startingAt: 0)
let nHead: String = "n".padding(toLength: nString.count, withPad: " ", startingAt: 0)
let fnHead: String = "φ(n)".padding(toLength: fnString.count, withPad: " ", startingAt: 0)

let tableSeparator: String = String(repeating: "—", count: pHead.count) + "+" + String(repeating: "—", count: qHead.count) + "+" + String(repeating: "—", count: nHead.count) + "+" + String(repeating: "—", count: fnHead.count) + "+"

print(tableSeparator)
print("\(pHead)|\(qHead)|\(nHead)|\(fnHead)|")
print(tableSeparator)
print("\(pString)|\(qString)|\(nString)|\(fnString)|")
print(tableSeparator)
