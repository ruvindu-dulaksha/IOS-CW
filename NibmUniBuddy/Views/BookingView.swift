//
//  ParkingSlotsView.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-09.

import SwiftUI

struct BookingView: View {
    @ObservedObject var presenter: BookingPresenter

    var body: some View {
        VStack(spacing: 5) {
            
            Text("Booking Slots")
                .font(.title)
                .bold()
                .foregroundColor(Color("MainBlueColor"))

            LottieView(filename: "running_car")
                .frame(width: 250, height: 150)

            Divider().padding(.horizontal, 30)

            VStack(alignment: .leading, spacing: 15) {
                Text("Book Now")
                    .bold()
                    .foregroundColor(Color("MainBlueColor"))
                
                TextField("Enter your name", text: $presenter.name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                TextField("Enter vehicle no.", text: $presenter.vehicleNumber)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 30)

            VStack(spacing: 10) {
                Text("Choose time slots (In Hours)")
                    .foregroundColor(.black)

                Slider(value: Binding(
                    get: { Double(presenter.selectedDuration) },
                    set: { presenter.selectedDuration = Int($0) }
                ), in: 1...7, step: 1)
                .accentColor(Color("MainBlueColor"))
                .padding(.horizontal, 30)

                Text("\(presenter.selectedDuration) hour(s)")
                    .font(.subheadline)
                    .foregroundColor(Color("subGreycolor"))

                HStack(spacing: 18) {
                    ForEach(1...7, id: \.self) { num in
                        Circle()
                            .fill(num == presenter.selectedDuration ? Color("MainBlueColor") : Color.gray.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
            }


            VStack(spacing: 10) {
                Text("Your Slot Name")
                Text(presenter.slot.id)
                    .font(.title2)
                    .bold()
                    .frame(width: 80, height: 50)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("MainBlueColor"), lineWidth: 2)
                    )
            }
            .padding()

            Spacer()

            Button(action: presenter.bookSlot) {
                Text("Book Now")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("MainBlueColor"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 100)
            .padding(.top, 0)
        }
        .padding(.top, 10)
        .navigationBarBackButtonHidden(false)
        .tint(Color("subGreycolor"))
    }
}


