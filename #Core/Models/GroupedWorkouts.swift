//
//  GroupedWorkouts.swift
//  #Core
//
//  Created by Abdallah Mahdi on 25/08/2025.
//

import Foundation

// MARK: - Exercise
struct Exercise: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let duration: Int // in seconds
}

// MARK: - Grouped Workouts
struct GroupedWorkouts {
    static var workouts: [String: [Exercise]] {
        return [
            "Crunch Variations": [
                Exercise(name: "Standard crunch", duration: 30),
                Exercise(name: "Bicycle crunch", duration: 30),
                Exercise(name: "Reverse crunch", duration: 30),
                Exercise(name: "Vertical leg crunch", duration: 30),
                Exercise(name: "Cross-body crunch / Oblique crunch", duration: 30),
                Exercise(name: "Stability ball crunch", duration: 30),
                Exercise(name: "Cable crunch", duration: 30)
            ],
            "Sit-Up Variations": [
                Exercise(name: "Standard sit-up", duration: 30),
                Exercise(name: "Weighted sit-up", duration: 30),
                Exercise(name: "Butterfly sit-up", duration: 30),
                Exercise(name: "V-sit / V-up", duration: 30),
                Exercise(name: "Jackknife sit-up", duration: 30)
            ],
            "Planks": [
                Exercise(name: "Standard plank (forearm or high plank)", duration: 30),
                Exercise(name: "Side plank", duration: 30),
                Exercise(name: "Reverse plank", duration: 30),
                Exercise(name: "Plank with leg lift", duration: 30),
                Exercise(name: "Plank with shoulder tap", duration: 30),
                Exercise(name: "Plank to push-up", duration: 30),
                Exercise(name: "Walking plank", duration: 30)
            ],
            "Leg Raise Variations": [
                Exercise(name: "Lying leg raises", duration: 30),
                Exercise(name: "Hanging leg raises", duration: 30),
                Exercise(name: "Hanging knee raises", duration: 30),
                Exercise(name: "Flutter kicks", duration: 30),
                Exercise(name: "Scissor kicks", duration: 30),
                Exercise(name: "Windshield wipers", duration: 30)
            ],
            "Russian Twist Variations": [
                Exercise(name: "Standard Russian twist (bodyweight)", duration: 30),
                Exercise(name: "Weighted Russian twist", duration: 30),
                Exercise(name: "Seated oblique twist", duration: 30),
                Exercise(name: "Medicine ball twist", duration: 30)
            ],
            "Mountain Climbers & Dynamic Moves": [
                Exercise(name: "Standard mountain climbers", duration: 30),
                Exercise(name: "Cross-body mountain climbers", duration: 30),
                Exercise(name: "Spider mountain climbers", duration: 30),
                Exercise(name: "Bear crawl", duration: 30),
                Exercise(name: "Dead bug", duration: 30),
                Exercise(name: "Hollow body hold", duration: 30)
            ],
            "Cable / Machine Exercises": [
                Exercise(name: "Cable crunch", duration: 30),
                Exercise(name: "Standing cable woodchopper", duration: 30),
                Exercise(name: "Pallof press", duration: 30),
                Exercise(name: "Ab machine crunch", duration: 30)
            ],
            "Stability / Ball Exercises": [
                Exercise(name: "Stability ball rollout", duration: 30),
                Exercise(name: "Stability ball knee tuck", duration: 30),
                Exercise(name: "Stability ball pike", duration: 30),
                Exercise(name: "Ab wheel rollout", duration: 30),
                Exercise(name: "Swiss ball stir-the-pot", duration: 30)
            ],
            "Functional / Weighted Moves": [
                Exercise(name: "Medicine ball slam", duration: 30),
                Exercise(name: "Turkish get-up (targets core dynamically)", duration: 30),
                Exercise(name: "Farmer’s carry (engages abs for stabilization)", duration: 30),
                Exercise(name: "Suitcase carry", duration: 30)
            ],
            "Pilates/Yoga Core Moves": [
                Exercise(name: "Boat pose (Navasana)", duration: 30),
                Exercise(name: "Roll-ups", duration: 30),
                Exercise(name: "Leg circles", duration: 30),
                Exercise(name: "Plank variations in yoga", duration: 30),
                Exercise(name: "Side bend stretches", duration: 30)
            ]
        ]
    }
}
