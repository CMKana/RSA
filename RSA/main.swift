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
let messageNew: String = fullDecrypt(encryptedMessage, key: key, alphabet: alphabet, printDetails: true)
