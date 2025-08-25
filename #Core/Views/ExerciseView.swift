//
//  ExerciseView.swift
//  #Core
//
//  Created by Abdallah Mahdi on 22/08/2025.
//

import SwiftUI

struct ExercisesView: View {
    let exercises: [Exercise]
    
    var body: some View {
        List(exercises) { exercise in
            HStack {
                Image(systemName: "figure.strengthtraining.traditional")
                    .foregroundColor(.blue)
                Text(exercise.name)
                Spacer()
                Text("\(exercise.duration) sec")
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Exercises")
        
    }
}
