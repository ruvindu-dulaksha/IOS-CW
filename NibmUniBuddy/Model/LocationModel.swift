import Foundation

struct LocationModel {
    var currentLocation: String = ""
    var targetLocation: String = ""
    
    func generateInstructions() -> [String] {
        let start = currentLocation.isEmpty ? "Student Lounge" : currentLocation
        let end = targetLocation.isEmpty ? "Conference Room" : targetLocation
        
        return [
            "Start at the \(start) on Level 1 (near the sofas and vending machines)",
            "Exit the \(start) and turn right into the central hallway",
            "Walk straight down the hallway until you reach the staircase or elevator area near the Server Room",
            "Take the stairs or elevator up to Level 2",
            "Turn left once you reach Level 2",
            "Continue walking straight down the hallway on Level 2",
            "Locate the \(end) on your right side, directly across from the Faculty Offices",
            "Follow the red path shown on the map for easy navigation"
        ]
    }
}
