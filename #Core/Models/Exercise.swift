//
//  Exercise.swift
//  #Core
//
//  Created by Abdallah Mahdi on 21/08/2025.
//

import Foundation

struct Exercise: Identifiable {
    let id = UUID()
    let name: String
    let duration: Int // in seconds
}

let absWorkout: [Exercise] = [
    Exercise(name: "Dead Bug", duration: 45),
    Exercise(name: "Rest", duration: 15),
    Exercise(name: "Hollow Body Hold", duration: 45),
    Exercise(name: "Rest", duration: 15),
    Exercise(name: "Leg Raises", duration: 45),
    Exercise(name: "Rest", duration: 15),
    Exercise(name: "Bicycle Crunch", duration: 45),
    Exercise(name: "Rest", duration: 15),
    Exercise(name: "Side Plank Right", duration: 45),
    Exercise(name: "Rest", duration: 15),
    Exercise(name: "Side Plank Left", duration: 45),
    Exercise(name: "Rest", duration: 15),
    Exercise(name: "Plank with Shoulder Taps", duration: 45)
]
