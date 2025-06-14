import Foundation


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


protocol ReservationRepositoryProtocol {
    func getLabs() -> [Lab]
    func reserveItem(itemId: UUID, labId: UUID, fromDate: Date, toDate: Date) -> Bool
}


class ReservationRepository: ReservationRepositoryProtocol {
    private var labs: [Lab] = [
        Lab(name: "Computer\nlab", imageName: "windows", items: [
            ReservableItem(name: "PC-01", status: .available),
            ReservableItem(name: "PC-02", status: .reserved),
            ReservableItem(name: "PC-03", status: .available),
            ReservableItem(name: "PC-04", status: .reserved),
            ReservableItem(name: "PC-05", status: .available),
            ReservableItem(name: "PC-06", status: .available),
            ReservableItem(name: "PC-07", status: .reserved),
            ReservableItem(name: "PC-08", status: .available)
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
    
    func getLabs() -> [Lab] {
        return labs
    }
    
    func reserveItem(itemId: UUID, labId: UUID, fromDate: Date, toDate: Date) -> Bool {
        guard let labIndex = labs.firstIndex(where: { $0.id == labId }),
              let itemIndex = labs[labIndex].items.firstIndex(where: { $0.id == itemId }) else {
            return false
        }
        
        labs[labIndex].items[itemIndex].status = .bookedByMe
        return true
    }
}
