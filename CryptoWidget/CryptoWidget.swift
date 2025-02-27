//
//  CryptoWidget.swift
//  CryptoWidget
//
//  Created by Din Salehy on 2025-02-27.
//

import WidgetKit
import SwiftUI

// Struct for widget entry data
struct CryptoEntry: TimelineEntry {
    let date: Date
    let crypto: Crypto?
}

// Timeline Provider to fetch crypto data
struct CryptoProvider: TimelineProvider {
    func placeholder(in context: Context) -> CryptoEntry {
        CryptoEntry(date: Date(), crypto: nil)  // Placeholder data
    }
    
    func getSnapshot(in context: Context, completion: @escaping (CryptoEntry) -> Void) {
        let dummyCrypto = Crypto(id: "bitcoin", symbol: "btc", name: "Bitcoin", current_price: 50000, price_change_percentage_24h: 2.5, image: "")
        let entry = CryptoEntry(date: Date(), crypto: dummyCrypto)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<CryptoEntry>) -> Void) {
        CryptoService().fetchSingleCrypto { crypto in
            let entry = CryptoEntry(date: Date(), crypto: crypto)
            let timeline = Timeline(entries: [entry], policy: .after(Date().addingTimeInterval(60 * 15)))  // Refresh every 15 minutes
            completion(timeline)
        }
    }
}

// Widget View
struct CryptoWidgetView: View {
    var entry: CryptoEntry
    var body: some View {
        VStack {
            if let crypto = entry.crypto {  // Accessing the crypto object from the entry
                Image("Bitcoin")  // Referencing the Bitcoin image from the asset catalog
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Text(crypto.name)
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("$\(crypto.current_price, specifier: "%.2f")")
                    .font(.title)
                    .foregroundColor(.white)
                
                Text("\(crypto.price_change_percentage_24h, specifier: "%.2f")%")
                    .foregroundColor(crypto.price_change_percentage_24h >= 0 ? .green : .red)
            } else {
                Text("Loading...")
                    .foregroundColor(.white)  // Text color set to white
            }
        }
        .padding()
        .containerBackground(.black, for: .widget) // Sets the background for the entire widget
        .cornerRadius(15)
    }
}

// Widget Definition

struct CryptoWidget: Widget {
    let kind: String = "CryptoWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CryptoProvider()) { entry in
            CryptoWidgetView(entry: entry)
        }
        .configurationDisplayName("Crypto Widget")
        .description("Displays the latest crypto price.")
        .supportedFamilies([.systemSmall, .systemMedium])  // Supports small and medium widgets
    }
}

#Preview {
    CryptoWidgetView(entry: CryptoEntry(
        date: Date(),
        crypto: Crypto(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            current_price: 0.0,
            price_change_percentage_24h: 2.5,
            image: ""
        )
    ))
}
