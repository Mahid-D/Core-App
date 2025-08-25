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
                
                // Current exercise
                Text(viewModel.exercises[viewModel.currentIndex].name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text("\(viewModel.timeRemaining) sec")
                    .font(.system(size: 80, weight: .bold))
                    .foregroundColor(.white)
                
                // Next exercise preview
                if viewModel.showNextExercisePreview {
                    Text("Nexttttt: \(viewModel.exercises[viewModel.currentIndex + 1].name)")
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



#Preview {
    ContentView(viewModel: WorkoutViewModel(exercises: absWorkout))
}
