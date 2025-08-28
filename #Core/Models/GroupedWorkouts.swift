import Foundation

// MARK: - Exercise
struct Exercise: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let duration: Int // in seconds
    let animation: String? // Lottie animation file name
}

// MARK: - Grouped Workouts
struct GroupedWorkouts {
    static var workouts: [String: [Exercise]] {
        return [
            "Crunch Variations": [
                Exercise(name: "Standard crunch", duration: 30, animation: "standard_crunch"),
                Exercise(name: "Bicycle crunch", duration: 30, animation: "bicycle_crunch"),
                Exercise(name: "Reverse crunch", duration: 30, animation: "reverse_crunch"),
                Exercise(name: "Vertical leg crunch", duration: 30, animation: "vertical_leg_crunch"),
                Exercise(name: "Cross-body crunch / Oblique crunch", duration: 30, animation: "cross_body_crunch"),
                Exercise(name: "Stability ball crunch", duration: 30, animation: "stability_ball_crunch"),
                Exercise(name: "Cable crunch", duration: 30, animation: "cable_crunch")
            ],
            "Sit-Up Variations": [
                Exercise(name: "Standard sit-up", duration: 30, animation: "standard_situp"),
                Exercise(name: "Weighted sit-up", duration: 30, animation: "weighted_situp"),
                Exercise(name: "Butterfly sit-up", duration: 30, animation: "butterfly_situp"),
                Exercise(name: "V-sit / V-up", duration: 30, animation: "v_situp"),
                Exercise(name: "Jackknife sit-up", duration: 30, animation: "jackknife_situp")
            ],
            "Planks": [
                Exercise(name: "Standard plank (forearm or high plank)", duration: 30, animation: "standard_plank"),
                Exercise(name: "Side plank", duration: 30, animation: "side_plank"),
                Exercise(name: "Reverse plank", duration: 30, animation: "reverse_plank"),
                Exercise(name: "Plank with leg lift", duration: 30, animation: "plank_leg_lift"),
                Exercise(name: "Plank with shoulder tap", duration: 30, animation: "plank_shoulder_tap"),
                Exercise(name: "Plank to push-up", duration: 30, animation: "plank_pushup"),
                Exercise(name: "Walking plank", duration: 30, animation: "walking_plank")
            ],
            "Leg Raise Variations": [
                Exercise(name: "Lying leg raises", duration: 30, animation: "lying_leg_raises"),
                Exercise(name: "Hanging leg raises", duration: 30, animation: "hanging_leg_raises"),
                Exercise(name: "Hanging knee raises", duration: 30, animation: "hanging_knee_raises"),
                Exercise(name: "Flutter kicks", duration: 30, animation: "flutter_kicks"),
                Exercise(name: "Scissor kicks", duration: 30, animation: "scissor_kicks"),
                Exercise(name: "Windshield wipers", duration: 30, animation: "windshield_wipers")
            ],
            "Russian Twist Variations": [
                Exercise(name: "Standard Russian twist (bodyweight)", duration: 30, animation: "russian_twist"),
                Exercise(name: "Weighted Russian twist", duration: 30, animation: "weighted_russian_twist"),
                Exercise(name: "Seated oblique twist", duration: 30, animation: "seated_oblique_twist"),
                Exercise(name: "Medicine ball twist", duration: 30, animation: "medicine_ball_twist")
            ],
            "Mountain Climbers & Dynamic Moves": [
                Exercise(name: "Standard mountain climbers", duration: 30, animation: "mountain_climbers"),
                Exercise(name: "Cross-body mountain climbers", duration: 30, animation: "cross_body_mountain_climbers"),
                Exercise(name: "Spider mountain climbers", duration: 30, animation: "spider_mountain_climbers"),
                Exercise(name: "Bear crawl", duration: 30, animation: "bear_crawl"),
                Exercise(name: "Dead bug", duration: 30, animation: "dead_bug"),
                Exercise(name: "Hollow body hold", duration: 30, animation: "hollow_body_hold")
            ],
            "Cable / Machine Exercises": [
                Exercise(name: "Cable crunch", duration: 30, animation: "cable_crunch"),
                Exercise(name: "Standing cable woodchopper", duration: 30, animation: "cable_woodchopper"),
                Exercise(name: "Pallof press", duration: 30, animation: "pallof_press"),
                Exercise(name: "Ab machine crunch", duration: 30, animation: "ab_machine_crunch")
            ],
            "Stability / Ball Exercises": [
                Exercise(name: "Stability ball rollout", duration: 30, animation: "ball_rollout"),
                Exercise(name: "Stability ball knee tuck", duration: 30, animation: "ball_knee_tuck"),
                Exercise(name: "Stability ball pike", duration: 30, animation: "ball_pike"),
                Exercise(name: "Ab wheel rollout", duration: 30, animation: "ab_wheel_rollout"),
                Exercise(name: "Swiss ball stir-the-pot", duration: 30, animation: "stir_the_pot")
            ],
            "Functional / Weighted Moves": [
                Exercise(name: "Medicine ball slam", duration: 30, animation: "medicine_ball_slam"),
                Exercise(name: "Turkish get-up (targets core dynamically)", duration: 30, animation: "turkish_getup"),
                Exercise(name: "Farmer’s carry (engages abs for stabilization)", duration: 30, animation: "farmers_carry"),
                Exercise(name: "Suitcase carry", duration: 30, animation: "suitcase_carry")
            ],
            "Pilates/Yoga Core Moves": [
                Exercise(name: "Boat pose (Navasana)", duration: 30, animation: "boat_pose"),
                Exercise(name: "Roll-ups", duration: 30, animation: "roll_ups"),
                Exercise(name: "Leg circles", duration: 30, animation: "leg_circles"),
                Exercise(name: "Plank variations in yoga", duration: 30, animation: "plank_yoga"),
                Exercise(name: "Side bend stretches", duration: 30, animation: "side_bend_stretch")
            ]
        ]
    }
}
