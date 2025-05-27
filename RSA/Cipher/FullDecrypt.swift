//
//  FullDecrypt.swift
//  RSA
//
//  Created by Евгений Канашкин on 27.05.2025.
//

func fullDecrypt(_ message: [BigInt], key: (BigInt, BigInt), alphabet: String, printDetails: Bool = false) -> String {
        let decryptedMessage: [BigInt] = decrypt(encryptedMessage, with: key.0, n: key.1)
        let decodedMessage: String = decode(decryptedMessage, alphabet)
        
        if printDetails {
                printBigInt(with: ["d", "n"], using: [key.0, key.1], as: .both, separator: .space)
                print()
                printTable(head: "Message:",
                           content: [crptToString(m: encryptedMessage, lL: letterLength),
                                     codeToString(m: decryptedMessage, lL: letterLength),
                                     messToString(m: decodedMessage, lL: letterLength)
                                    ])
                print()
        }
        
        return decodedMessage
}
