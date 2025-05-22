//
//  GCD.swift
//  RSA
//
//  Created by Евгений Канашкин on 22.05.2025.
//

func gcd<T: FixedWidthInteger>(_ lhs: T, _ rhs: T) -> T {
        
        var a: T = max(lhs, rhs)
        var b: T = min(lhs, rhs)
        
        while a > 0 && b > 0 {
                
//                print("A: \(a)")
//                print("B: \(b)")
                
                if a - b == 0 {
                        return a
                }
                
                a -= b
                
                if a < b {
                        (a, b) = (b, a)
                }
        }
        
        return 0
}
