import Foundation
import Combine
import AVFoundation

class WorkoutViewModel: ObservableObject {
    @Published var currentIndex = 0
    @Published var timeRemaining: Int
    @Published var isRunning = false
    @Published var isComplete = false

    var exercises: [Exercise]
    // MARK: - Timer & countdown tracking
    private var timerCancellable: AnyCancellable?
    private var startDate: Date?
    private var lastBeepSecond: Int?
    private var previousSecond: Int? // tracks last second ticked

    
    private var beepPlayer: AVAudioPlayer? // plays beep even in silent mode

    init(exercises: [Exercise]) {
        self.exercises = exercises
        self.timeRemaining = exercises.first?.duration ?? 0
        
        setupBeepSound()
        setupAudioSession()
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

        let elapsed = Date().timeIntervalSince(start)
        let duration = TimeInterval(exercises[currentIndex].duration)
        let remainingTime = max(duration - elapsed, 0)
        let currentSecond = Int(ceil(remainingTime)) // get the ceiling to count down correctly

        // Only update once per second
        if previousSecond != currentSecond {
            timeRemaining = currentSecond
            previousSecond = currentSecond
            playCountdownIfNeeded(currentSecond)
        }

        if currentSecond == 0 {
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

    // MARK: - Countdown Beep
    private func playCountdownIfNeeded(_ remaining: Int) {
        if remaining <= 5 && remaining > 0 {
            if lastBeepSecond != remaining {
                beepPlayer?.stop()       // stop previous play
                beepPlayer?.currentTime = 0
                beepPlayer?.play()       // play immediately
                lastBeepSecond = remaining
            }
        }
    }

    
    // MARK: - Audio Setup
    private func setupBeepSound() {
        guard let url = Bundle.main.url(forResource: "beep", withExtension: "mp3") else {
            print("Beep sound not found in bundle")
            return
        }
        do {
            beepPlayer = try AVAudioPlayer(contentsOf: url)
            beepPlayer?.prepareToPlay()
        } catch {
            print("Failed to load beep sound: \(error)")
        }
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to activate audio session: \(error)")
        }
    }

    deinit {
        timerCancellable?.cancel()
    }
}
