//
//  ParkingSlot.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-09.
//


import Foundation

struct Slot: Identifiable {
    let id: String
    var isBooked: Bool = false
    var bookedBy: String? = nil
    var vehicleNumber: String? = nil
    var duration: Int? = nil
}

