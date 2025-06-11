//
//  ResourcePresenter.swift
//  NibmUniBuddy
//
//  Created by fathima minzah on 2025-06-09.
//
import Foundation

class ResourcePresenter: ObservableObject {
    @Published var resources: [Resource] = []
    
    init() {
        loadResources()
    }
    
    private func loadResources() {
        resources = [
            Resource(title: "Football Club", contactPerson: "R. Dulaksha", contactDetails: "0771775488"),
            Resource(title: "Badminton Club", contactPerson: "R. Dulaksha", contactDetails: "0771775488"),
            Resource(title: "Cricket Club", contactPerson: "R. Dulaksha", contactDetails: "0771775488"),
            Resource(title: "Student Committee", contactPerson: "R. Dulaksha", contactDetails: "0771775488"),
            Resource(title: "Event Committee", contactPerson: "R.Dulaksha", contactDetails: "0771775488"),
            
        ]
    }
}
