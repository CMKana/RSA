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

extension BigInt {
        init?(hex string: String) {
                var s = string.trimmingCharacters(in: .whitespacesAndNewlines)
                
                var sign: Sign = .positive
                if s.hasPrefix("-") {
                        sign = .negative
                        s.removeFirst()
                } else if s.hasPrefix("+") {
                        s.removeFirst()
                }
                
                if s.lowercased().hasPrefix("0x") {
                        s = String(s.dropFirst(2))
                }
                
                s = s.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "_", with: "")
                
                guard s.allSatisfy({ $0.isHexDigit }) else {
                        return nil
                }
                
                guard !s.isEmpty else {
                        self.init()
                        return
                }
                
                var chunks: [UInt64] = []
                var current = s
                
                while !current.isEmpty {
                        let endIndex = current.index(current.endIndex, offsetBy: -min(16, current.count))
                        let chunkStr = String(current[endIndex..<current.endIndex])
                        current = String(current[..<endIndex])
                        
                        guard let chunk = UInt64(chunkStr, radix: 16) else {
                                return nil
                        }
                        chunks.append(chunk)
                }
                
                self.init(sign, chunks)
        }
}
