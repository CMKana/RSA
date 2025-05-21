//
//  RabinMillerTest.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

func RabinMillerTest<T: FixedWidthInteger>(_ n: T, rounds: Int = 10) -> Bool {
        if n < 2 { return false }
        if n == 2 || n == 3 { return true }
        if n % 2 == 0 { return false }
        
        var r: T = 0
        var d: T = n - 1
        while d % 2 == 0 {
                d /= 2
                r += 1
        }
        
        func modPow(_ baseInput: T, _ exponent: T, _ mod: T) -> T {
                var result: T = 1
                var base: T = baseInput % mod
                var exp: T = exponent
                
                while exp > 0 {
                        if exp & 1 == 1 {
                                result = modularMultiply(result, base, mod)
                        }
                        base = modularMultiply(base, base, mod)
                        exp >>= 1
                }
                
                return result
        }
        
        for _ in 0 ..< rounds {
                let a: T = T.random(in: 2 ..< (n - 2))
                var x: T = modPow(a, d, n)
                if x == 1 || x == n - 1 { continue }
                
                var continueLoop: Bool = false
                for _ in 0 ..< (r - 1) {
                        x = modularMultiply(x, x, n)
                        if x == n - 1 {
                                continueLoop = true
                                break
                        }
                }
                if continueLoop { continue }
                return false
        }
        
        return true
        
        func modularMultiply(_ aInput: T, _ bInput: T, _ mod: T) -> T {
                var result: T = 0
                var a = aInput % mod
                var b = bInput
                
                while b > 0 {
                        if b & 1 == 1 {
                                let (sum, overflow) = result.addingReportingOverflow(a)
                                if !overflow {
                                        result = sum % mod
                                }
                        }
                        
                        let (doubled, overflow2) = a.multipliedReportingOverflow(by: 2)
                        if !overflow2 {
                                a = doubled % mod
                        }
                        
                        b >>= 1
                }
                
                return result % mod
        }
}
