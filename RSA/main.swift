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
let d: UInt128
let e: UInt128

(p, q) = generatePQ()
n = UInt128(p) * UInt128(q)
fn = (UInt128(p) - 1) * (UInt128(q) - 1)

printTable(head: ["P", "Q", "n", "ƒ(n)"], content: [UInt128(p), UInt128(q), n, fn], leadingZeros: .no, separators: .underscore)

d = generateD(phi: fn)

e = generateE(d, fn)

printTable(head: ["d", "e", "(d * e) % fn"], content: [d, e, (d * e) % fn], leadingZeros: .no, separators: .underscore)
