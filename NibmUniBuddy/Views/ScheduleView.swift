import SwiftUI

struct ScheduleItem {
    let id = UUID()
    let courseCode: String
    let courseTitle: String
    let location: String
    let instructor: String
    let timeSlot: String
}

struct ScheduleView: View {
    @State private var scheduleItems: [ScheduleItem] = [
        ScheduleItem(
            courseCode: "HNDSE23.1F",
            courseTitle: "Internet of things",
            location: "harrison hall - 4th floor",
            instructor: "R. Dulaksha",
            timeSlot: "8.30 a.m - 12.00 , 1.00 p.m - 3.30 p.m"
        ),
        ScheduleItem(
            courseCode: "HNDSE23.1F",
            courseTitle: "Internet of things",
            location: "harrison hall - 4th floor",
            instructor: "R. Dulaksha",
            timeSlot: "8.30 a.m - 12.00 , 1.00 p.m - 3.30 p.m"
        ),
        ScheduleItem(
            courseCode: "HNDSE23.1F",
            courseTitle: "Internet of things",
            location: "harrison hall - 4th floor",
            instructor: "R. Dulaksha",
            timeSlot: "8.30 a.m - 12.00 , 1.00 p.m - 3.30 p.m"
        ),
        ScheduleItem(
            courseCode: "HNDSE23.1F",
            courseTitle: "Internet of things",
            location: "harrison hall - 4th floor",
            instructor: "R. Dulaksha",
            timeSlot: "8.30 a.m - 12.00 , 1.00 p.m - 3.30 p.m"
        ),
        ScheduleItem(
            courseCode: "HNDSE23.1F",
            courseTitle: "Internet of things",
            location: "harrison hall - 4th floor",
            instructor: "R. Dulaksha",
            timeSlot: "8.30 a.m - 12.00 , 1.00 p.m - 3.30 p.m"
        ),
        ScheduleItem(
            courseCode: "HNDSE23.1F",
            courseTitle: "Internet of things",
            location: "harrison hall - 4th floor",
            instructor: "R. Dulaksha",
            timeSlot: "8.30 a.m - 12.00 , 1.00 p.m - 3.30 p.m"
        )
    ]
    
    @State private var showingAddSheet = false
    @State private var selectedItem: ScheduleItem?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Status Bar Area
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 0)
                
                // Header
                HStack {
                    Button(action: {
                        // Notification action
                    }) {
                        Image(systemName: "bell")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium))
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 0) {
                        Text("NIBM ")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.blue)
                        Text("UNI BUDDY")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        // Profile action
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 24))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .background(Color.white)
                
                // Schedule List
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(scheduleItems, id: \.id) { item in
                            ScheduleCard(item: item, selectedItem: $selectedItem)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 100)
                }
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            }
            .navigationBarHidden(true)
            .ignoresSafeArea(.all, edges: .top)
        }
        .sheet(item: $selectedItem) { item in
            ScheduleDetailView(item: item)
        }
        .sheet(isPresented: $showingAddSheet) {
            AddScheduleView(scheduleItems: $scheduleItems)
        }
    }
}

struct ScheduleCard: View {
    let item: ScheduleItem
    @Binding var selectedItem: ScheduleItem?
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.courseCode)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(item.location)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                    
                    Text(item.timeSlot)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(item.courseTitle)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.trailing)
                    
                    Text(item.instructor)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 2)
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.easeInOut(duration: 0.1), value: isPressed)
        .onTapGesture {
            selectedItem = item
        }
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}

struct ScheduleDetailView: View {
    let item: ScheduleItem
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Course Details")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    DetailRow(title: "Course Code", value: item.courseCode)
                    DetailRow(title: "Course Title", value: item.courseTitle)
                    DetailRow(title: "Instructor", value: item.instructor)
                    DetailRow(title: "Location", value: item.location)
                    DetailRow(title: "Time", value: item.timeSlot)
                }
                
                Spacer()
            }
            .padding(20)
            .navigationTitle("Schedule Details")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
            
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 4)
    }
}

struct AddScheduleView: View {
    @Binding var scheduleItems: [ScheduleItem]
    @Environment(\.presentationMode) var presentationMode
    
    @State private var courseCode = ""
    @State private var courseTitle = ""
    @State private var location = ""
    @State private var instructor = ""
    @State private var timeSlot = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Course Information")) {
                    TextField("Course Code", text: $courseCode)
                    TextField("Course Title", text: $courseTitle)
                    TextField("Instructor", text: $instructor)
                }
                
                Section(header: Text("Schedule Details")) {
                    TextField("Location", text: $location)
                    TextField("Time Slot", text: $timeSlot)
                }
            }
            .navigationTitle("Add Schedule")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    let newItem = ScheduleItem(
                        courseCode: courseCode,
                        courseTitle: courseTitle,
                        location: location,
                        instructor: instructor,
                        timeSlot: timeSlot
                    )
                    scheduleItems.append(newItem)
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(courseCode.isEmpty || courseTitle.isEmpty)
            )
        }
    }
}

// Extension to make ScheduleItem identifiable for sheet presentation
extension ScheduleItem: Identifiable {}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
