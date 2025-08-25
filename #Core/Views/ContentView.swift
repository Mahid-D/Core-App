////
//  ContentView.swift
//  #Core
//
//  Created by Abdallah Mahdi on 21/08/2025.
//
import SwiftUI
import AudioToolbox

struct ContentView: View {
    @StateObject var viewModel: WorkoutViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showCompletion = false

    var body: some View {
        NavigationStack {
            
            
            ZStack {
                // Background
                Image("pic2")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 40) {
                    // Back button
                    HStack {
                        Button(action: { dismiss() }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                Text("Home")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                            }
                            .padding(.bottom, 200)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    VStack(spacing: 8) {
                        Text(titleForCurrentExercise())
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        
                        if let progressText = progressTextForWorkout() {
                            Text(progressText)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                
                    
                    Text("\(viewModel.timeRemaining) sec")
                        .font(.system(size: 80, weight: .bold))
                        .foregroundColor(.white)
                    
                    // Next exercise preview
                    if viewModel.showNextExercisePreview {
                        Text("Next: \(viewModel.exercises[viewModel.currentIndex + 1].name)")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    
                    // Controls
                    HStack(spacing: 16) {
                        // Play / Pause
                        Button {
                            viewModel.isRunning ? viewModel.pause() : viewModel.start()
                        } label: {
                            Image(systemName: viewModel.isRunning ? "pause.fill" : "play.fill")
                                .font(.system(size: 26, weight: .bold))
                                .frame(width: 64, height: 64)
                                .background(Circle().fill(Color.green))
                                .foregroundColor(.white)
                                .shadow(radius: 3, y: 2)
                        }
                        
                        // Skip
                        Button {
                            viewModel.nextExercise()
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.system(size: 50, weight: .bold))
                                .frame(width: 60, height: 44)
                                .foregroundColor(.white)
                                .shadow(radius: 3, y: 2)
                        }
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .navigationBarBackButtonHidden(true)
            }
            .onAppear {
                UIApplication.shared.isIdleTimerDisabled = true  // keeps phone awake
            }
            .onDisappear {
                UIApplication.shared.isIdleTimerDisabled = false // reset when leaving
            }
            .onReceive(viewModel.$isComplete) { completed in
                if completed {
                    showCompletion = true
                    AudioServicesPlaySystemSound(1025) // optional celebration sound
                }
            }
            .fullScreenCover(isPresented: $showCompletion) {
                CompletionView() // replace with your completion view
            }
        }
    }
    private func titleForCurrentExercise() -> String {
        let currentExercise = viewModel.exercises[viewModel.currentIndex]
        
        if currentExercise.name == "Rest" {
            return "Rest"
        } else {
            // Count only non-rest exercises up to currentIndex
            let workoutNumber = viewModel.exercises[0...viewModel.currentIndex]
                .filter { $0.name != "Rest" }
                .count
            
            return "\(workoutNumber). \(currentExercise.name)"
        }
    }
        private func progressTextForWorkout() -> String? {
            let currentExercise = viewModel.exercises[viewModel.currentIndex]
            
            if currentExercise.name == "Rest" {
                return nil // No progress for rest
            } else {
                let workoutNumber = viewModel.exercises[0...viewModel.currentIndex]
                    .filter { $0.name != "Rest" }
                    .count
                let totalWorkouts = viewModel.exercises.filter { $0.name != "Rest" }.count
                
                return "\(workoutNumber)/\(totalWorkouts)"
            }
        
    }


}



#Preview {
    let allExercises = GroupedWorkouts.workouts.values.flatMap { $0 } // flatten all groups
    ContentView(viewModel: WorkoutViewModel(exercises: allExercises))
}

