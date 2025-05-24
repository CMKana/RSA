//
//  main.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

import Foundation

let zero: BigInt = BigInt([0, 1])
let limit: BigInt = BigInt([0, 2])

let p: BigInt = generatePrimeCandidate(in: zero ..< limit)
let q: BigInt = generatePrimeCandidate(in: zero ..< limit)
let pq = p + q

printBigInt(with: ["P", "Q", "P+Q", "1"], using: [p, q, pq, BigInt(1)], as: .both, separator: .space, leadingZeros: .no)

//let n: UInt128
//let fn: UInt128
//n = UInt128(p) * UInt128(q)
//fn = (UInt128(p) - 1) * (UInt128(q) - 1)
//printTable(head: ["n", "ƒ(n)"], content: [n, fn], leadingZeros: .no, separators: .underscore)

//let d: UInt128
//let e: UInt128
//d = generateD(phi: fn)
//e = generateE(d, fn)
//printTable(head: ["d", "e", "(d * e) % fn"], content: [d, e, (d * e) % fn], leadingZeros: .no, separators: .underscore)
