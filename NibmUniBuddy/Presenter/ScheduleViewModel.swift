import Foundation

class  ScheduleViewModel: ObservableObject {
    @Published var scheduleItems: [ScheduleItem] = [
        ScheduleItem(
            courseCode: "HNDSE23.1F",
            courseTitle: "Internet of Things",
            location: "Harrison Hall - 4th Floor",
            instructor: "R. Dulaksha",
            timeSlot: "8:30 a.m - 12:00, 1:00 p.m - 3:30 p.m"
        ),
        ScheduleItem(
            courseCode: "HNDSE23.1F",
            courseTitle: "Internet of Things",
            location: "Harrison Hall - 4th Floor",
            instructor: "R. Dulaksha",
            timeSlot: "8:30 a.m - 12:00, 1:00 p.m - 3:30 p.m"
        ),
        ScheduleItem(
            courseCode: "HNDSE23.1F",
            courseTitle: "Internet of Things",
            location: "Harrison Hall - 4th Floor",
            instructor: "R. Dulaksha",
            timeSlot: "8:30 a.m - 12:00, 1:00 p.m - 3:30 p.m"
        )
    ]
}
