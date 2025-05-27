//
//  Encrypt.swift
//  RSA
//
//  Created by Евгений Канашкин on 27.05.2025.
//

func encrypt(_ message: [BigInt], with e: BigInt, n: BigInt) -> [BigInt] {
        return message.map { $0.modPow(e, n) }
}
