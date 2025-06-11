import SwiftUI


struct HeaderView: View {
    let brandColor: Color
    let dismissAction: () -> Void
    
    var body: some View {
        ZStack {
            Text("Reservation")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(brandColor)
            
            HStack {
                Button(action: dismissAction) {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                    .foregroundColor(brandColor)
                }
                Spacer()
            }
        }
        .padding()
    }
}

struct ReservationCardView: View {
    let lab: Lab
    
    var body: some View {
        ZStack {
            Image(lab.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 200)
                .clipped()
            
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.4)
            
            Text(lab.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(width: 160, height: 130)
        .cornerRadius(12)
        .shadow(radius: 5)
    }
}

struct ItemGridView: View {
    let items: [ReservableItem]
    var onSelectItem: (ReservableItem) -> Void
    let brandColor: Color
    
    private let columns = [
        GridItem(.flexible(), spacing: 40),
        GridItem(.flexible(), spacing: 40)
    ]
    
    var body: some View {
        VStack {
            Text("Select your device")
                .font(.headline)
                .foregroundColor(brandColor)
                .padding(.top)
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 40) {
                    ForEach(items) { item in
                        ItemStatusView(
                            item: item,
                            onBook: { onSelectItem(item) },
                            brandColor: brandColor
                        )
                    }
                }
                .padding()
            }
        }
    }
}

struct ItemStatusView: View {
    let item: ReservableItem
    var onBook: () -> Void
    let brandColor: Color
    
    var body: some View {
        VStack(spacing: 15) {
            Text(item.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(.systemGray5))
                .clipShape(Capsule())
            
            let iconName = item.name.lowercased().contains("imac") ? "desktopcomputer" : "display"
            
            switch item.status {
            case .available:
                Button("Book") {
                    onBook()
                }
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical, 10)
                .padding(.horizontal, 40)
                .background(brandColor)
                .clipShape(Capsule())
                
            case .reserved:
                Image(systemName: iconName)
                    .font(.system(size: 40))
                    .foregroundColor(.red)
                
            case .bookedByMe:
                Image(systemName: iconName)
                    .font(.system(size: 40))
                    .foregroundColor(.green)
            }
        }
        .frame(minHeight: 150)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
                .foregroundColor(Color(red: 0/255, green: 64/255, blue: 221/255))
        )
    }
}

struct ReservationPopupView: View {
    @Binding var isPresented: Bool
    let itemName: String
    var onReserve: (Date, Date) -> Void
    @State private var fromDate = Date()
    @State private var toDate = Date()
    
    let brandColor = Color(red: 25/255, green: 55/255, blue: 109/255)
    
    var body: some View {
        VStack(spacing: 25) {
            Text("Reserve for \(itemName)")
                .font(.headline)
                .fontWeight(.bold)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("From")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    DatePicker("", selection: $fromDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    DatePicker("", selection: $fromDate, displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .environment(\.locale, Locale(identifier: "en_US"))
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("To")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                HStack {
                    DatePicker("", selection: $toDate, in: fromDate..., displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    DatePicker("", selection: $toDate, in: fromDate..., displayedComponents: .hourAndMinute)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .environment(\.locale, Locale(identifier: "en_US"))
                }
            }
            
            Button("Confirm") {
                onReserve(fromDate, toDate)
                withAnimation(.spring()) {
                    isPresented = false
                }
            }
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(brandColor)
            .clipShape(Capsule())
        }
        .padding(25)
        .frame(width: 340)
        .background(.background)
        .cornerRadius(20)
        .shadow(radius: 20)
        .onChange(of: fromDate) { newValue in
            if toDate < newValue {
                toDate = newValue
            }
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}
