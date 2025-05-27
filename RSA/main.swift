//
//  main.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

import Foundation

let zero: BigInt = BigInt([0])
let limit: BigInt = BigInt([0,1])

let alphabet = "�АаБбВвГгДдЕеЁёЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЫыЬьЭэЮюЯя .,!?()-—:;\"'\\/AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz"

//let message: String = "˙RSA (аббревиатура от фамилий Rivest, Shamir и Adleman) — криптографический алгоритм с открытым ключом, основывающийся на вычислительной сложности задачи факторизации больших полупростых чисел."
//let message: String = "RSA (аббревиатура от фамилий Rivest, Shamir и Adleman)"
let message: String = "RSA"

let (encryptedMessage, key): ([BigInt], (BigInt, BigInt)) = RSAFullEncrypt(message, alphabet: alphabet, printDetails: true)



func fullDecrypt(_ message: [BigInt], key: (BigInt, BigInt), alphabet: String, printDetails: Bool = false) -> String {
        let decryptedMessage: [BigInt] = decrypt(encryptedMessage, with: key.0, n: key.1)
        let decodedMessage: String = decode(decryptedMessage, alphabet)
        
        if printDetails {
                
        }
        
        return decodedMessage
}
