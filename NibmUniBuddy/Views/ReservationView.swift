import SwiftUI

// MARK: - Data Models

struct ReservableItem: Identifiable {
    let id = UUID()
    var name: String
    var status: ItemStatus
}

enum ItemStatus {
    case available, reserved, bookedByMe
}

struct Lab: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    var items: [ReservableItem]
}

// MARK: - Main Reservation View

struct ReservationView: View {
    // --- DATA UPDATED: More items added to the first lab ---
    @State private var labs: [Lab] = [
        Lab(name: "Computer\nlab", imageName: "computer_lab_bg", items: [
            ReservableItem(name: "PC-01", status: .available),
            ReservableItem(name: "PC-02", status: .reserved),
            ReservableItem(name: "PC-03", status: .available),
            ReservableItem(name: "PC-04", status: .reserved),
            ReservableItem(name: "PC-05", status: .available), // New
            ReservableItem(name: "PC-06", status: .available), // New
            ReservableItem(name: "PC-07", status: .reserved), // New
            ReservableItem(name: "PC-08", status: .available)  // New
        ]),
        Lab(name: "IOS\nlab", imageName: "mac-lab", items: [
            ReservableItem(name: "iMac-A", status: .available),
            ReservableItem(name: "iMac-B", status: .reserved),
            ReservableItem(name: "iMac-C", status: .reserved),
            ReservableItem(name: "iMac-D", status: .available),
            ReservableItem(name: "iMac-E", status: .available),
            ReservableItem(name: "iMac-F", status: .available),
            ReservableItem(name: "iMac-G", status: .reserved),
            ReservableItem(name: "iMac-H", status: .available)
        ])
    ]

    @State private var selectedLabID: UUID?
    @State private var showingReservationPopup = false
    @State private var selectedItem: ReservableItem?

    let brandColor = Color(red: 25/255, green: 55/255, blue: 109/255)
    @Environment(\.dismiss) var dismiss
    
    private var selectedLabIndex: Int? {
        labs.firstIndex { $0.id == selectedLabID }
    }

    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                HeaderView(brandColor: brandColor, dismissAction: { dismiss() })

                HStack(spacing: 20) {
                    ForEach(labs) { lab in
                        Button(action: {
                            withAnimation(.spring()) {
                                selectedLabID = (selectedLabID == lab.id) ? nil : lab.id
                            }
                        }) { ReservationCardView(lab: lab) }
                    }
                }
                .padding(.horizontal)

                if let index = selectedLabIndex {
                    ItemGridView(
                        items: $labs[index].items,
                        onSelectItem: { item in
                            self.selectedItem = item
                            withAnimation(.spring()) { self.showingReservationPopup = true }
                        },
                        brandColor: brandColor
                    )
                    .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
                }
                
                // The spacer is now less critical but good for collapsing state.
                if selectedLabID == nil {
                    Spacer()
                }
            }
            .background(Color(.systemGroupedBackground))

            if showingReservationPopup {
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial).ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) { showingReservationPopup = false }
                    }

                ReservationPopupView(
                    isPresented: $showingReservationPopup,
                    itemName: selectedItem?.name ?? "Device",
                    onReserve: { fromDate, toDate in
                        reserveItem(itemId: selectedItem?.id, fromDate: fromDate, toDate: toDate)
                    }
                )
                .transition(.scale.combined(with: .opacity))
            }
        }
        .navigationBarHidden(true)
    }

    private func reserveItem(itemId: UUID?, fromDate: Date, toDate: Date) {
        guard let itemId = itemId, let labIndex = selectedLabIndex,
              let itemIndex = labs[labIndex].items.firstIndex(where: { $0.id == itemId }) else { return }
        
        var updatedItem = labs[labIndex].items[itemIndex]
        updatedItem.status = .bookedByMe
        labs[labIndex].items[itemIndex] = updatedItem
    }
}

// MARK: - Reusable Components

struct HeaderView: View {
    let brandColor: Color
    let dismissAction: () -> Void
    var body: some View {
        ZStack {
            Text("Reservation").font(.title2).fontWeight(.bold).foregroundColor(brandColor)
            HStack {
                Button(action: dismissAction) {
                    HStack(spacing: 4) { Image(systemName: "chevron.left"); Text("Back") }
                    .foregroundColor(brandColor)
                }
                Spacer()
            }
        }.padding()
    }
}

