//
//  GenerateD.swift
//  RSA
//
//  Created by Евгений Канашкин on 22.05.2025.
//

func generateD<T: FixedWidthInteger>(phi: T) -> T {
        
        var d: T
        repeat {
                d = T.random(in: 3 ..< phi)
                d |= 1
        } while !RabinMillerTest(d) && gcd(d, phi) != 1
        
        return d
}
