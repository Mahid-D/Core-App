import SwiftUI

struct HomeView: View {
    @State private var showExercises = false
    @StateObject private var quotesManager = QuotesManager()
    
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
                        NavigationLink(destination: ExercisesView(exercises: filteredExercises)) {
                            VStack(spacing: 8) {
                                Image(systemName: "figure.strengthtraining.traditional")
                                    .font(.system(size: 34)) // ✅ Icon size
                            }
                            .padding(.vertical, 2)
                            .padding(.horizontal, 8)
                            //.background(Color(.systemGray6).opacity(0.8))
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
                    
                    // ✅ Other content...
                    Text("\(filteredExercises.count) Exercises • ~15 min")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
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
                
                    NavigationLink(destination: ContentView(viewModel: WorkoutViewModel(exercises: absWorkout))) {
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
    var filteredExercises: [Exercise] {
        absWorkout.filter { !$0.name.contains("Rest") }
    }
}

#Preview {
    HomeView()
}
