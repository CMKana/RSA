//
//  GenerateE.swift
//  RSA
//
//  Created by Евгений Канашкин on 22.05.2025.
//

func generateE<T: FixedWidthInteger>(phi: T) -> T {
        
        var e: T
        repeat {
                e = T.random(in: 3 ..< phi)
                e |= 1
        } while !RabinMillerTest(e) && gcd(e, phi) != 1
        
        return e
}
