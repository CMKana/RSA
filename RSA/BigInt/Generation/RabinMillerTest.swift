//
//  RabinMillerTest.swift
//  RSA
//
//  Created by Евгений Канашкин on 24.05.2025.
//

func modPow(_ base: BigInt, _ exponent: BigInt, _ modulus: BigInt) -> BigInt {
        var result: BigInt = BigInt(1)
        var base: BigInt = base % modulus
        var exp: BigInt = exponent
        
        while exp > BigInt(0) {
                if exp.chunks[0] & 1 == 1 {
                        result = (result * base) % modulus
                }
                exp = exp >> 1
                base = (base * base) % modulus
        }
        return result
}

func RabinMillerTest(_ n: BigInt, iterations: Int = 5) -> Bool {
        
        if n <= BigInt(1) { return false }
        if n == BigInt(2) { return true }
        if n.chunks.first! % 2 == 0 { return false }
        
        var d = n - BigInt(1)
        var r = 0
        while d.chunks.first! % 2 == 0 {
                d >>= 1
                r += 1
        }
        
        for _ in 0 ..< iterations {
                let a = BigInt.random(in: BigInt(2) ..< n - BigInt(2))
                var x = modPow(a, d, n)
                
                if x == BigInt(1) || x == n - BigInt(1) {
                        continue
                }
                
                var passed = false
                for _ in 0 ..< (r - 1) {
                        x = (x * x) % n
                        if x == n - BigInt(1) {
                                passed = true
                                break
                        }
                }
                
                if !passed {
                        return false
                }
        }
        
        return true
}
