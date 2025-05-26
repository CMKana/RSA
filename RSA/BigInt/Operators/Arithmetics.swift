//
//  Arithmetics.swift
//  RSA
//
//  Created by Евгений Канашкин on 23.05.2025.
//

extension BigInt {
        static func + (lhs: BigInt, rhs: BigInt) -> BigInt {
                if lhs.sign == rhs.sign {
                        var lhs = lhs
                        var rhs = rhs
                        var result = BigInt()
                        
                        let maxLength = max(lhs.chunks.count, rhs.chunks.count)
                        
                        
                        lhs.chunks += Array(repeating: 0, count: maxLength - lhs.chunks.count)
                        rhs.chunks += Array(repeating: 0, count: maxLength - rhs.chunks.count)
                        
                        var overflow: UInt64 = 0
                        for i in 0..<maxLength {
                                let (sum1, of1) = lhs.chunks[i].addingReportingOverflow(rhs.chunks[i])
                                let (sum2, of2) = sum1.addingReportingOverflow(overflow)
                                result.chunks.append(sum2)
                                overflow = (of1 || of2) ? 1 : 0
                        }
                        
                        if overflow > 0 {
                                result.chunks.append(overflow)
                        }
                        
                        result.sign = lhs.sign
                        return result.trimZeroes()
                } else {
                        var result: BigInt
                        if lhs.sign == .positive {
                                result = lhs - rhs
                        } else {
                                result = rhs - lhs
                        }
                        return result.trimZeroes()
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
                
                let n = self
                let d = divisor
                
                let nSign = n.sign
                let dSign = d.sign
                
                var nNorm = n.magnitude
                var dNorm = d.magnitude
                
                let dCount = dNorm.count
                
                if dCount == 1 {
                        // Однословный делитель — быстрая версия
                        var remainder: UInt64 = 0
                        var quotientChunks: [UInt64] = []
                        
                        for chunk in nNorm.reversed() {
                                let value = (UInt128(remainder) << 64) | UInt128(chunk)
                                let q = UInt64(value / UInt128(dNorm[0]))
                                remainder = UInt64(value % UInt128(dNorm[0]))
                                quotientChunks.insert(q, at: 0)
                        }
                        
                        let quotient = BigInt(nSign == dSign ? .positive : .negative, quotientChunks).trimZeroes()
                        let rem = BigInt(nSign, [remainder])
                        return (quotient, rem)
                }
                
                // Многословное деление (на основе алгоритма Кнута)
                let shift = dNorm.last!.leadingZeroBitCount
                let d1 = UInt128(1) << 64
                
                dNorm = BigInt.shiftLeftChunks(dNorm, by: shift)
                nNorm = BigInt.shiftLeftChunks(nNorm, by: shift)
                
                var remainderChunks = nNorm
                remainderChunks.append(0) // место под остаток
                
                let m = remainderChunks.count - dNorm.count
                var quotientChunks = [UInt64](repeating: 0, count: m)
                
                for j in (0..<m).reversed() {
                        let rHi = UInt128(remainderChunks[j + dCount])
                        let rLo = UInt128(remainderChunks[j + dCount - 1])
                        var rHat = (rHi << 64) | rLo
                        
                        let dHi = UInt128(dNorm[dCount - 1])
                        var qHat = rHat / dHi
                        rHat %= dHi
                        
                        if qHat > UInt128(UInt64.max) { qHat = UInt128(UInt64.max) }
                        
                        if dCount >= 2 && (j + dCount - 2) < remainderChunks.count {
                                while qHat * UInt128(dNorm[dCount - 2]) > (rHat << 64) + UInt128(remainderChunks[j + dCount - 2]) {
                                        qHat -= 1
                                        rHat += dHi
                                        if rHat >= d1 { break }
                                }
                        }
                        
                        // Умножение делителя на qHat и вычитание
                        var borrow: UInt128 = 0
                        var carry: UInt128 = 0
                        
                        for i in 0..<dCount {
                                let p = UInt128(dNorm[i]) * qHat + carry
                                carry = p >> 64
                                let pLow = UInt64(p & 0xFFFFFFFFFFFFFFFF)
                                
                                let lhs = UInt128(remainderChunks[j + i])
                                let sub = lhs &- UInt128(pLow) &- borrow
                                
                                remainderChunks[j + i] = UInt64(sub & 0xFFFFFFFFFFFFFFFF)
                                borrow = (sub > lhs) ? 1 : 0
                        }
                        
                        let lhs = UInt128(remainderChunks[j + dCount])
                        let sub = lhs &- carry &- borrow
                        remainderChunks[j + dCount] = UInt64(sub & 0xFFFFFFFFFFFFFFFF)
                        let needsCorrection = (sub > lhs)
                        
                        if needsCorrection {
                                qHat -= 1
                                var carry: UInt64 = 0
                                for i in 0..<dCount {
                                        let (sum, overflow) = remainderChunks[j + i].addingReportingOverflow(dNorm[i])
                                        let (sum2, carryOverflow) = sum.addingReportingOverflow(carry)
                                        remainderChunks[j + i] = sum2
                                        carry = (overflow || carryOverflow) ? 1 : 0
                                }
                                var index = j + dCount
                                let (sum, overflow) = remainderChunks[index].addingReportingOverflow(carry)
                                remainderChunks[index] = sum
                                if overflow {
                                        index += 1
                                        while index < remainderChunks.count {
                                                let (newSum, newOverflow) = remainderChunks[index].addingReportingOverflow(1)
                                                remainderChunks[index] = newSum
                                                if !newOverflow { break }
                                                index += 1
                                        }
                                        if index == remainderChunks.count {
                                                remainderChunks.append(1)
                                        }
                                }
                        }
                        
                        quotientChunks[j] = UInt64(qHat)
                }
                
                let quotient = BigInt(nSign == dSign ? .positive : .negative, quotientChunks).trimZeroes()
                let remainderMag = BigInt.shiftRightChunks(remainderChunks.prefix(dCount), by: shift)
                let remainder = BigInt(nSign, Array(remainderMag)).trimZeroes()
                
                return (quotient, remainder)
        }
        
        // Вспомогательные функции для сдвигов
        static func shiftLeftChunks(_ chunks: [UInt64], by bits: Int) -> [UInt64] {
                guard bits > 0 else { return chunks }
                var result: [UInt64] = []
                var carry: UInt64 = 0
                for word in chunks {
                        let shifted = (UInt128(word) << bits) | UInt128(carry)
                        result.append(UInt64(shifted & 0xFFFFFFFFFFFFFFFF))
                        carry = UInt64(shifted >> 64)
                }
                if carry > 0 { result.append(carry) }
                return result
        }
        
        static func shiftRightChunks(_ chunks: ArraySlice<UInt64>, by bits: Int) -> [UInt64] {
                guard bits > 0 else { return Array(chunks) }
                var result: [UInt64] = []
                var carry: UInt64 = 0
                for word in chunks.reversed() {
                        let shifted = (UInt128(word) | (UInt128(carry) << 64)) >> bits
                        result.insert(UInt64(shifted & 0xFFFFFFFFFFFFFFFF), at: 0)
                        carry = word
                }
                return result
        }
        
        private var magnitude: [UInt64] {
                return self.chunks
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
