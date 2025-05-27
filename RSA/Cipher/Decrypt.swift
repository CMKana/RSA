//
//  Decrypt.swift
//  RSA
//
//  Created by Евгений Канашкин on 27.05.2025.
//

func decrypt(_ encrypted: [BigInt], with d: BigInt, n: BigInt) -> [BigInt] {
        return encrypted.map { $0.modPow(d, n) }
}
