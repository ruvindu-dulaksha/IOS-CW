//
//  BookingPresenter.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-09.


import Foundation
import Combine

class BookingPresenter: ObservableObject {
    @Published var name = ""
    @Published var vehicleNumber = ""
    @Published var selectedDuration = 1
    var slot: Slot
    var onBookingComplete: ((Slot) -> Void)?

    init(slot: Slot, onBookingComplete: ((Slot) -> Void)? = nil) {
        self.slot = slot
        self.onBookingComplete = onBookingComplete
    }

    func bookSlot() {
        slot.isBooked = true
        slot.bookedBy = name
        slot.vehicleNumber = vehicleNumber
        slot.duration = selectedDuration

        onBookingComplete?(slot)
    }
}
