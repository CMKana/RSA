//
//  FermatFactor.swift
//  RSA
//
//  Created by Евгений Канашкин on 28.05.2025.
//

func fermatFactor(_ n: BigInt) -> (BigInt, BigInt)? {
        guard n > BigInt(1) && n % BigInt(2) != BigInt(0) else {
                return nil
        }
        
        var a = n.sqrt()
        if a * a < n {
                a = a + BigInt(1)
        }
        
        while true {
                let b2 = a * a - n
                if let b = b2.sqrtIfPerfectSquare() {
                        let p = a - b
                        let q = a + b
                        if p * q == n {
                                return (p, q)
                        }
                }
                
                a = a + BigInt(1)
        }
}
