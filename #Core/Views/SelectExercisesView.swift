//
//  SelectExercisesView.swift
//  #Core
//
//  Created by Abdallah Mahdi on 25/08/2025.
//

import SwiftUI

struct SelectExercisesView: View {
    let allExercises: [Exercise]   // All available exercises
    @State private var selectedExercises: Set<Exercise> = []
    @State private var navigateToWorkout = false

    var body: some View {
        NavigationStack {
            VStack {
                List(allExercises, id: \.id) { exercise in
                    Button(action: {
                        toggleSelection(exercise)
                    }) {
                        HStack {
                            Text(exercise.name)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedExercises.contains(exercise) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "circle")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .listStyle(.insetGrouped)
                
                .navigationDestination(isPresented: $navigateToWorkout) {
                    startWorkoutView()
                }

                // Start Workout Button
                Button("Start Workout") {
                    if !selectedExercises.isEmpty {
                        navigateToWorkout = true
                    }
                }
                .disabled(selectedExercises.isEmpty)
                .padding()
                .background(selectedExercises.isEmpty ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom)
            }
            .navigationTitle("Select Exercises")
        }
    }

    private func toggleSelection(_ exercise: Exercise) {
        if selectedExercises.contains(exercise) {
            selectedExercises.remove(exercise)
        } else {
            selectedExercises.insert(exercise)
        }
    }

    private func startWorkoutView() -> ContentView {
        // Insert 15s rests between selected exercises
        var workout: [Exercise] = []
        let restDuration = 15
        let selected = Array(selectedExercises)
        for (index, ex) in selected.enumerated() {
            workout.append(ex)
            if index < selected.count - 1 {
                workout.append(Exercise(name: "Rest", duration: restDuration))
            }
        }
        return ContentView(viewModel: WorkoutViewModel(exercises: workout))
    }
}
// ✅ Preview
#Preview {
    let sampleExercises = [
        Exercise(name: "Crunch", duration: 30),
        Exercise(name: "Plank", duration: 45),
        Exercise(name: "Sit-Up", duration: 30),
        Exercise(name: "Bicycle Crunch", duration: 30),
        Exercise(name: "Leg Raise", duration: 30)
    ]
    SelectExercisesView(allExercises: sampleExercises)
        .preferredColorScheme(.dark)
}