struct ReservationCardView: View {
    let lab: Lab
    var body: some View {
        ZStack {
            Image(lab.imageName).resizable().aspectRatio(contentMode: .fill).frame(width: 160, height: 160).clipped()
            Rectangle().foregroundColor(.black).opacity(0.4)
            Text(lab.name).font(.title2).fontWeight(.bold).foregroundColor(.white).multilineTextAlignment(.center)
        }.frame(width: 160, height: 160).cornerRadius(12).shadow(radius: 5)
    }
}

// --- GRID VIEW UPDATED: ScrollView added ---
struct ItemGridView: View {
    @Binding var items: [ReservableItem]
    var onSelectItem: (ReservableItem) -> Void
    let brandColor: Color
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            Text("Select your device")
                .font(.headline)
                .foregroundColor(brandColor)
                .padding(.top)

            // The grid is now wrapped in a ScrollView to handle overflow.
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach($items) { $item in
                        ItemStatusView(item: item, onBook: { onSelectItem(item) }, brandColor: brandColor)
                    }
                }
                .padding() // Padding inside the scroll view content
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
            Text(item.name).font(.headline).fontWeight(.medium).padding(.horizontal, 16).padding(.vertical, 8).background(Color(.systemGray5)).clipShape(Capsule())
            let iconName = item.name.lowercased().contains("imac") ? "desktopcomputer" : "display"
            switch item.status {
            case .available: Button("Book") { onBook() }.fontWeight(.semibold).foregroundColor(.white).padding(.vertical, 10).padding(.horizontal, 40).background(brandColor).clipShape(Capsule())
            case .reserved: Image(systemName: iconName).font(.system(size: 40)).foregroundColor(.red)
            case .bookedByMe: Image(systemName: iconName).font(.system(size: 40)).foregroundColor(.green)
            }
        }.frame(minHeight: 150).frame(maxWidth: .infinity).background(RoundedRectangle(cornerRadius: 15).stroke(style: StrokeStyle(lineWidth: 2, dash: [6])).foregroundColor(.gray.opacity(0.5)))
    }
}

// MARK: - Pop-up and Blur Effect Views (No Changes Here)

struct ReservationPopupView: View {
    @Binding var isPresented: Bool
    let itemName: String
    var onReserve: (Date, Date) -> Void
    @State private var fromDate = Date()
    @State private var toDate = Date()
    let brandColor = Color(red: 25/255, green: 55/255, blue: 109/255)
    var body: some View {
        VStack(spacing: 25) {
            Text("Reserve for \(itemName)").font(.headline).fontWeight(.bold)
            VStack(alignment: .leading, spacing: 10) {
                Text("From").font(.subheadline).foregroundColor(.secondary)
                HStack {
                    DatePicker("", selection: $fromDate, displayedComponents: .date).datePickerStyle(.compact).labelsHidden().padding(8).background(Color(.systemGray6)).cornerRadius(8)
                    DatePicker("", selection: $fromDate, displayedComponents: .hourAndMinute).datePickerStyle(.compact).labelsHidden().padding(8).background(Color(.systemGray6)).cornerRadius(8).environment(\.locale, Locale(identifier: "en_US"))
                }
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("To").font(.subheadline).foregroundColor(.secondary)
                HStack {
                    DatePicker("", selection: $toDate, in: fromDate..., displayedComponents: .date).datePickerStyle(.compact).labelsHidden().padding(8).background(Color(.systemGray6)).cornerRadius(8)
                    DatePicker("", selection: $toDate, in: fromDate..., displayedComponents: .hourAndMinute).datePickerStyle(.compact).labelsHidden().padding(8).background(Color(.systemGray6)).cornerRadius(8).environment(\.locale, Locale(identifier: "en_US"))
                }
            }
            Button("Confirm") {
                onReserve(fromDate, toDate)
                withAnimation(.spring()) { isPresented = false }
            }.fontWeight(.semibold).foregroundColor(.white).padding().frame(maxWidth: .infinity).background(brandColor).clipShape(Capsule())
        }
        .padding(25).frame(width: 340).background(.background).cornerRadius(20).shadow(radius: 20)
        .onChange(of: fromDate) { newValue in
            if toDate < newValue { toDate = newValue }
        }
    }
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView { UIVisualEffectView(effect: UIBlurEffect(style: blurStyle)) }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { uiView.effect = UIBlurEffect(style: blurStyle) }
}

// MARK: - Preview Provider

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
