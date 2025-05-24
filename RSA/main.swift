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

let n: BigInt = p * q
let fn: BigInt = (p - BigInt(1)) * (q - BigInt(1))
printBigInt(with: ["n", "ƒ(n)"], using: [n, fn], as: .both, separator: .space, leadingZeros: .no)

//let d: UInt128
//let e: UInt128
//d = generateD(phi: fn)
//e = generateE(d, fn)
//printTable(head: ["d", "e", "(d * e) % fn"], content: [d, e, (d * e) % fn], leadingZeros: .no, separators: .underscore)
