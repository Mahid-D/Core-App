import SwiftUI

struct GroupedExercisesView: View {
    let groupedWorkouts: [String: [Exercise]]
    
    @State private var expandedGroups: Set<String> = []
    @State private var selectedExercises: Set<Exercise> = []
    @State private var navigateToWorkout = false
    
    var body: some View {
        VStack {
            List {
                ForEach(groupedWorkouts.keys.sorted(), id: \.self) { category in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { expandedGroups.contains(category) },
                            set: { isExpanded in
                                if isExpanded {
                                    expandedGroups.insert(category)
                                } else {
                                    expandedGroups.remove(category)
                                }
                            }
                        ),
                        content: {
                            ForEach(groupedWorkouts[category] ?? []) { exercise in
                                Button(action: {
                                    toggleSelection(exercise)
                                }) {
                                    HStack {
                                        Text(exercise.name)
                                            .foregroundColor(.white)
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
                        },
                        label: {
                            Text(category)
                                .font(.headline)
                                .padding(.vertical, 4)
                        }
                    )
                    .animation(.easeInOut, value: expandedGroups)
                }
            }
            .listStyle(.insetGrouped)
            
            .navigationDestination(isPresented: $navigateToWorkout) {
                startWorkoutView()
            }

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
        .navigationTitle("Strength Workouts")
    }
    
    private func toggleSelection(_ exercise: Exercise) {
        if selectedExercises.contains(exercise) {
            selectedExercises.remove(exercise)
        } else {
            selectedExercises.insert(exercise)
        }
    }
    
    private func startWorkoutView() -> ContentView {
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


// Preview
#Preview {
    GroupedExercisesView(groupedWorkouts: GroupedWorkouts.workouts)
        .preferredColorScheme(.dark)
}
