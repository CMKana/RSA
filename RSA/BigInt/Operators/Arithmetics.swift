//
//  Arithmetics.swift
//  RSA
//
//  Created by Евгений Канашкин on 23.05.2025.
//

extension BigInt {
        static func + (lhs: BigInt, rhs: BigInt) -> BigInt {
                
                if lhs.sign == rhs.sign {
                        
                        
                        var lhs: BigInt = lhs
                        var rhs: BigInt = rhs
                        
                        
                        var result: BigInt = BigInt()
                        
                        let maxLength = max(lhs.chunks.count, rhs.chunks.count)
                        let minLength = min(lhs.chunks.count, rhs.chunks.count)
                        
                        if rhs > lhs { (lhs, rhs) = (rhs, lhs) }
                        
                        var overflow: UInt64 = 0
                        
                        for i in (0 ..< minLength) {
                                let newChunk: UInt128 = UInt128(lhs.chunks[i]) + UInt128(rhs.chunks[i]) + UInt128(overflow)
                                overflow = UInt64(newChunk >> 64)
                                let goodChunk: UInt128 = newChunk - (UInt128(overflow) << 64)
                                result.chunks.append(UInt64(goodChunk))
                        }
                        
                        for i in (minLength ..< maxLength) {
                                
                                switch (lhs.chunks[i].addingReportingOverflow(overflow)) {
                                case (let newValue, false):
                                        result.chunks.append(newValue)
                                        overflow = 0
                                case (let newValue, true):
                                        result.chunks.append(newValue)
                                        overflow = 1
                                }
                        }
                        
                        if overflow == 1 {
                                result.chunks.append(1)
                        }
                        
                        result.sign = lhs.sign
                        
                        return result.trimZeroes()
                } else {
                        
                        var result: BigInt
                        
                        if lhs.sign == .positive {
                                result = BigInt(lhs.chunks) - BigInt(rhs.chunks).trimZeroes()
                                return result
                        } else {
                                result = (BigInt(rhs.chunks) - BigInt(lhs.chunks)).trimZeroes()
                                return result
                        }
                        
                }
                
        }
        
        static func - (lhs: BigInt, rhs: BigInt) -> BigInt {
                if lhs.sign == rhs.sign {
                        if lhs == rhs {
                                return BigInt(.positive, [0])
                        }
                        
                        var left = lhs
                        var right = rhs
                        var resultChunks: [UInt64] = []
                        
                        let maxLength = max(left.chunks.count, right.chunks.count)
                        while left.chunks.count < maxLength {
                                left.chunks.append(0)
                        }
                        while right.chunks.count < maxLength {
                                right.chunks.append(0)
                        }
                        
                        let isNegativeResult = left < right
                        if isNegativeResult {
                                swap(&left, &right)
                        }
                        
                        var borrow: UInt64 = 0
                        for i in 0..<maxLength {
                                let l = left.chunks[i]
                                let r = right.chunks[i]
                                var sub: UInt64
                                if l >= r + borrow {
                                        sub = l - r - borrow
                                        borrow = 0
                                } else {
                                        sub = l &+ (~r &+ 1) &- borrow
                                        borrow = 1
                                }
                                resultChunks.append(sub)
                        }
                        
                        // Удалим ведущие нули
                        while resultChunks.last == 0 && resultChunks.count > 1 {
                                resultChunks.removeLast()
                        }
                        
                        return BigInt(
                                isNegativeResult ? .negative : .positive,
                                resultChunks
                                
                        )
                } else {
                        return lhs + (-rhs)
                }
        }

        static prefix func - (lhs: BigInt) -> BigInt {
                switch lhs.sign {
                case .positive:
                        return BigInt(.negative, lhs.chunks)
                case .negative:
                        return BigInt(.positive, lhs.chunks)
                }
        }
}

