import SwiftUI

struct ProfileView: View {
    @StateObject private var store = ProfileStore()
    @State private var showingEdit = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Group {
                    if let filename = store.profile.imageFilename,
                       let uiImage = store.loadImage(named: filename) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        Image("ProfileImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 5)

                VStack(spacing: 5) {
                    Text(store.profile.name)
                        .font(.headline)
                    Text(store.profile.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                VStack(spacing: 20) {
                    HStack(alignment: .top, spacing: 30) {
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Image(systemName: "building.2.fill")
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Department").bold()
                                    Text(store.profile.department)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack {
                                Image(systemName: "person.fill")
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Student ID").bold()
                                    Text(store.profile.studentID)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Image(systemName: "phone.fill")
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Phone no.").bold()
                                    Text(store.profile.phone)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            HStack {
                                Image(systemName: "lock.fill")
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Password").bold()
                                    Text(store.profile.password)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .padding()
                .cornerRadius(10)
                .padding(.horizontal)

                Spacer()

                HStack {
                    Spacer()
                    Button(action: {
                        // Log Out action
                    }) {
                        Text("Log Out")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color(red: 32/255, green: 64/255, blue: 133/255))
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding(.bottom, 80)
            }
            .padding(.top)
            .navigationBarItems(
                leading: Button(action: {
                    // Back action
                }) {
                    Text("< Back")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                },
                trailing: Button(action: {
                    showingEdit = true
                }) {
                    Image(systemName: "pencil")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                }
            )
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Profile")
                        .font(.system(size: 24, weight: .heavy))
                        .foregroundColor(Color(red: 32/255, green: 64/255, blue: 133/255))
                        .padding(.top, 50)
                }
            }
            .sheet(isPresented: $showingEdit) {
                EditProfileView(store: store)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
