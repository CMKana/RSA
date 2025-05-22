//
//  PrintTable.swift
//  RSA
//
//  Created by Евгений Канашкин on 22.05.2025.
//

func printTable<T: FixedWidthInteger>(head: [String], content: [T], leadingZeros: LeadingZeros = .no, separators: Separators = .none) -> Void {
        
        var maxLengthPerColumn: [Int] = []
        
        for element in head {
                maxLengthPerColumn.append(element.count)
        }
        
        var contentString: [String] = []
        
        content.forEach { element in contentString.append(AnyIntToString(element, leadingZeros, separators)) }
        
        for (i, element) in contentString.enumerated() {
                if String(element).count > maxLengthPerColumn[i % head.count] {
                        maxLengthPerColumn[i % head.count] = String(element).count
                }
        }
        
        var tableSeparator: String = ""
        for element in maxLengthPerColumn {
                tableSeparator += String(repeating: "—", count: element) + "+"
        }
        
        var headFormatted: [String] = []
        for (i, element) in head.enumerated() {
                headFormatted.append(element.padding(toLength: maxLengthPerColumn[i], withPad: " ", startingAt: 0))
        }
        
        print(tableSeparator)
        headFormatted.forEach { element in print(element, terminator: "|") }
        print()
        print(tableSeparator)
        for (i, element) in contentString.enumerated() {
                print(String(element).padding(toLength: maxLengthPerColumn[i % head.count], withPad: " ", startingAt: 0), terminator: "|")
                if (i + 1) % head.count == 0 { print() }
        }
        print(tableSeparator)
}
