//
//  main.swift
//  RSA
//
//  Created by Евгений Канашкин on 21.05.2025.
//

import Foundation

let letterLength = 10

let tP16: UInt64 = 65536
let tP20: UInt64 = 1048576
let tP24: UInt64 = 16777216 // 15-45sec
let tP32: UInt64 = 4294967296 // Too long

let zero: BigInt = BigInt([0])
let limit: BigInt = BigInt([tP20])

let alphabet = "� АаБбВвГгДдЕеЁёЖжЗзИиЙйКкЛлМмНнОоПпРрСсТтУуФфХхЦцЧчШшЩщЪъЫыЬьЭэЮюЯя.,!?()-—:;\"'\\/AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz"

let message: String = "˙RSA (аббревиатура от фамилий Rivest, Shamir и Adleman) — криптографический алгоритм с открытым ключом, основывающийся на вычислительной сложности задачи факторизации больших полупростых чисел."
//let message: String = "RSA (аббревиатура от фамилий Rivest, Shamir и Adleman)"
//let message: String = "RSA (аббревиатура от фамилий)"
//let message: String = "RSA — аббревиатура"
//let message: String = "Rsa - R-S-A!"

let (encryptedMessage, encryptKey, decryptKey): ([BigInt],  (BigInt, BigInt), (BigInt, BigInt)) = RSAFullEncrypt(message, alphabet: alphabet, printDetails: true)
let messageNew: String = fullDecrypt(encryptedMessage, key: decryptKey, alphabet: alphabet, printDetails: true)

let easyHackedMessage: String = hackEasy(encryptedMessage, encryptKey, alphabet, printDetails: true)
let hardHackedMessage: String = hackHard(encryptedMessage, encryptKey, alphabet, printDetails: true)

print(message)
print(messageNew)
print(easyHackedMessage)
print(hardHackedMessage)
