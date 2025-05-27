//
//  FullEncrypt.swift
//  RSA
//
//  Created by Евгений Канашкин on 27.05.2025.
//

let letterLength = 32

func RSAFullEncrypt(_ message: String, alphabet: String, printDetails: Bool = false) -> (encryptedMessage: [BigInt], key: (BigInt, BigInt)) {
        
        var (p, q): (BigInt, BigInt)
        var (n, fn): (BigInt, BigInt)
        var (e, d): ((BigInt, BigInt), (BigInt, BigInt))
        
        var encodedMessage: [BigInt] = []
        var encryptedMessage: [BigInt] = []
        var decryptedMessage: [BigInt] = []
        
        repeat {
                
                p = generatePrimeCandidate(in: zero ..< limit)
                q = generatePrimeCandidate(in: zero ..< limit)

                n = p * q
                fn = (p - BigInt(1)) * (q - BigInt(1))

                (e, d) = generateKeyPair(fn: fn, n: n)
                
                encodedMessage = encode(message, alphabet)
                encryptedMessage = encrypt(encodedMessage, with: e.0, n: e.1)
                decryptedMessage = decrypt(encryptedMessage, with: d.0, n: d.1)
                
        } while encodedMessage.first!.chunks.first! != decryptedMessage.first!.chunks.first!
        
        if printDetails {
                printBigInt(with: ["P", "Q"], using: [p, q], as: .both, separator: .space)
                print()
                printBigInt(with: ["n", "ƒ(n)"], using: [n, fn], as: .both, separator: .space)
                print()
                printBigInt(with: ["   e", "n", "d", "n"], using: [e.0, e.1, d.0, d.1], as: .both, separator: .space)
                print()
                printTable(head: "Message:",
                           content: [messToString(m: message, lL: letterLength),
                                     codeToString(m: encodedMessage, lL: letterLength),
                                     crptToString(m: encryptedMessage, lL: letterLength)
//                                     codeToString(m: decryptedMessage, lL: letterLength),
//                                     messToString(m: decode(decryptedMessage, alphabet), lL: letterLength)
                                    ])
                print()
        }
        
        return (encryptedMessage, (d))
}
