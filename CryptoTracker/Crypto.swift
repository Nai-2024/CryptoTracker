//
//  Crypto.swift
//  CryptoTracker
//
//  Created by Din Salehy on 2025-02-20.
//

import Foundation

public struct Crypto: Identifiable, Codable {
    
    public let id: String
    public let symbol: String
    public let name: String
    public let current_price: Double
    public let price_change_percentage_24h: Double
    public let image: String
}
