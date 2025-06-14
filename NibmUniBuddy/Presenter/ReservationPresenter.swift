import Foundation
import SwiftUI


protocol ReservationPresenterProtocol: ObservableObject {
    var labs: [Lab] { get }
    var selectedLabID: UUID? { get set }
    var showingReservationPopup: Bool { get set }
    var selectedItem: ReservableItem? { get set }
    var selectedLabIndex: Int? { get }
    
    func loadLabs()
    func selectLab(_ labId: UUID)
    func selectItem(_ item: ReservableItem)
    func reserveItem(fromDate: Date, toDate: Date)
    func dismissReservationPopup()
}

class ReservationPresenter: ReservationPresenterProtocol {
    @Published var labs: [Lab] = []
    @Published var selectedLabID: UUID?
    @Published var showingReservationPopup = false
    @Published var selectedItem: ReservableItem?
    
    private let repository: ReservationRepositoryProtocol
    
    var selectedLabIndex: Int? {
        labs.firstIndex { $0.id == selectedLabID }
    }
    
    init(repository: ReservationRepositoryProtocol = ReservationRepository()) {
        self.repository = repository
        loadLabs()
    }
    
    func loadLabs() {
        labs = repository.getLabs()
    }
    
    func selectLab(_ labId: UUID) {
        withAnimation(.spring()) {
            selectedLabID = (selectedLabID == labId) ? nil : labId
        }
    }
    
    func selectItem(_ item: ReservableItem) {
        selectedItem = item
        withAnimation(.spring()) {
            showingReservationPopup = true
        }
    }
    
    func reserveItem(fromDate: Date, toDate: Date) {
        guard let item = selectedItem,
              let labId = selectedLabID else { return }
        
        let success = repository.reserveItem(
            itemId: item.id,
            labId: labId,
            fromDate: fromDate,
            toDate: toDate
        )
        
        if success {
            loadLabs() 
        }
        
        dismissReservationPopup()
    }
    
    func dismissReservationPopup() {
        withAnimation(.spring()) {
            showingReservationPopup = false
        }
    }
}
