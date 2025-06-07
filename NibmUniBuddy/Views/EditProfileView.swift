import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @ObservedObject var store: ProfileStore
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        ZStack {
                        
                            Group {
                                if let filename = store.profile.imageFilename,
                                   let uiImage = store.loadImage(named: filename) {
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
                                selection: $selectedItem,
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
                    TextField("Name", text: $store.profile.name)
                    TextField("Email", text: $store.profile.email)
                }
                Section(header: Text("Details")) {
                    TextField("Department", text: $store.profile.department)
                    TextField("Student ID", text: $store.profile.studentID)
                    TextField("Phone", text: $store.profile.phone)
                    SecureField("Password", text: $store.profile.password)
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
                            if let filename = store.saveImage(data) {
                                store.profile.imageFilename = filename
                            }
                        }
                    }
                }
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    @State static var sampleStore = ProfileStore()

    static var previews: some View {
        EditProfileView(store: sampleStore)
    }
}
