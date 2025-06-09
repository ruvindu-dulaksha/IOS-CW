import SwiftUI

// 1. Data Model for Reservation Items
struct ReservationItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let destinationView: AnyView
}

// 2. Reusable Card View
struct ReservationCardView: View {
    let item: ReservationItem

    var body: some View {
        ZStack {
            // This now correctly loads your images from the Asset Catalog
            Image(item.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 160, height: 160)
                .clipped()

            Rectangle()
                .foregroundColor(.black)
                .opacity(0.4)
                .frame(width: 160, height: 160)

            Text(item.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
        }
        .frame(width: 160, height: 160)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}

// 3. Main Reservation Screen
struct ReservationView: View {
    @Environment(\.presentationMode) var presentationMode

    // --- THIS IS THE UPDATED PART ---
    // The `imageName` values now match your Asset Catalog names.
    let labItems: [ReservationItem] = [
        ReservationItem(name: "Computer\nlab",
                        imageName: "higher-education-with-students-and-policy-concept-modern-office-space-featuring-rows-of-computers-on-desks-in-a-well-lit-environment-photo", 
                        destinationView: AnyView(LabDetailView(labName: "Computer Lab"))),
        
        ReservationItem(name: "IOS\nlab",
                        imageName: "mac-lab", // Use the "mac-lab" asset you already have
                        destinationView: AnyView(LabDetailView(labName: "IOS Lab")))
    ]
    
    let brandColor = Color(red: 25/255, green: 55/255, blue: 109/255)

    var body: some View {
        NavigationView {
            ZStack {
                // For the background pattern, you'll need to add another image
                // to your assets and name it "background_pattern".
                Image("background_pattern")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.1)

                VStack(spacing: 24) {
                    ZStack {
                        HStack {
                            Text("Reservation")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(brandColor)
                        }
                        .frame(maxWidth: .infinity)

                        HStack {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                HStack(spacing: 4) {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                }
                                .foregroundColor(brandColor)
                            }
                            Spacer()
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)

                    HStack(spacing: 20) {
                        ForEach(labItems) { item in
                            NavigationLink(destination: item.destinationView) {
                                ReservationCardView(item: item)
                            }
                        }
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// --- Placeholder Destination View ---
struct LabDetailView: View {
    let labName: String
    var body: some View {
        Text("Details for \(labName)")
            .font(.title)
            .navigationTitle(labName)
            .navigationBarTitleDisplayMode(.inline)
    }
}

// --- Preview Provider ---
struct ReservationView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView()
    }
}
