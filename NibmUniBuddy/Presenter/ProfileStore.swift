import Foundation
import SwiftUI

class ProfileStore: ObservableObject {
    @Published var profile: Profile {
        didSet {
            saveProfile()
        }
    }

    static let profileKey = "user_profile"

    init() {
        if let data = UserDefaults.standard.data(forKey: Self.profileKey),
           let profile = try? JSONDecoder().decode(Profile.self, from: data) {
            self.profile = profile
        } else {
            self.profile = Profile(
                name: "Itunoluwa Abidoye",
                email: "Itunoluwa@petra.africa",
                department: "Technology",
                studentID: "conbsn21.tp-033",
                phone: "+98 1245560090",
                password: "********",
                imageFilename: nil
            )
        }
    }

    func saveProfile() {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: Self.profileKey)
        }
    }

    func saveImage(_ data: Data) -> String? {
        let filename = UUID().uuidString + ".jpg"
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        do {
            try data.write(to: url)
            return filename
        } catch {
            print("Failed to save image: \(error)")
            return nil
        }
    }

    func loadImage(named filename: String) -> UIImage? {
        let url = getDocumentsDirectory().appendingPathComponent(filename)
        return UIImage(contentsOfFile: url.path)
    }

    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
