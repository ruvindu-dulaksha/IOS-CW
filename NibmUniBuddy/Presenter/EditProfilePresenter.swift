import Foundation
import SwiftUI
import PhotosUI

@MainActor
class EditProfilePresenter: ObservableObject {
    @Published var profile: Profile
    @Published var selectedItem: PhotosPickerItem? = nil
    
    private let store: ProfileStore

    init(store: ProfileStore) {
        self.store = store
        self.profile = store.profile
    }

    func updateProfile() {
        store.profile = profile
    }

    func handleImageSelection(_ item: PhotosPickerItem?) async {
        guard let item = item else { return }

        if let data = try? await item.loadTransferable(type: Data.self),
           let filename = store.saveImage(data) {
            profile.imageFilename = filename
            updateProfile()
        }
    }

    func loadProfileImage() -> UIImage? {
        if let filename = profile.imageFilename {
            return store.loadImage(named: filename)
        }
        return nil
    }
}
