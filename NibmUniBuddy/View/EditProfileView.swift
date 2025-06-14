import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var presenter: EditProfilePresenter

    init(store: ProfileStore) {
        _presenter = StateObject(wrappedValue: EditProfilePresenter(store: store))
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        ZStack {
                            Group {
                                if let uiImage = presenter.loadProfileImage() {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } else {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(.white)
                                }
                            }
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .shadow(radius: 5)

                            PhotosPicker(
                                selection: $presenter.selectedItem,
                                matching: .images,
                                photoLibrary: .shared()
                            ) {
                                Circle()
                                    .fill(Color.black.opacity(0.3))
                                    .frame(width: 100, height: 100)
                                    .overlay(
                                        Image(systemName: "pencil")
                                            .foregroundColor(.gray)
                                            .font(.title)
                                    )
                            }
                        }
                        Spacer()
                    }
                }

                Section(header: Text("Personal Info")) {
                    TextField("Name", text: $presenter.profile.name)
                    TextField("Email", text: $presenter.profile.email)
                }

                Section(header: Text("Details")) {
                    TextField("Department", text: $presenter.profile.department)
                    TextField("Student ID", text: $presenter.profile.studentID)
                    TextField("Phone", text: $presenter.profile.phone)
                    SecureField("Password", text: $presenter.profile.password)
                }
            }
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presenter.updateProfile()
                presentationMode.wrappedValue.dismiss()
            })
            .onChange(of: presenter.selectedItem) { newItem in
                Task {
                    await presenter.handleImageSelection(newItem)
                }
            }
        }
    }
}

#Preview {
    let store = ProfileStore()
    EditProfileView(store: store)
}
