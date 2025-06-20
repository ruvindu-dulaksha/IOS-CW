import SwiftUI

struct ScheduleCard: View {
    let item: ScheduleItem
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
        .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
            isPressed = pressing
        }, perform: {})
    }
}
