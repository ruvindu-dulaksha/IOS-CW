//
//  EventCardView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import SwiftUI
import EventKit
import EventKitUI

struct EventCardView: View {
    let event: EventItem
    let onTap: () -> Void
    @State private var showingEventDetail = false
    
    var body: some View {
        Button(action: {
            showingEventDetail = true
            onTap()
        }) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(systemName: event.icon)
                        .font(.title2)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .background(
                            Circle()
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [.mainBlue, .blue]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                        )
                    
                    Spacer()
                    
                    Text(event.date)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundColor(.subGreycolor)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(event.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    
                    Text(event.description)
                        .font(.caption)
                        .foregroundColor(.subGreycolor)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }
            }
            .padding(16)
            .frame(width: 280, height: 120)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showingEventDetail) {
            EventDetailSheet(event: event)
                .presentationDetents([.fraction(0.9)])
                        .presentationDragIndicator(.visible)
                        .presentationCornerRadius(24)
                        .presentationBackground(.regularMaterial)
        }
    }
}

struct EventDetailSheet: View {
    let event: EventItem
    @Environment(\.dismiss) private var dismiss
    @State private var showingEventEditView = false
    @State private var eventStore = EKEventStore()
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    
                    VStack {
                        Image(systemName: event.icon)
                            .font(.system(size: 60, weight: .light))
                            .foregroundColor(.white)
                            .frame(width: 120, height: 120)
                            .background(
                                Circle()
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [.mainBlue, .blue]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                            )
                            .shadow(color: .mainBlue.opacity(0.3), radius: 20, x: 0, y: 10)
                    }
                    .padding(.top, 20)
                    
                    
                    VStack(spacing: 20) {
                        
                        VStack(spacing: 8) {
                            Text(event.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                                .multilineTextAlignment(.center)
                            
                            Text(event.date)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.mainBlue)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(
                                    Capsule()
                                        .fill(.mainBlue.opacity(0.1))
                                )
                        }
                        
                    
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("About Event")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            
                            Text(event.description)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .lineSpacing(4)
                        }
                        .padding(.horizontal, 20)
                        
                      
                        VStack(spacing: 12) {
                            EventDetailRow(
                                icon: "calendar",
                                title: "Date & Time",
                                subtitle: event.date,
                                color: .orange
                            )
                            
                            EventDetailRow(
                                icon: "location",
                                title: "Location",
                                subtitle: "NIBM Campus",
                                color: .green
                            )
                            
                            EventDetailRow(
                                icon: "person.2",
                                title: "Organizer",
                                subtitle: "NIBM Student Affairs",
                                color: .purple
                            )
                        }
                        .padding(.horizontal, 20)
                        
                       
                        VStack(spacing: 12) {
                            Button(action: {
                                addToCalendar()
                            }) {
                                HStack {
                                    Image(systemName: "calendar.badge.plus")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("Add to Calendar")
                                        .font(.system(size: 16, weight: .semibold))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.mainBlue, .blue]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                            
                            ShareLink(
                                item: createShareText(),
                                subject: Text(event.title),
                                message: Text("Check out this event!")
                            ) {
                                HStack {
                                    Image(systemName: "square.and.arrow.up")
                                        .font(.system(size: 16, weight: .semibold))
                                    Text("Share Event")
                                        .font(.system(size: 16, weight: .semibold))
                                }
                                .foregroundColor(.mainBlue)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(.mainBlue, lineWidth: 1.5)
                                        .fill(.mainBlue.opacity(0.05))
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.mainBlue)
                }
            }
        }
        .alert("Calendar", isPresented: $showingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .sheet(isPresented: $showingEventEditView) {
            EventEditViewController(event: createCalendarEvent(), eventStore: eventStore)
        }
    }
    

    private func addToCalendar() {
        if #available(iOS 17.0, *) {
            eventStore.requestWriteOnlyAccessToEvents { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        self.saveEventToCalendar()
                    } else {
                        self.showEventEditView()
                    }
                }
            }
        } else {
            eventStore.requestAccess(to: .event) { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        self.saveEventToCalendar()
                    } else {
                        self.showEventEditView()
                    }
                }
            }
        }
    }
    
    private func saveEventToCalendar() {
        let calendarEvent = createCalendarEvent()
        calendarEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(calendarEvent, span: .thisEvent)
            alertMessage = "Event added to calendar successfully!"
            showingAlert = true
        } catch {
            alertMessage = "Failed to add event to calendar: \(error.localizedDescription)"
            showingAlert = true
        }
    }
    
    private func showEventEditView() {
        showingEventEditView = true
    }
    
    private func createCalendarEvent() -> EKEvent {
        let calendarEvent = EKEvent(eventStore: eventStore)
        calendarEvent.title = event.title
        calendarEvent.notes = event.description
        calendarEvent.location = "NIBM Campus"
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        
        if let eventDate = dateFormatter.date(from: event.date) {
            
            let calendar = Calendar.current
            let startComponents = calendar.dateComponents([.year, .month, .day], from: eventDate)
            var startDateComponents = DateComponents()
            startDateComponents.year = startComponents.year
            startDateComponents.month = startComponents.month
            startDateComponents.day = startComponents.day
            startDateComponents.hour = 9
            startDateComponents.minute = 0
            
            if let startDate = calendar.date(from: startDateComponents) {
                calendarEvent.startDate = startDate
                calendarEvent.endDate = calendar.date(byAdding: .hour, value: 2, to: startDate) ?? startDate
            }
        } else {
            
            calendarEvent.startDate = Date()
            calendarEvent.endDate = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
        }
        
        return calendarEvent
    }
    
    private func createShareText() -> String {
        return """
        📅 \(event.title)
        
        📍 Date: \(event.date)
        🏫 Location: NIBM Campus
        
        📝 Description:
        \(event.description)
        
        Organized by NIBM Student Affairs
        """
    }
}

struct EventEditViewController: UIViewControllerRepresentable {
    let event: EKEvent
    let eventStore: EKEventStore
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let eventEditViewController = EKEventEditViewController()
        eventEditViewController.event = event
        eventEditViewController.eventStore = eventStore
        eventEditViewController.editViewDelegate = context.coordinator
        return eventEditViewController
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, EKEventEditViewDelegate {
        let parent: EventEditViewController
        
        init(_ parent: EventEditViewController) {
            self.parent = parent
        }
        
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            parent.dismiss()
        }
    }
}

struct EventDetailRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(color)
                )
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
        )
    }
}

