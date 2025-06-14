//
//  SlotListView.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-09.


import SwiftUI
import Lottie


struct SlotListView: View {
    @StateObject private var presenter = SlotListPresenter()

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {

               

                Text("Parking Slots")
                    .font(.title)
                    .bold()
                    .foregroundColor(Color("MainBlueColor"))

                Text("Entry")
                    .font(.subheadline)
                    .foregroundColor(.black)

                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0..<presenter.slots.count / 2, id: \.self) { row in
                            HStack(spacing: 30) {
                                let leftSlot = presenter.slots[row * 2]
                                let rightSlot = presenter.slots[row * 2 + 1]

                                ForEach([leftSlot, rightSlot], id: \.id) { slot in
                                    VStack(spacing: 8) {
                                        Text(slot.id)
                                            .font(.headline)

                                        if slot.isBooked {
                            
                                            LottieView(filename: "running_car")
                                                .frame(width: 50, height: 30)
                                
                                            Text("\(Int(slot.duration ?? 1)) hour\(slot.duration ?? 1 > 1 ? "s" : "")")
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        } else {
                                            NavigationLink(
                                                destination: BookingView(
                                                    presenter: BookingPresenter(
                                                        slot: slot,
                                                        onBookingComplete: { updatedSlot in
                                                            presenter.updateSlot(updatedSlot)
                                                        }
                                                    )
                                                )
                                            ) {
                                                Text("Book")
                                                    .padding(.vertical, 8)
                                                    .padding(.horizontal, 24)
                                                    .background(Color("MainBlueColor"))
                                                    .foregroundColor(.white)
                                                    .cornerRadius(8)
                                            }
                                        }
                                    }
                                    .frame(width: 130)
                                    .padding()
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 0)
                                            .stroke(Color("MainBlueColor"), style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    )
                                }
                            }

                            if row < (presenter.slots.count / 2 - 1) {
                                Image(systemName: "arrow.down")
                                    .resizable()
                                    .frame(width: 15, height: 40)
                                    .foregroundColor(Color("subGreycolor"))
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 25)
                            }
                        }
                    }
                }

                Text("Exit")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .padding(.bottom)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    SlotListView()
}
