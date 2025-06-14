import SwiftUI

struct ReservationView: View {
    @StateObject private var presenter = ReservationPresenter()
    @State private var showingInfo = false
    
    let brandColor = Color(red: 25/255, green: 55/255, blue: 109/255)
    
    var body: some View {
        VStack(spacing: 0) {
          
            VStack(spacing: 24) {
                Text("ReservationView")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.mainBlue)
                    .padding(.top, 16)
            }
          
            ScrollView {
                VStack(spacing: 24) {
                    
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
                    .padding(.top, 16)
                    
                    
                    if let index = presenter.selectedLabIndex {
                        ItemGridView(
                            items: presenter.labs[index].items,
                            onSelectItem: { item in
                                presenter.selectItem(item)
                            },
                            brandColor: brandColor
                        )
                        .transition(.opacity.combined(with: .scale(scale: 0.95, anchor: .top)))
                        .padding(.horizontal)
                    }
                    
                    
                    Color.clear
                        .frame(height: 100)
                }
            }
            .background(Color(.systemGroupedBackground))
        }
        .background(Color(.systemGroupedBackground))
        .overlay(
            
            Group {
                if presenter.showingReservationPopup {
                    ZStack {
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
            }
        )
        .sheet(isPresented: $showingInfo) {
            InfoView()
        }
    }
}

struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
