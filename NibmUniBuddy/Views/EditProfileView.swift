import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Binding var profile: Profile
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        ZStack {
                            // Show current or default image
                            Group {
                                if let imageData = profile.imageData,
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(.gray)
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                            // Pencil overlay for picking image
                            PhotosPicker(
                                selection: $selectedItem,
                                matching: .images,
                                photoLibrary: .shared()
                            ) {
                                Circle()
                                    .fill(Color.black.opacity(0.3))
                                    .frame(width: 100, height: 100)
                                    .overlay(
                                        Image(systemName: "pencil")
                                            .foregroundColor(.white)
                                            .font(.title)
                                    )
                            }
                        }
                        Spacer()
                    }
                }
                Section(header: Text("Personal Info")) {
                    TextField("Name", text: $profile.name)
                    TextField("Email", text: $profile.email)
                }
                Section(header: Text("Details")) {
                    TextField("Department", text: $profile.department)
                    TextField("Student ID", text: $profile.studentID)
                    TextField("Phone", text: $profile.phone)
                    SecureField("Password", text: $profile.password)
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
            .onChange(of: selectedItem) { newItem in
                if let newItem {
                    Task {
                        if let data = try? await newItem.loadTransferable(type: Data.self) {
                            profile.imageData = data
                        }
                    }
                }
            }
        }
    }
}

