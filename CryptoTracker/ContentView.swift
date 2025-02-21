//
//  ContentView.swift
//  CryptoTracker
//
//  Created by Din Salehy on 2025-02-20.

 // @StateObject var viewModel = CryptoViewModel() → Uses the ViewModel to get crypto data.
 // List(viewModel.cryptos) → Displays a list of cryptocurrencies.
 // AsyncImage(url: URL(string: crypto.image)) → Loads the coin's image.
 // Text(crypto.name) → Displays the name (e.g., "Bitcoin").
 // Text(crypto.symbol.uppercased()) → Shows the symbol (e.g., "BTC").
 // Text("$\(crypto.current_price, specifier: "%.2f")") → Displays the price with two decimal places.
 // Text("\(crypto.price_change_percentage_24h, specifier: "%.2f")%") → Shows 24-hour price change (green for positive, red for negative).
 // .onAppear { viewModel.fetchCryptos() } → Fetches data when the screen appears.
 

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CryptoViewModel()  // Connect ViewModel

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
            viewModel.fetchCryptos()  // Load data when the view appears
        }
    }
}


#Preview {
    ContentView()
}
