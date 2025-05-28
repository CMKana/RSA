//
//  hackHard.swift
//  RSA
//
//  Created by Евгений Канашкин on 28.05.2025.
//

func hackHard(_ encryptedMessage: [BigInt], _ encryptKey: (BigInt, BigInt), _ alphabet: String, printDetails: Bool = false) -> String {
        var (p, q): (BigInt, BigInt) = (BigInt(), BigInt())
//        if let (p1, q1) = fermatFactor(encryptKey.1) { (p, q) = (p1, q1) }
        if let (p1, q1) = factorize(encryptKey.1) { (p, q) = (p1, q1) }
        
        let fn = (p - BigInt(1)) * (q - BigInt(1))
        let d = modInverse(encryptKey.0, fn)!
        
        let encodedMessage = decrypt(encryptedMessage, with: d, n: encryptKey.1)
        let hardHackedMessage = decode(encodedMessage, alphabet)
        
        if printDetails {
                printBigInt(with: ["e", "n"], using: [encryptKey.0, encryptKey.1], as: .both, separator: .space)
                print()
                printBigInt(with: ["p", "q", "ƒ(n)", "d"], using: [p, q, fn, d], as: .both, separator: .space)
                print()
                printTable(head: "Message:",
                           content: [crptToString(m: encryptedMessage, lL: letterLength),
                                     messToString(m: hardHackedMessage, lL: letterLength)
                                    ])
        }
        
        return hardHackedMessage
}
