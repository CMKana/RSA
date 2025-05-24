//
//  Comparison.swift
//  RSA
//
//  Created by Евгений Канашкин on 23.05.2025.
//

extension BigInt: Comparable, Equatable {
        
        static func < (lhs: BigInt, rhs: BigInt) -> Bool {
                
                switch (lhs.sign, rhs.sign) {
                        
                case (.positive, .positive):
                        
                        let lhs = BigInt(lhs.chunks).trimZeroes()
                        let rhs = BigInt(rhs.chunks).trimZeroes()

                        if lhs.chunks.count != rhs.chunks.count {
                                return lhs.chunks.count < rhs.chunks.count
                        }

                        for i in (0 ..< lhs.chunks.count).reversed() {
                                if lhs.chunks[i] != rhs.chunks[i] {
                                        return lhs.chunks[i] < rhs.chunks[i]
                                }
                        }

                        return false
                        
                case (.positive, .negative):
                        return false
                        
                case (.negative, .positive):
                        return true
                        
                case (.negative, .negative):
                        return BigInt(.positive, lhs.chunks) > BigInt(.positive, rhs.chunks)
                }
        }
        
        static func == (lhs: BigInt, rhs: BigInt) -> Bool {
                let lhs = lhs.trimZeroes()
                let rhs = rhs.trimZeroes()
                
                if lhs.chunks.count != rhs.chunks.count {
                        return false
                }

                for i in (0 ..< lhs.chunks.count).reversed() {
                        if lhs.chunks[i] != rhs.chunks[i] {
                                return false
                        }
                }
                
                return true
        }
        
}
