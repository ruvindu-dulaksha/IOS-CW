import SwiftUI

// MARK: - Main Reservation View

struct ReservationView: View {
    @StateObject private var presenter = ReservationPresenter()
    @Environment(\.dismiss) var dismiss
    
    let brandColor = Color(red: 25/255, green: 55/255, blue: 109/255)
    
    var body: some View {
        ZStack {
            VStack(spacing: 24) {
                HeaderView(
                    brandColor: brandColor,
                    dismissAction: { dismiss() }
                )
                
                HStack(spacing: 20) {
                    ForEach(presenter.labs) { lab in
                        Button(action: {
                            presenter.selectLab(lab.id)
                        }) {
                            ReservationCardView(lab: lab)
                        }
                    }
                }
                .padding(.horizontal)
                
                if let index = presenter.selectedLabIndex {
                    ItemGridView(
                        items: presenter.labs[index].items,
                        onSelectItem: { item in
                            presenter.selectItem(item)
                        },
                        brandColor: brandColor
                    )
                    .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
                }
                
                if presenter.selectedLabID == nil {
                    Spacer()
                }
            }
            .background(Color(.systemGroupedBackground))
            
            if presenter.showingReservationPopup {
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial)
                    .ignoresSafeArea()
                    .onTapGesture {
                        presenter.dismissReservationPopup()
                    }
                
                ReservationPopupView(
                    isPresented: $presenter.showingReservationPopup,
                    itemName: presenter.selectedItem?.name ?? "Device",
                    onReserve: { fromDate, toDate in
                        presenter.reserveItem(fromDate: fromDate, toDate: toDate)
                    }
                )
                .transition(.scale.combined(with: .opacity))
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Preview Provider

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
