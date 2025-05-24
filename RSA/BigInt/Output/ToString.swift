//
//  ToString.swift
//  RSA
//
//  Created by Евгений Канашкин on 24.05.2025.
//

extension BigInt {
        func toDecimalString() -> String {
                if self.isZero() {
                        return "0"
                }
                
                var number = abs(self)
                var digits: [String] = []
                
                let ten = BigInt(10)
                
                while !number.isZero() {
                        let (quotient, remainder) = number.divMod(ten)
                        digits.append(String(remainder.chunks.first ?? 0))
                        number = quotient
                }
                
                let decimalString = digits.reversed().joined()
                return self.sign == .negative ? "-" + decimalString : decimalString
        }
        
        func toHexString() -> String {
                if self.isZero() {
                        return "0x0"
                }
                
                let hexChunks = chunks.reversed().map { String(format: "%016llx", $0) }
                
                var cleaned = hexChunks
                if let first = hexChunks.first {
                        cleaned[0] = String(first.drop { $0 == "0" })
                }
                
                let hex = cleaned.joined()
                return (sign == .negative ? "-0x" : "0x") + hex
        }
        
        func chunkListHex() -> String {
                return chunks.enumerated().map {
                        String(format: "[%d] = 0x%016llx", $0.offset, $0.element)
                }.joined(separator: "\n")
        }
}
