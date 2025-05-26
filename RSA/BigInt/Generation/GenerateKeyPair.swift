//
//  GenerateKeyPair.swift
//  RSA
//
//  Created by Евгений Канашкин on 26.05.2025.
//

func generateKeyPair(fn: BigInt, n: BigInt) -> (publicKey: (e: BigInt, n: BigInt), privateKey: (d: BigInt, n: BigInt)) {
        let e = generatePublicExponent(phi: fn)
        guard gcd(e, fn) == BigInt(1) else {
                fatalError("e и φ(n) не взаимно просты")
        }
        
        guard let d = modInverse(e, fn) else {
                fatalError("Не удалось найти модульную обратную к e")
        }
        
        return ((e, n), (d, n))
}

func generatePublicExponent(phi: BigInt) -> BigInt {
//        let smallPrimes: [UInt64] = [ 3, 5, 17, 257, 65537, 274177, 6700417, 2147483647 ]
//        for prime in smallPrimes {
//                let e = BigInt(prime)
//                if e < phi && gcd(e, phi) == BigInt(1) {
//                        return e
//                }
//        }
        
        while true {
                var e = BigInt.random(in: BigInt(3) ..< phi)
                e |= 1
                if gcd(e, phi) == BigInt(1) {
                        return e
                }
        }
}

func gcd(_ a: BigInt, _ b: BigInt) -> BigInt {
        var a = a
        var b = b
        while !b.isZero() {
                let r = a % b
                a = b
                b = r
        }
        return a
}

func modInverse(_ a: BigInt, _ m: BigInt) -> BigInt? {
        var m0 = m
        var x0: BigInt = BigInt(0)
        var x1: BigInt = BigInt(1)
        var a = a
        
        if m == BigInt(1) {
                return nil
        }
        
        while a > BigInt(1) {
                let q = a / m0
                var t = m0
                
                m0 = a % m0
                a = t
                t = x0
                
                x0 = x1 - q * x0
                x1 = t
        }
        
        if x1 < BigInt(0) {
                x1 = x1 + m
        }
        
        return x1
}
