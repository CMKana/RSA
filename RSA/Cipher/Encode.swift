//
//  Encode.swift
//  RSA
//
//  Created by Евгений Канашкин on 27.05.2025.
//

func encode(_ message: String, _ alphabet: String) -> [BigInt] {
        
        var encodedMessage: [BigInt] = []
        for element in message {
                let index: String.Index = alphabet.firstIndex(of: element) ?? alphabet.firstIndex(of: "�")!
                let number: Int = Int(alphabet.distance(from: alphabet.startIndex, to: index))
                encodedMessage.append(BigInt(UInt64(number)))
        }
        
        return encodedMessage
        
}
