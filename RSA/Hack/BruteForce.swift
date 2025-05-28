//
//  BruteForce.swift
//  RSA
//
//  Created by Евгений Канашкин on 28.05.2025.
//

func factorize(_ n: BigInt) -> (p: BigInt, q: BigInt)? {
        var divisor = BigInt(2)
        
        while divisor * divisor <= n {
                let (quotient, remainder) = n.divMod(divisor)
                if remainder == BigInt(0) {
                        return (p: divisor, q: quotient)
                }
                divisor = divisor + BigInt(1)
        }
        
        return nil
}
