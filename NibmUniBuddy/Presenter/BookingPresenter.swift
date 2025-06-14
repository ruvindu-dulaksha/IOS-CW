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
    @Published var isBookingComplete = false
    var slot: Slot
    var onBookingComplete: ((Slot) -> Void)?
    
    
    init(slot: Slot, onBookingComplete: ((Slot) -> Void)? = nil) {
        self.slot = slot
        self.onBookingComplete = onBookingComplete
    }
    
    
    init() {
        self.slot = Slot(id: "Default-Slot")
        self.onBookingComplete = nil
    }
    
    func bookSlot() {
       
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !vehicleNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }
        
        slot.isBooked = true
        slot.bookedBy = name
        slot.vehicleNumber = vehicleNumber
        slot.duration = selectedDuration
        
        onBookingComplete?(slot)
        isBookingComplete = true
    }
}
