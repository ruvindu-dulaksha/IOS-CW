import SwiftUI

struct LocationFinderView: View {
    @State private var currentLocation: String = ""
    @State private var targetLocation: String = ""
    @State private var showInstructions: Bool = false
    @State private var locationInstructions: [String] = []
    @FocusState private var currentLocationFocused: Bool
    @FocusState private var targetLocationFocused: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Status Bar and Navigation
                HStack {
                    Button(action: {
                        if showInstructions {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showInstructions = false
                            }
                        }
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.black)
                            Text("Back")
                                .font(.system(size: 17))
                                .foregroundColor(.black)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Map")
                        .font(.system(size: 23, weight: .bold))
                        .foregroundColor(Color(red: 32/255.0, green: 64/255.0, blue: 133/255.0));
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        Text("Back")
                            .font(.system(size: 17))
                    }
                    .opacity(0)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .frame(height: 44)
                
                if !showInstructions {
                    // Initial View - Single Level 1 Map
                    VStack(spacing: 0) {
                        Image("map1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.5)
                        
                        // Location Selection Section
                        VStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("Select Location")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            
                            VStack(alignment: .leading, spacing: 12) {
                                // Your Location
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Your Location")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                        .padding(.horizontal, 16)
                                    
                                    TextField("Enter your current location", text: $currentLocation, onCommit: {
                                        targetLocationFocused = true
                                    })
                                    .focused($currentLocationFocused)
                                    .font(.system(size: 17))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 6)
                                    
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(height: 0.5)
                                        .padding(.horizontal, 16)
                                }
                                
                                // Target Location
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("Target Location")
                                        .font(.system(size: 13))
                                        .foregroundColor(.gray)
                                        .padding(.horizontal, 16)
                                    
                                    TextField("Enter your destination", text: $targetLocation, onCommit: {
                                        if !currentLocation.isEmpty && !targetLocation.isEmpty {
                                            findLocation()
                                        }
                                    })
                                    .focused($targetLocationFocused)
                                    .font(.system(size: 17))
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 6)
                                    
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .frame(height: 0.5)
                                        .padding(.horizontal, 16)
                                }
                            }
                            
                            // Find Location Button
                            Button(action: {
                                findLocation()
                            }) {
                                Text("Find Location")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(red: 32/255.0, green: 64/255.0, blue: 133/255.0))
                                    .cornerRadius(25)
                            }
                            .padding(.horizontal, 16)
                            .disabled(currentLocation.isEmpty || targetLocation.isEmpty)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .onTapGesture {
                        currentLocationFocused = false
                        targetLocationFocused = false
                    }
                } else {
                    // Instructions View - Full Screen Usage
                    VStack(spacing: 0) {
                        // Two Images Side by Side - Maximized
                        HStack(spacing: 0) {
                            Image("map-2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                            
                            Image("map-3")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.55)
                        .padding(.horizontal, 8)
                        
                        // Location Instructions Section - Full Width
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Text("Location instructions")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            
                            ScrollView {
                                LazyVStack(alignment: .leading, spacing: 4) {
                                    ForEach(Array(locationInstructions.enumerated()), id: \.offset) { index, instruction in
                                        HStack(alignment: .top, spacing: 10) {
                                            // Number Circle
                                            Text("\(index + 1)")
                                                .font(.system(size: 14, weight: .semibold))
                                                .foregroundColor(.white)
                                                .frame(width: 22, height: 22)
                                                .background(Color(red: 32/255.0, green: 64/255.0, blue: 133/255.0))
                                                .clipShape(Circle())
                                            
                                            // Instruction Text
                                            Text(instruction)
                                                .font(.system(size: 15))
                                                .foregroundColor(.secondary)
                                                .lineSpacing(1)
                                                .multilineTextAlignment(.leading)
                                                .fixedSize(horizontal: false, vertical: true)
                                            
                                            Spacer(minLength: 0)
                                        }
                                        .padding(.horizontal, 16)
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            currentLocationFocused = true
        }
    }
    
    private func findLocation() {
        currentLocationFocused = false
        targetLocationFocused = false
        
        generateInstructions()
        withAnimation(.easeInOut(duration: 0.3)) {
            showInstructions = true
        }
    }
    
    private func generateInstructions() {
        locationInstructions = [
            "Start at the \(currentLocation.isEmpty ? "Student Lounge" : currentLocation) on Level 1 (near the sofas and vending machines)",
            "Exit the \(currentLocation.isEmpty ? "Student Lounge" : currentLocation) and turn right into the central hallway",
            "Walk straight down the hallway until you reach the staircase or elevator area near the Server Room",
            "Take the stairs or elevator up to Level 2",
            "Turn left once you reach Level 2",
            "Continue walking straight down the hallway on Level 2",
            "Locate the \(targetLocation.isEmpty ? "Conference Room" : targetLocation) on your right side, directly across from the Faculty Offices",
            "Follow the red path shown on the map for easy navigation"
        ]
    }
}

struct LocationFinderView_Previews: PreviewProvider {
    static var previews: some View {
        LocationFinderView()
    }
}
