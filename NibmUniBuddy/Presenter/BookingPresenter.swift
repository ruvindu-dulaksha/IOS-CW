//
//  BookingPresenter.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-09.
//

import Foundation
import Combine

class BookingPresenter: ObservableObject {
    @Published var name: String = ""
    @Published var vehicleNumber: String = ""
    @Published var selectedDuration: Int = 1

    let slot: ParkingSlot

    init(slot: ParkingSlot) {
        self.slot = slot
    }

    func bookSlot() {
        print("Booked \(slot.id) for \(name) - \(vehicleNumber) for \(selectedDuration) hour(s)")
        // Add real booking logic here (networking/database/etc.)
    }
}
