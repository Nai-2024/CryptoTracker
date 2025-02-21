
//  Created by Din Salehy on 2025-02-20.

// We create a class CryptoService to fetch crypto prices.
// @Published var cryptos is an empty list that will store crypto data.
// fetchCryptos() does the following:
// Converts the API URL from text to a URL.
// Sends a request to fetch data.
// If data is received, we try to decode it into our Crypto model.
// Updates the list of cryptos (on the main thread) so the UI refreshes.
// .resume() starts the request.

import Foundation

class CryptoService: ObservableObject {
    @Published var cryptos: [Crypto] = []  // This will store the fetched crypto data

    func fetchCryptos() {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"
        let url = URL(string: urlString)!  // Convert string to URL

        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let safeData = data {  // Check if data is received
                let decoder = JSONDecoder()
                if let decodedData = try? decoder.decode([Crypto].self, from: safeData) {
                    DispatchQueue.main.async {
                        self.cryptos = decodedData  // Update cryptos list
                    }
                }
            }
        }.resume()  // Start the network request
    }
}
