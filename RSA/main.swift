//
//  main.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

import Foundation

let zero: BigInt = BigInt([0])
let limit: BigInt = BigInt([0,0,1,1])

let p: BigInt = generatePrimeCandidate(in: zero ..< limit)
let q: BigInt = generatePrimeCandidate(in: zero ..< limit)
//let p: BigInt = BigInt(hex: "1 dd14 4dde a522 4d4b")!
//let q: BigInt = BigInt(hex: "1 7775 5aad 10cc 48b9")!
let pq = p + q

printBigInt(with: ["P", "Q", "P+Q"], using: [p, q, pq], as: .both, separator: .space, leadingZeros: .no)

let n: BigInt = p * q
let fn: BigInt = (p - BigInt(1)) * (q - BigInt(1))
printBigInt(with: ["n", "ƒ(n)"], using: [n, fn], as: .both, separator: .space, leadingZeros: .no)

let (e, d): ((BigInt, BigInt), (BigInt, BigInt)) = generateKeyPair(fn: fn, n: n)
printBigInt(with: ["Public Key 0", "Public Key 1", "Private Key 0", "Private Key 1"], using: [e.0, e.1, d.0, d.1], as: .both, separator: .space)
