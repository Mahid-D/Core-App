//
//  QuotesManager.swift
//  #Core
//
//  Created by Abdallah Mahdi on 22/08/2025.
//

import Foundation
import SwiftUI
import Combine

class QuotesManager: ObservableObject {
    @Published var currentQuote: String = ""
    private var quotes: [String] = []
    private var timer: Timer?

    init() {
        loadQuotes()
        startRandomQuoteTimer()
    }

    private func loadQuotes() {
        if let url = Bundle.main.url(forResource: "quotes", withExtension: "json") {
            if let data = try? Data(contentsOf: url) {
                quotes = (try? JSONDecoder().decode([String].self, from: data)) ?? []
            }
        }
        currentQuote = quotes.randomElement() ?? ""
    }

    private func startRandomQuoteTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true) { _ in
            self.currentQuote = self.quotes.randomElement() ?? ""
        }
    }

    deinit {
        timer?.invalidate()
    }
}
