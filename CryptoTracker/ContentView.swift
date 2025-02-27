//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Din Salehy on 2025-02-20.

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CryptoViewModel()  // Connect ViewModel
      @State private var crypto: Crypto?  // Add a state variable to store the fetched crypto
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Fetching Data...")  // Show loading indicator
                        .padding()
                } else {
                    List {
                        ForEach(viewModel.cryptos) { crypto in  // Show crypto list
                            HStack {
                                AsyncImage(url: URL(string: crypto.image)) { image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                } placeholder: {
                                    ProgressView()  // Show a loading indicator while the image loads
                                }
                                .frame(width: 30, height: 30)
                                .clipShape(Circle())  // Optional: Makes the image circular
                                
                                
                                VStack(alignment: .leading) {
                                    Text(crypto.name)  // Show crypto name
                                        .font(.headline)
                                    Text(crypto.symbol.uppercased())  // Show symbol
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                VStack(alignment: .trailing) {
                                    Text("$\(crypto.current_price, specifier: "%.2f")")  // Show price
                                        .font(.headline)
                                    Text("\(crypto.price_change_percentage_24h, specifier: "%.2f")%")
                                        .font(.subheadline)
                                        .foregroundColor(crypto.price_change_percentage_24h >= 0 ? .green : .red)
                                }
                            }
                            .padding(5)
                        }
                    }
                    .refreshable {
                        viewModel.fetchCryptos()
                    }
                }
            }
            .navigationTitle("Crypto Prices")  // Set screen title
        }
        .onAppear {
            // Call the fetch function when the view appears
            CryptoService().fetchSingleCrypto { fetchedCrypto in
                self.crypto = fetchedCrypto
            }
        }
    }
}
    
    #Preview {
        ContentView()
    }
