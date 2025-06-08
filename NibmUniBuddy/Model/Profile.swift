import Foundation

struct Profile: Codable {
    var name: String
    var email: String
    var department: String
    var studentID: String
    var phone: String
    var password: String
    var imageFilename: String?
}
