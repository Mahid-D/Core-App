import Foundation
import Combine
import AudioToolbox

class WorkoutViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var timeRemaining: Int
    @Published var isRunning = false
    @Published var isComplete = false

    var exercises: [Exercise]

    private var timerCancellable: AnyCancellable?
    private var lastBeepSecond: Int? // To avoid overlapping beeps
    private var startDate: Date?

    init(exercises: [Exercise]) {
        self.exercises = exercises
        self.timeRemaining = exercises.first?.duration ?? 0
    }

    /// Show next exercise preview
    var showNextExercisePreview: Bool {
        timeRemaining <= 10 && !isComplete && currentIndex + 1 < exercises.count
    }

    // MARK: - Timer
    func start() {
        guard !isRunning else { return }
        isRunning = true
        startDate = Date()
        
        timerCancellable = Timer.publish(every: 0.2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.tick()
            }
    }
    
    func pause() {
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
    }
    
    private func tick() {
        guard let start = startDate else { return }
        
        let elapsed = Int(Date().timeIntervalSince(start))
        let duration = exercises[currentIndex].duration
        let remaining = max(duration - elapsed, 0)
        
        if remaining != timeRemaining {
            timeRemaining = remaining
            playCountdownIfNeeded()
        }
        
        if timeRemaining == 0 {
            nextExercise()
        }
    }

    func nextExercise() {
        if currentIndex + 1 < exercises.count {
            currentIndex += 1
            timeRemaining = exercises[currentIndex].duration
            startDate = Date()
        } else {
            isComplete = true
            pause()
        }
        lastBeepSecond = nil // reset beep tracker for new exercise
    }

    // MARK: - System Sound Countdown
    private func playCountdownIfNeeded() {
        // Play only if in last 5 seconds and not already played this second
        if timeRemaining <= 5 && timeRemaining > 0 {
            if lastBeepSecond != timeRemaining {
                AudioServicesPlaySystemSound(1052) // Tri-tone, works reliably
                lastBeepSecond = timeRemaining
            }
        }
    }
    
    deinit {
        timerCancellable?.cancel()
    }
}
