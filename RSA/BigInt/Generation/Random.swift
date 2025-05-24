//
//  Random.swift
//  RSA
//
//  Created by Евгений Канашкин on 23.05.2025.
//

extension BigInt {
        static func random(in range: Range<BigInt>) -> BigInt {
                let lower = range.lowerBound
                let upper = range.upperBound
                
                precondition(lower < upper, "Invalid range")
                
                let difference = upper - lower
                let bitWidth = difference.bitWidth()
                
                var result: BigInt
                repeat {
                        result = BigInt.random(bits: bitWidth)
                } while result >= difference
                
                if (lower + result).chunks.first == nil {
                        return BigInt(0)
                }
                
                return lower + result
        }
}

extension BigInt {
        static func random(bits: Int) -> BigInt {
                precondition(bits > 0, "Bit width must be positive")
                
                let chunkBitWidth = 64
                let fullChunks = bits / chunkBitWidth
                let remainingBits = bits % chunkBitWidth
                
                var chunks: [UInt64] = []
                
                for _ in 0..<fullChunks {
                        chunks.append(UInt64.random(in: UInt64.min...UInt64.max))
                }
                
                if remainingBits > 0 {
                        let maxValue: UInt64 = (1 << remainingBits) - 1
                        let lastChunk = UInt64.random(in: 0...maxValue)
                        chunks.append(lastChunk)
                }
                
                while let last = chunks.last, last == 0 && chunks.count > 1 {
                        chunks.removeLast()
                }
                
                return BigInt(.positive, chunks)
        }
}
