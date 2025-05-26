//
//  Misc.swift
//  RSA
//
//  Created by Евгений Канашкин on 24.05.2025.
//

extension BigInt {
        func trimZeroes() -> BigInt {
                var copy = self
                while let last = copy.chunks.last, last == 0 && copy.chunks.count > 1 {
                        copy.chunks.removeLast()
                }
                return copy
        }
        
        func bitWidth() -> Int {
                guard let last = chunks.last(where: { $0 != 0 }) else {
                        return 0
                }
                
                let lastIndex = chunks.lastIndex(of: last)!
                let leadingZeros = last.leadingZeroBitCount
                return lastIndex * 64 + (64 - leadingZeros)
        }
        
        func isZero() -> Bool {
                return chunks.allSatisfy { $0 == 0 }
        }
}

func abs(_ input: BigInt) -> BigInt {
        return BigInt(.positive, input.chunks)
}
