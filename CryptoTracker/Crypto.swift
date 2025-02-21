//
//  Crypto.swift
//  CryptoTracker
//
//  Created by Din Salehy on 2025-02-20.
//

import Foundation

struct Crypto: Identifiable, Codable {
    
    let id: String
    let symbol: String
    let name: String
    let current_price: Double
    let price_change_percentage_24h: Double
    let image: String
}
