import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Image
                Image("profileImage") // Replace with actual asset name
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 5)

                // Name and Email
                VStack(spacing: 5) {
                    Text("Itunoluwa Abidoye")
                        .font(.headline)
                    Text("Itunoluwa@petra.africa")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                // Details Grid (2 Columns)
                VStack(spacing: 20) {
                    HStack(alignment: .top, spacing: 30) {
                        // Left Column
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Image(systemName: "building.2.fill")
                                    .frame(width: 24)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Department")
                                        .font(.subheadline)
                                        .bold()
                                    Text("Technology")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }

                            HStack {
                                Image(systemName: "person.fill")
                                    .frame(width: 24)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Student ID")
                                        .font(.subheadline)
                                        .bold()
                                    Text("conbsn21.tp-033")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }

                        // Right Column
                        VStack(alignment: .leading, spacing: 20) {
                            HStack {
                                Image(systemName: "phone.fill")
                                    .frame(width: 24)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Phone no.")
                                        .font(.subheadline)
                                        .bold()
                                    Text("+98 1245560090")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }

                            HStack {
                                Image(systemName: "lock.fill")
                                    .frame(width: 24)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Password")
                                        .font(.subheadline)
                                        .bold()
                                    Text("********")
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

                // Logout Button (centered and styled)
                HStack {
                    Spacer()
                    Button(action: {
                        // Logout logic here
                    }) {
                        Text("Log Out")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 200)
                            .background(Color(red: 32/255, green: 64/255, blue: 133/255)) // #204085
                            .cornerRadius(10)
                    }
                    Spacer()
                }
                .padding(.bottom, 80)
            }
            .padding(.top)
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: {
                    // Handle back navigation
                }) {
                    Text("< Back")
                        .font(.system(size: 16, weight: .medium))
                }
            )
            .onAppear {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor.white
                appearance.titleTextAttributes = [
                    .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                    .foregroundColor: UIColor.black
                ]
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
