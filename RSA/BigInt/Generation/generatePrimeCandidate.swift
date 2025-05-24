//
//  generatePrimeCandidate.swift
//  RSA
//
//  Created by Евгений Канашкин on 24.05.2025.
//

func generatePrimeCandidate(_ from: BigInt = BigInt(), _ to: BigInt = limit) -> BigInt {
        
        var candidate: BigInt
        repeat {
                candidate = BigInt.random(in: from ..< to)
                candidate |= 1
        } while !RabinMillerTest(candidate, iterations: 5)
        
        return candidate
}

func generatePrimeCandidate(in range: Range<BigInt>) -> BigInt {
        
        var candidate: BigInt
        repeat {
                candidate = BigInt.random(in: range.lowerBound ..< range.upperBound)
                candidate |= 1
        } while !RabinMillerTest(candidate, iterations: 5)
        
        return candidate
}
