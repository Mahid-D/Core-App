import SwiftUI
import AVFoundation

struct TimerView: View {
    @State private var selectedDuration: Double = 60
    @State private var timeRemaining: Int = 60
    @State private var isRunning: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Fixed durations
    let durations = [15, 30, 45, 60, 120, 300, 600]
    
    // Audio player
    @State private var player: AVAudioPlayer?
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Timer")
                .font(.largeTitle)
                .padding(.top, 40)
            
            // Picker for preset durations
            Picker("Select Duration", selection: $selectedDuration) {
                ForEach(durations, id: \.self) { sec in
                    Text("\(sec) sec").tag(Double(sec))
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 100)
            
            // Slider for custom duration
            VStack {
                Text("Custom Duration: \(Int(selectedDuration)) sec")
                    .font(.headline)
                
                Slider(value: $selectedDuration, in: 1...3600, step: 1)
                    .accentColor(.blue)
            }
            .padding(.horizontal)
            
            // Countdown display
            Text("\(timeString(from: timeRemaining))")
                .font(.system(size: 90, weight: .bold))
                .padding()
            
            HStack(spacing: 40) {
                // Start / Pause / Resume
                Button(action: {
                    isRunning.toggle()
                    if !isRunning && timeRemaining == 0 {
                        timeRemaining = Int(selectedDuration)
                    }
                }) {
                    Text(isRunning ? "Pause" : (timeRemaining == 0 ? "Start" : "Resume"))
                        .font(.title2)
                        .padding()
                        .background(Color.green.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                
                // Reset
                Button(action: {
                    isRunning = false
                    timeRemaining = Int(selectedDuration)
                }) {
                    Text("Reset")
                        .font(.title2)
                        .padding()
                        .background(Color.red.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
            }
            
            Spacer()
        }
        .navigationTitle("Timer")
        .onReceive(timer) { _ in
            guard isRunning else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                // ✅ Timer ended: stop timer, vibrate, play sound
                isRunning = false
                triggerVibration()
                playSound()
            }
        }
        .onChange(of: selectedDuration) { oldValue, newValue in
            timeRemaining = Int(newValue)
        }
        .padding()
        // Quick preset buttons
        let quickDurations = [15, 30, 45, 60]

        // Add this HStack under Start / Pause / Reset buttons
        HStack(spacing: 20) {
            ForEach(quickDurations, id: \.self) { sec in
                Button(action: {
                    selectedDuration = Double(sec)
                    timeRemaining = sec
                    isRunning = true
                }) {
                    Text("\(sec)s")
                        .font(.headline)
                        .frame(width: 60, height: 60)
                        .background(Color.blue.opacity(0.85))
                        .foregroundColor(.white)
                        .cornerRadius(30) // Rounded
                }
            }
        }

    }
    
    // Convert seconds to mm:ss
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    func triggerVibration() {
        let generator = UINotificationFeedbackGenerator()
        for i in 0..<6 { // 6 vibrations, 0.5s each ~3s
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5) {
                generator.notificationOccurred(.success)
            }
        }
    }

    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {
            // Repeat system sound a few times
            for i in 0..<3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                    AudioServicesPlaySystemSound(SystemSoundID(1322))
                }
            }
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = 0 // plays once, make the mp3 ~3s
            player?.play()
        } catch {
            print("Failed to play sound: \(error.localizedDescription)")
        }
    }

}
