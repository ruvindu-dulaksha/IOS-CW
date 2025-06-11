import Foundation
import SwiftUI

class LocationFinderPresenter: ObservableObject {
    @Published var model = LocationModel()
    @Published var locationInstructions: [String] = []
    @Published var showInstructions: Bool = false
    
    func findLocation() {
        locationInstructions = model.generateInstructions()
        withAnimation(.easeInOut(duration: 0.3)) {
            showInstructions = true
        }
    }
    
    func resetInstructions() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showInstructions = false
        }
    }
}
