//
//  GeneratePrime.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

func generatePrimeCandidate64() -> UInt64 {
        var candidate: UInt64
        repeat {
                candidate = UInt64.random(in: 0 ..< UInt64.max)
                candidate |= 1
        } while !RabinMillerTest(candidate)
        return candidate
}
