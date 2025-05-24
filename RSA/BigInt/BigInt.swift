//
//  BigInt.swift
//  RSA
//
//  Created by Евгений Канашкин on 23.05.2025.
//

enum Sign {
        case positive
        case negative
}

struct BigInt {
        var sign: Sign
        var chunks: [UInt64]

        // Empty
        init() {
                self.sign = .positive
                self.chunks = []
        }
        
        // Sign/less Array<UInt64>
        init(_ sign: Sign, _ chunks: [UInt64]) {
                self.sign = sign
                self.chunks = chunks
        }
        
        init(_ chunks: [UInt64]) {
                self.sign = .positive
                self.chunks = chunks
        }
        
        // Sign/less UInt64
        init(_ sign: Sign, _ chunk: UInt64) {
                self.sign = sign
                self.chunks = [chunk]
        }
        
        init(_ chunk: UInt64) {
                self.sign = .positive
                self.chunks = [chunk]
        }
}
