//
//  Decode.swift
//  RSA
//
//  Created by Евгений Канашкин on 27.05.2025.
//
func decode(_ encodeMessage: [BigInt], _ alphabet: String) -> String {
        
        var outputMessage: String = ""
        for element in encodeMessage {
                
                for character in alphabet {
                        let index: String.Index = alphabet.firstIndex(of: character) ?? alphabet.firstIndex(of: "�")!
                        let number: Int = Int(alphabet.distance(from: alphabet.startIndex, to: index))
                        if BigInt(UInt64(number)) == element {
                                outputMessage += String(character)
                        }
                }
        }
        
        return outputMessage
}
