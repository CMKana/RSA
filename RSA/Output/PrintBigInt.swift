//
//  PrintTable.swift
//  RSA
//
//  Created by Евгений Канашкин on 24.05.2025.
//

enum printType {
        case hex
        case decimal
        case both
}

func addZeros(_ string: [String]) -> [String] {
        var string = string
        
        let maxStringLength: Int = string.max(by: { $0.count < $1.count })!.count
        for (i, _) in string.enumerated() {
                string[i] = String(string[i].reversed())
                string[i] = String(string[i].padding(toLength: maxStringLength, withPad: "0", startingAt: 0).reversed())
        }
        
        return string
}

func processSeparators(_ string: [String], as type: printType, separator: Separators) -> [String] {
        
        var string = string
        
        var separatorCharacter: String = ""
        switch separator {
        case .underscore:
                separatorCharacter = "_"
        case .space:
                separatorCharacter = " "
        default:
                break
        }
        
        let separatorLength: Int
        switch type {
        case .decimal:
                separatorLength = 3
        case .hex:
                separatorLength = 4
        default:
                separatorLength = 3
        }
        
        for (i, _) in string.enumerated() {
                
                var temp: String = ""
                
                for (i, c) in string[i].reversed().enumerated() {
                        temp += String(c)
                        if (i + 1) % separatorLength == 0 {
                                temp += separatorCharacter
                        }
                }
                
                if temp.last == separatorCharacter.first! {
                        temp.removeLast()
                }
                
                string[i] = String(temp.reversed())
                
        }
        
        return string
}

func processTableSeparator(maxLengths: [Int]) -> String {
        var result: String = ""
        
        maxLengths.forEach { length in result += String(repeating: "—", count: length) + "+" }
        
        return result
}

func printBigInt(with head: [String],
           using content: [BigInt],
           as printType: printType = .both,
           separator: Separators = .none,
                 leadingZeros: LeadingZeros = .no) -> Void {
        
        precondition(head.count == content.count, "Head count must be equal to content count")
        
        switch printType {
                
        case .both:
                
                var decimalString: [String] = []
                var hexString: [String] = []
                
                content.forEach { element in decimalString.append(element.toDecimalString()) }
                content.forEach { element in hexString.append(element.toHexString()) }
                
                for (i, _) in hexString.enumerated() { hexString[i].removeFirst(2) }
                
                if leadingZeros == .yes {
                        decimalString = addZeros(decimalString)
                        hexString = addZeros(hexString)
                }
                if separator != .none {
                        decimalString = processSeparators(decimalString, as: .decimal, separator: separator)
                        hexString = processSeparators(hexString, as: .hex, separator: separator)
                }
                
                let maxHeadLength: Int = head.max(by: { $0.count < $1.count })!.count
                let maxDecLength: Int = max(decimalString.max(by: { $0.count < $1.count })!.count, "Decimal".count)
                let maxHexLength: Int = max(hexString.max(by: { $0.count < $1.count })!.count, "Hexadecimal".count)
                
                let tableSeparator: String = processTableSeparator(maxLengths: [maxHeadLength, maxDecLength, maxHexLength])
                
                var topFormatted: [String] = []
                topFormatted.append("".padding(toLength: maxHeadLength, withPad: " ", startingAt: 0))
                topFormatted.append("Decimal".padding(toLength: maxDecLength, withPad: " ", startingAt: 0))
                topFormatted.append("Hexadecimal".padding(toLength: maxHexLength, withPad: " ", startingAt: 0))
                
                print(tableSeparator)
                topFormatted.forEach { element in print(element, terminator: "|") }
                print()
                print(tableSeparator)
                
                for (i, _) in head.enumerated() {
                        let newHead: String = String(head[i].reversed())
                        let newDecimal: String = String(decimalString[i].reversed())
                        let newHex: String = String(hexString[i].reversed())
                        print(String(newHead.padding(toLength: maxHeadLength, withPad: " ", startingAt: 0).reversed()), terminator: "|")
                        print(String(newDecimal.padding(toLength: maxDecLength, withPad: " ", startingAt: 0).reversed()), terminator: "|")
                        print(String(newHex.padding(toLength: maxHexLength, withPad: " ", startingAt: 0).reversed()), terminator: "|")
                        print()
                        print(tableSeparator)
                }
                
        case .decimal:
                var decimalString: [String] = []
                
                content.forEach { element in decimalString.append(element.toDecimalString()) }
                
                if leadingZeros == .yes {
                        decimalString = addZeros(decimalString)
                }
                if separator != .none {
                        decimalString = processSeparators(decimalString, as: .decimal, separator: separator)
                }
                
                let maxHeadLength: Int = head.max(by: { $0.count < $1.count })!.count
                let maxDecLength: Int = max(decimalString.max(by: { $0.count < $1.count })!.count, "Decimal".count)
                
                let tableSeparator: String = processTableSeparator(maxLengths: [maxHeadLength, maxDecLength])
                
                var topFormatted: [String] = []
                topFormatted.append("".padding(toLength: maxHeadLength, withPad: " ", startingAt: 0))
                topFormatted.append("Decimal".padding(toLength: maxDecLength, withPad: " ", startingAt: 0))
                
                print(tableSeparator)
                topFormatted.forEach { element in print(element, terminator: "|") }
                print()
                print(tableSeparator)
                
                for (i, _) in head.enumerated() {
                        let newHead: String = String(head[i].reversed())
                        let newDecimal: String = String(decimalString[i].reversed())
                        print(String(newHead.padding(toLength: maxHeadLength, withPad: " ", startingAt: 0).reversed()), terminator: "|")
                        print(String(newDecimal.padding(toLength: maxDecLength, withPad: " ", startingAt: 0).reversed()), terminator: "|")
                        print()
                        print(tableSeparator)
                }
                
        case .hex:
                var hexString: [String] = []
                
                content.forEach { element in hexString.append(element.toHexString()) }
                for (i, _) in hexString.enumerated() { hexString[i].removeFirst(2) }
                
                if leadingZeros == .yes {
                        hexString = addZeros(hexString)
                }
                if separator != .none {
                        hexString = processSeparators(hexString, as: .hex, separator: separator)
                }
                
                let maxHeadLength: Int = head.max(by: { $0.count < $1.count })!.count
                let maxHexLength: Int = max(hexString.max(by: { $0.count < $1.count })!.count, "Hexadecimal".count)
                
                let tableSeparator: String = processTableSeparator(maxLengths: [maxHeadLength, maxHexLength])
                
                var topFormatted: [String] = []
                topFormatted.append("".padding(toLength: maxHeadLength, withPad: " ", startingAt: 0))
                topFormatted.append("Hexadecimal".padding(toLength: maxHexLength, withPad: " ", startingAt: 0))
                
                print(tableSeparator)
                topFormatted.forEach { element in print(element, terminator: "|") }
                print()
                print(tableSeparator)
                
                for (i, _) in head.enumerated() {
                        let newHead: String = String(head[i].reversed())
                        let newHex: String = String(hexString[i].reversed())
                        print(String(newHead.padding(toLength: maxHeadLength, withPad: " ", startingAt: 0).reversed()), terminator: "|")
                        print(String(newHex.padding(toLength: maxHexLength, withPad: " ", startingAt: 0).reversed()), terminator: "|")
                        print()
                        print(tableSeparator)
                }
        }
        
}
