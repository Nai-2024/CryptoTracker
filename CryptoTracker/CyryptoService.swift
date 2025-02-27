
//  Created by Din Salehy on 2025-02-20.

import Foundation

class CryptoService: ObservableObject {
    @Published var cryptos: [Crypto] = []  // This will store the fetched crypto data
    
    // Fetch a list of cryptos (e.g., top 10 or more)
    func fetchCryptos(completion: @escaping ([Crypto]) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let safeData = data {
                let decoder = JSONDecoder()
                if let decodedData = try? decoder.decode([Crypto].self, from: safeData) {
                    DispatchQueue.main.async {
                        completion(decodedData)  // Return the decoded list of cryptos
                    }
                } else {
                    completion([])  // Return an empty array if decoding fails
                }
            } else {
                completion([])  // Return an empty array if no data is fetched
            }
        }.resume()
    }

    // If you still want to keep the fetchSingleCrypto method
    func fetchSingleCrypto(completion: @escaping (Crypto?) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let safeData = data {
                let decoder = JSONDecoder()
                if let decodedData = try? decoder.decode([Crypto].self, from: safeData), let crypto = decodedData.first {
                    DispatchQueue.main.async {
                        completion(crypto)
                    }
                } else {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
