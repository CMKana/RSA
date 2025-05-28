//
//  hackEasy.swift
//  RSA
//
//  Created by Евгений Канашкин on 28.05.2025.
//

func hackEasy(_ encryptedMessage: [BigInt], _ encryptKey: (BigInt, BigInt), _ alphabet: String, printDetails: Bool = false) -> String {
        
        var encryptedAlphabet: [BigInt] = []
        
        for letter in alphabet {
                
                let letterString: String = String(letter)
                let encodedLetter: [BigInt] = encode(letterString, alphabet)
                let encryptedLetter: [BigInt] = encrypt(encodedLetter, with: encryptKey.0, n: encryptKey.1)
                
                encryptedAlphabet.append(encryptedLetter.first!)
        }
        
        var message: String = ""
        
        for letter in encryptedMessage {
                
                for (i, letter2) in encryptedAlphabet.enumerated() {
                        
                        if letter == letter2 {
                                
                                let arrAlph: [Character] = Array(alphabet)
                                
                                message += String(arrAlph[i])
                                
                        }
                        
                }
                
        }
        
        if printDetails {
                printBigInt(with: ["e", "n"], using: [encryptKey.0, encryptKey.1], as: .both, separator: .space)
                
                var alphabetString: String = ""
                var alphabetEncoded: [BigInt] = []
                var alphabetEncrypted: [BigInt] = []
                for i in 0 ..< 5 {
                        
                        let letterString: String = String(Array(alphabet)[i])
                        alphabetString.append(letterString)

                        let alphabetEncode: [BigInt] = encode(letterString, alphabet)
                        alphabetEncoded.append(alphabetEncode.first!)

                        let alphabetEncrypt: [BigInt] = encrypt(alphabetEncode, with: encryptKey.0, n: encryptKey.1)
                        alphabetEncrypted.append(alphabetEncrypt.first!)
                }
                
                print()
                printTable(head: "Alphabet Decrypted:",
                           content: [messToString(m: alphabetString, lL: letterLength),
                                     codeToString(m: alphabetEncoded, lL: letterLength),
                                     crptToString(m: alphabetEncrypted, lL: letterLength)
                                    ])
                print()
                
                printTable(head: "Message:",
                           content: [crptToString(m: encryptedMessage, lL: letterLength),
                                     messToString(m: message, lL: letterLength)
                                    ])
        }
        
        return message
}
