//
//  CompelationView.swift
//  #Core
//
//  Created by Abdallah Mahdi on 21/08/2025.
//

import SwiftUI

struct CompletionView: View {
    @Environment(\.dismiss) var dismiss  // ✅ Access dismiss

    var body: some View {
        VStack(spacing: 30) {
            Text("Workout Complete! 🎉")
                .font(.largeTitle)
                .padding()

            Button(action: {
                dismiss() // Dismiss full-screen cover
            }) {
                Text("Back to Home")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
        }
    }
}

