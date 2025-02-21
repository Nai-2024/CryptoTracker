//
//  CryptoService.swift
//  CryptoTracker
//
//  Created by Din Salehy on 2025-02-21.
//

import Foundation

class CryptoViewModel: ObservableObject {
    @Published var cryptos: [Crypto] = []  // Store crypto data
    @Published var isLoading = false  // Track loading state

    private let service = CryptoService()  // Create an instance of CryptoService

    init() {
        fetchCryptos()  // Fetch data when ViewModel is created
    }

    func fetchCryptos() {
        isLoading = true  // Start loading
        service.fetchCryptos()  // Call the function from CryptoService

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.cryptos = self.service.cryptos  // Update cryptos list
            self.isLoading = false  // Stop loading
        }
    }
}