extension BigInt {
        func divMod(_ divisor: BigInt) -> (quotient: BigInt, remainder: BigInt) {
                precondition(!divisor.isZero(), "Division by zero")
                
                let resultSign: Sign = (self.sign == divisor.sign) ? .positive : .negative
                let remainderSign: Sign = self.sign
                
                let dividend = self.magnitude()
                let divisor = divisor.magnitude()
                
                if dividend < divisor {
                        return (BigInt(.positive, [0]), self)
                }
                
                var quotientChunks: [UInt64] = Array(repeating: 0, count: dividend.chunks.count - divisor.chunks.count + 1)
                var remainderChunks = dividend.chunks + [0]
                
                let d = divisor.chunks
                let dCount = d.count
                let m = quotientChunks.count
                
                let shift = d.last!.leadingZeroBitCount
                let normDivisor = divisor << shift
                let normRemainder = BigInt(.positive, remainderChunks) << shift
                remainderChunks = normRemainder.chunks + [0]
                
                let dNorm = normDivisor.chunks
                
                for j in stride(from: m - 1, through: 0, by: -1) {
                        let top2 = UInt128(remainderChunks[j + dCount]) << 64 | UInt128(remainderChunks[j + dCount - 1])
                        let d1 = UInt128(dNorm[dCount - 1])
                        
                        var qHat = top2 / d1
                        if qHat > UInt128(UInt64.max) { qHat = UInt128(UInt64.max) }
                        var rHat = top2 % d1
                        
                        // MARK: - переполнение \/
                        while qHat * UInt128(dNorm[dCount - 2]) > (rHat << 64) + UInt128(remainderChunks[j + dCount - 2]) {
                                qHat -= 1
                                rHat += d1
                                if rHat >= (1 << 64) { break }
                        }
                        
                        var borrow: UInt64 = 0
                        var carry: UInt64 = 0
                        for i in 0..<dCount {
                                let prod = UInt128(UInt64(qHat)) * UInt128(dNorm[i]) + UInt128(carry)
                                let pLow = UInt64(prod & 0xFFFFFFFFFFFFFFFF)
                                carry = UInt64(prod >> 64)
                                
                                let subtrahend = UInt128(pLow) + UInt128(borrow)
                                var chunk = UInt128(remainderChunks[j + i])
                                
                                if chunk >= subtrahend {
                                        chunk -= subtrahend
                                        borrow = 0
                                } else {
                                        chunk += UInt128(1) << 64
                                        chunk -= subtrahend
                                        borrow = 1
                                }
                                
                                remainderChunks[j + i] = UInt64(chunk)
                        }
                        
                        let finalChunk = UInt128(remainderChunks[j + dCount])
                        let finalSub = UInt128(carry) + UInt128(borrow)
                        if finalChunk >= finalSub {
                                remainderChunks[j + dCount] = UInt64(finalChunk - finalSub)
                                quotientChunks[j] = UInt64(qHat)
                        } else {
                                quotientChunks[j] = UInt64(qHat) - 1
                                
                                var carry: UInt64 = 0
                                for i in 0..<dCount {
                                        let sum = UInt128(remainderChunks[j + i]) + UInt128(dNorm[i]) + UInt128(carry)
                                        remainderChunks[j + i] = UInt64(sum & 0xFFFFFFFFFFFFFFFF)
                                        carry = UInt64(sum >> 64)
                                }
                                remainderChunks[j + dCount] += carry
                        }
                }
                
                let rawQuotient = BigInt(resultSign, quotientChunks).trimZeroes()
                let rawRemainder = (BigInt(.positive, Array(remainderChunks.prefix(dCount))) >> shift).withSign(remainderSign).trimZeroes()
                
                return (rawQuotient, rawRemainder)
        }
        
        private func magnitude() -> BigInt {
                return BigInt(.positive, self.chunks)
        }
        
        private func withSign(_ sign: Sign) -> BigInt {
                var copy = self
                copy.sign = self.isZero() ? .positive : sign
                return copy
        }
}

extension BigInt {
        static func * (lhs: BigInt, rhs: BigInt) -> BigInt {
                var result = BigInt()
                result.chunks = Array(repeating: 0, count: lhs.chunks.count + rhs.chunks.count)
                
                for i in 0..<lhs.chunks.count {
                        var carry: UInt64 = 0
                        for j in 0..<rhs.chunks.count {
                                let index = i + j
                                let lhsChunk = UInt128(lhs.chunks[i])
                                let rhsChunk = UInt128(rhs.chunks[j])
                                let product = lhsChunk * rhsChunk + UInt128(result.chunks[index]) + UInt128(carry)
                                
                                result.chunks[index] = UInt64(product & 0xFFFFFFFFFFFFFFFF)
                                carry = UInt64(product >> 64)
                        }
                        if carry > 0 {
                                result.chunks[i + rhs.chunks.count] += carry
                        }
                }
                
                result.sign = (lhs.sign == rhs.sign) ? .positive : .negative
                return result.trimZeroes()
        }
}

extension BigInt {
        static func / (lhs: BigInt, rhs: BigInt) -> BigInt {
                return lhs.divMod(rhs).quotient
        }
        
        static func % (lhs: BigInt, rhs: BigInt) -> BigInt {
                return lhs.divMod(rhs).remainder
        }
}
