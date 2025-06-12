import Foundation

struct ScheduleItem: Identifiable {
    let id = UUID()
    let courseCode: String
    let courseTitle: String
    let location: String
    let instructor: String
    let timeSlot: String
}
