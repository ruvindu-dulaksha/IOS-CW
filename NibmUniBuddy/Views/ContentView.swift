import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Profile Image - Option 1: Using SF Symbol as placeholder
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                    .shadow(radius: 5)
                
                // Alternative Option 2: If you have an actual image asset
                // Make sure to add your image to Assets.xcassets first
                /*
                Image("ProfileImage") // Make sure this matches your asset name exactly
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                */
                
                // Alternative Option 3: Using AsyncImage for web images
                /*
                AsyncImage(url: URL(string: "https://your-image-url.com/profile.jpg")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(.gray)
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .shadow(radius: 5)
                */

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

                // Logout Button (centered and fixed width)
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
            .navigationBarItems(
                leading: Button(action: {
                    // Handle back
                }) {
                    Text("< Back")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                },
                trailing: Button(action: {
                    // Handle edit profile
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
                        .foregroundColor(Color(red: 32/255, green: 64/255, blue: 133/255)) // #204085
                        .padding(.top, 50) // Adjust vertical alignment if needed
                }
            }
            .onAppear {
                // Optional background color setup
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor.white
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
