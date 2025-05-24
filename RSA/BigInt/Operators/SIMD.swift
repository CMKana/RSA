//
//  SIMD.swift
//  RSA
//
//  Created by Евгений Канашкин on 24.05.2025.
//

extension BigInt {
        static func |= (lhs: inout BigInt, rhs: UInt64) {
                if lhs.chunks.isEmpty {
                        lhs.chunks = [1]
                } else {
                        lhs.chunks[0] |= rhs
                }
        }
        
        static func << (lhs: BigInt, rhs: Int) -> BigInt {
                var result = lhs
                result <<= rhs
                return result
        }
        
        static func <<= (lhs: inout BigInt, rhs: Int) {
                guard rhs > 0 else { return }
                
                let wordShift = rhs / 64
                let bitShift = rhs % 64
                
                lhs.chunks.insert(contentsOf: Array(repeating: 0, count: wordShift), at: 0)
                
                var carry: UInt64 = 0
                for i in 0 ..< lhs.chunks.count {
                        let newValue = (UInt128(lhs.chunks[i]) << bitShift) | UInt128(carry)
                        lhs.chunks[i] = UInt64(newValue & 0xFFFFFFFFFFFFFFFF)
                        carry = UInt64(newValue >> 64)
                }
                
                if carry > 0 {
                        lhs.chunks.append(carry)
                }
                
                lhs = lhs.trimZeroes()
        }
        
        static func >> (lhs: BigInt, rhs: Int) -> BigInt {
                var result = lhs
                result >>= rhs
                return result
        }
        
        static func >>= (lhs: inout BigInt, rhs: Int) {
                guard rhs > 0 else { return }
                
                let wordShift = rhs / 64
                let bitShift = rhs % 64
                
                if wordShift >= lhs.chunks.count {
                        lhs.chunks = [0]
                        return
                }
                
                lhs.chunks.removeFirst(wordShift)
                
                var carry: UInt64 = 0
                for i in (0 ..< lhs.chunks.count).reversed() {
                        let newValue = (UInt128(lhs.chunks[i]) >> bitShift) | (UInt128(carry) << (64 - bitShift))
                        carry = lhs.chunks[i] & ((1 << bitShift) - 1)
                        lhs.chunks[i] = UInt64(newValue)
                }
                
                lhs = lhs.trimZeroes()
        }
}
