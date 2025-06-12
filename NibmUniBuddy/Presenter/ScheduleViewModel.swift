import Foundation

class  ScheduleViewModel: ObservableObject {
    @Published var scheduleItems: [ScheduleItem] = [
        ScheduleItem(
                courseCode: "HNDSE23.1F",
                courseTitle: "Internet of Things",
                location: "Harrison Hall - 4th Floor",
                instructor: "R. Dulaksha",
                timeSlot: "8:30 a.m - 12:00 p.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.2F",
                courseTitle: "Mobile Application Development",
                location: "Tech Building - Lab 3",
                instructor: "N. Perera",
                timeSlot: "1:00 p.m - 4:00 p.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.3F",
                courseTitle: "Software Engineering Principles",
                location: "Main Campus - Room 210",
                instructor: "S. Fernando",
                timeSlot: "10:00 a.m - 12:00 p.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.4F",
                courseTitle: "Database Systems",
                location: "Library Block - Room 12",
                instructor: "T. Bandara",
                timeSlot: "2:00 p.m - 5:00 p.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.5F",
                courseTitle: "Operating Systems",
                location: "Engineering Tower - Room 101",
                instructor: "K. Jayasuriya",
                timeSlot: "9:00 a.m - 11:30 a.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.6F",
                courseTitle: "Computer Networks",
                location: "Networking Lab - Room 5B",
                instructor: "D. Silva",
                timeSlot: "11:00 a.m - 1:30 p.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.7F",
                courseTitle: "Cybersecurity Fundamentals",
                location: "Security Center - Lab A",
                instructor: "Y. Gunasekara",
                timeSlot: "3:00 p.m - 6:00 p.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.8F",
                courseTitle: "Artificial Intelligence",
                location: "Innovation Hub - Room 207",
                instructor: "M. Ranatunga",
                timeSlot: "8:00 a.m - 10:00 a.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.9F",
                courseTitle: "Cloud Computing",
                location: "Sky Lab - Floor 6",
                instructor: "P. Rajapaksha",
                timeSlot: "1:30 p.m - 4:30 p.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.10F",
                courseTitle: "Machine Learning",
                location: "AI Lab - Room 9",
                instructor: "C. Wijesinghe",
                timeSlot: "10:00 a.m - 12:30 p.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.11F",
                courseTitle: "Data Structures & Algorithms",
                location: "Computer Science Block - 2nd Floor",
                instructor: "R. Abeywickrama",
                timeSlot: "9:00 a.m - 11:00 a.m"
            ),
            ScheduleItem(
                courseCode: "HNDSE23.12F",
                courseTitle: "Web Technologies",
                location: "Web Lab - Room 14",
                instructor: "J. Liyanage",
                timeSlot: "2:00 p.m - 5:00 p.m"
            )
    ]
}
