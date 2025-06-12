//
//  ParkingPresenter.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-09.
//

import Foundation
import Combine

class SlotListPresenter: ObservableObject {
    @Published var slots: [Slot] = [
        Slot(id: "A-1"), Slot(id: "A-2"),
        Slot(id: "A-3"), Slot(id: "A-4"),
        Slot(id: "A-5"), Slot(id: "A-6"),
        Slot(id: "A-7"), Slot(id: "A-8"),
        Slot(id: "A-9"), Slot(id: "A-10")
    ]

    func updateSlot(_ updatedSlot: Slot) {
        if let index = slots.firstIndex(where: { $0.id == updatedSlot.id }) {
            slots[index] = updatedSlot
        }
    }
}
