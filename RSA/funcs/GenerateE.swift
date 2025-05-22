//
//  GenerateE.swift
//  RSA
//
//  Created by Евгений Канашкин on 22.05.2025.
//

func generateE<T: FixedWidthInteger>(_ d: T, _ fn: T) -> T {
        
        var e: T
        
        var n: T = 1
        
        repeat {
                
                e = ((fn * n) + 1) / d
                
                n += 1
                
        } while (d * e) % fn != 1
        
        return e
}
