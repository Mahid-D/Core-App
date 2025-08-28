import SwiftUI

struct HomeView: View {
    @State private var showExercises = false
    @StateObject private var quotesManager = QuotesManager()
    
    let allExercises = GroupedWorkouts.workouts.values.flatMap { $0 }


    
    var body: some View {
        NavigationStack {
            
            ZStack {
                // ✅ Background Image
                Image("pic2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    // ✅ Header Bar
                    HStack {
                        NavigationLink(destination: GroupedExercisesView(groupedWorkouts: GroupedWorkouts.workouts)) {
                            VStack(spacing: 8) {
                                Image(systemName: "figure.strengthtraining.traditional")
                                    .font(.system(size: 34))
                            }
                            .padding(.vertical, 2)
                            .padding(.horizontal, 8)
                            .cornerRadius(25)
                        }

                        
                        .disclosureGroupStyle(.automatic)
                        .fixedSize()
                        //.padding(.trailing, 160)
                        
                        NavigationLink(destination: TimerView()) {
                            VStack(spacing: 8) {
                                Label("", systemImage: "timer")
                                    .font(.system(size: 34))
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 12)
                            .cornerRadius(25)
                        }
                        
                        .disclosureGroupStyle(.automatic)
                        .fixedSize()
                        
                        Button(action: {
                            // Profile action
                        }) {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 34))
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(maxWidth: .infinity) // ✅ Force HStack to full width
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    
                    
                    Spacer()
                    Text(quotesManager.currentQuote)
                                           .font(.headline)
                                           .foregroundColor(.white)
                                           .multilineTextAlignment(.center)
                                           .font(.custom("Times New Roman", size: 25).italic())
                                           .padding(.horizontal, 20)
                                           .transition(.opacity)
                                           .animation(.easeInOut(duration: 0.5), value: quotesManager.currentQuote)
                    Spacer(minLength: 0)
                    // Custom Workout Button
                    NavigationLink(destination: GroupedExercisesView(groupedWorkouts: GroupedWorkouts.workouts)
                        .preferredColorScheme(.dark)){
                          Text("Start Custom Workout")
                              .font(.headline)
                              .padding(.vertical, 12)
                              .padding(.horizontal, 40)
                              .background(Color.green.opacity(0.85))
                              .foregroundColor(.white)
                              .cornerRadius(30)
                      }
                  
                Spacer()
                    NavigationLink(
                        destination: ContentView(viewModel: WorkoutViewModel(exercises: randomWorkout()))
                    ) {
                        Text("Start Workout")
                            .font(.headline)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 40)
                            .background(Color.blue.opacity(0.85))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }

                    .padding(.bottom, 20)
            
                }
                
                .frame(maxWidth: .infinity, maxHeight: .infinity) // ✅ Make VStack fill screen
                .padding(.horizontal, 16) // ✅ Adds space from both left and right edges
                .padding(.top, 10)
            }
            .navigationTitle("Home") // ✅ Gives system back button space
            .navigationBarTitleDisplayMode(.inline)
            
            }
        
    }
    
    // ✅ Filtered list: Only exercises, no rests
    //var filteredExercises: [Exercise] {
       // GroupedWorkouts.filter { !$0.name.contains("Rest") }
    //}
    
    func randomWorkout(count: Int = 10, restDuration: Int = 15) -> [Exercise] {
        let exercises = allExercises.shuffled()
        let selected = Array(exercises.prefix(count))
        
        var workoutWithRest: [Exercise] = []
        for (index, exercise) in selected.enumerated() {
            workoutWithRest.append(exercise)
            if index < selected.count - 1 {
                workoutWithRest.append(Exercise(name: "Rest", duration: restDuration, animation: nil))
            }
        }
        
        return workoutWithRest
    }


}

#Preview {
    HomeView()
}
