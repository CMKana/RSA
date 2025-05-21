//
//  GeneratePQ.swift
//  RSA
//
//  Created by Евгений Канашкин on 22.05.2025.
//

func generatePQ() -> (UInt64, UInt64) {
        
        let p: UInt64 = generatePrimeCandidate64()
        
        let q: UInt64 = generatePrimeCandidate64()
        
        return (p, q)
}
