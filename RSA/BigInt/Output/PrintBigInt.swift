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
                        
                        /// Dec
                        
                        let maxDecimalStringLength: Int = decimalString.max(by: { $0.count < $1.count })!.count
                        for (i, _) in decimalString.enumerated() {
                                decimalString[i] = String(decimalString[i].reversed())
                                decimalString[i] = String(decimalString[i].padding(toLength: maxDecimalStringLength, withPad: "0", startingAt: 0).reversed())
                        }
                        
                        /// Hex
                        
                        let maxHexStringLength: Int = hexString.max(by: { $0.count < $1.count })!.count
                        for (i, _) in hexString.enumerated() {
                                hexString[i] = String(hexString[i].reversed())
                                hexString[i] = String(hexString[i].padding(toLength: maxHexStringLength, withPad: "0", startingAt: 0).reversed())
                        }
                }
                
                if separator != .none {
                        
                        var separatorCharacter: String = " "
                        switch separator {
                        case .underscore:
                                separatorCharacter = "_"
                        case .space:
                                separatorCharacter = " "
                        default:
                                break
                        }
                        
                        /// Dec
                        
                        for (i, _) in decimalString.enumerated() {
                                
                                var temp: String = ""
                                
                                for (i, c) in decimalString[i].reversed().enumerated() {
                                        temp += String(c)
                                        if (i + 1) % 3 == 0 {
                                                temp += separatorCharacter
                                        }
                                }
                                
                                if temp.last == separatorCharacter.first! {
                                        temp.removeLast()
                                }
                                
                                decimalString[i] = String(temp.reversed())
                                
                        }
                        
                        /// Hex
                        
                        for (i, _) in hexString.enumerated() {
                                
                                var temp: String = ""
                                
                                for (i, c) in hexString[i].reversed().enumerated() {
                                        temp += String(c)
                                        if (i + 1) % 4 == 0 {
                                                temp += separatorCharacter
                                        }
                                }
                                
                                if temp.last == separatorCharacter.first! {
                                        temp.removeLast()
                                }
                                
                                hexString[i] = String(temp.reversed())
                                
                        }
                        
                }
                
                let maxHeadLength: Int = head.max(by: { $0.count < $1.count })!.count
                let maxDecLength: Int = max(decimalString.max(by: { $0.count < $1.count })!.count, "Decimal".count)
                let maxHexLength: Int = max(hexString.max(by: { $0.count < $1.count })!.count, "Hexadecimal".count)
                
                let tableSeparator: String = String(repeating: "—", count: maxHeadLength) + "+" +
                String(repeating: "—", count: maxDecLength) + "+" +
                String(repeating: "—", count: maxHexLength) + "+"
                
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
                        
                        /// Dec
                        
                        let maxDecimalStringLength: Int = decimalString.max(by: { $0.count < $1.count })!.count
                        for (i, _) in decimalString.enumerated() {
                                decimalString[i] = String(decimalString[i].reversed())
                                decimalString[i] = String(decimalString[i].padding(toLength: maxDecimalStringLength, withPad: "0", startingAt: 0).reversed())
                        }
                }
                
                if separator != .none {
                        
                        var separatorCharacter: String = " "
                        switch separator {
                        case .underscore:
                                separatorCharacter = "_"
                        case .space:
                                separatorCharacter = " "
                        default:
                                break
                        }
                        
                        /// Dec
                        
                        for (i, _) in decimalString.enumerated() {
                                
                                var temp: String = ""
                                
                                for (i, c) in decimalString[i].reversed().enumerated() {
                                        temp += String(c)
                                        if (i + 1) % 3 == 0 {
                                                temp += separatorCharacter
                                        }
                                }
                                
                                if temp.last == separatorCharacter.first! {
                                        temp.removeLast()
                                }
                                
                                decimalString[i] = String(temp.reversed())
                                
                        }
                        
                }
                
                let maxHeadLength: Int = head.max(by: { $0.count < $1.count })!.count
                let maxDecLength: Int = max(decimalString.max(by: { $0.count < $1.count })!.count, "Decimal".count)
                
                let tableSeparator: String = String(repeating: "—", count: maxHeadLength) + "+" +
                String(repeating: "—", count: maxDecLength) + "+"
                
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
                        
                        /// Hex
                        
                        let maxHexStringLength: Int = hexString.max(by: { $0.count < $1.count })!.count
                        for (i, _) in hexString.enumerated() {
                                hexString[i] = String(hexString[i].reversed())
                                hexString[i] = String(hexString[i].padding(toLength: maxHexStringLength, withPad: "0", startingAt: 0).reversed())
                        }
                }
                
                if separator != .none {
                        
                        var separatorCharacter: String = " "
                        switch separator {
                        case .underscore:
                                separatorCharacter = "_"
                        case .space:
                                separatorCharacter = " "
                        default:
                                break
                        }
                        
                        /// Hex
                        
                        for (i, _) in hexString.enumerated() {
                                
                                var temp: String = ""
                                
                                for (i, c) in hexString[i].reversed().enumerated() {
                                        temp += String(c)
                                        if (i + 1) % 4 == 0 {
                                                temp += separatorCharacter
                                        }
                                }
                                
                                if temp.last == separatorCharacter.first! {
                                        temp.removeLast()
                                }
                                
                                hexString[i] = String(temp.reversed())
                                
                        }
                        
                }
                
                let maxHeadLength: Int = head.max(by: { $0.count < $1.count })!.count
                let maxHexLength: Int = max(hexString.max(by: { $0.count < $1.count })!.count, "Hexadecimal".count)
                
                let tableSeparator: String = String(repeating: "—", count: maxHeadLength) + "+" +
                String(repeating: "—", count: maxHexLength) + "+"
                
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
