//
//  MainTabView.swift
//  NibmUniBuddy
//
//  Created by Ruvindu Dulaksha on 2025-06-07.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 2
    @State private var showingProfile = false
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
          
            CrowdLevelView()
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("Crowd Level")
                }
                .tag(0)
            
            
            LocationFinderView()
                .tabItem {
                    Image(systemName: "location.fill")
                    Text("Map")
                }
                .tag(1)
            
            
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(2)
            
           
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar.badge.clock")
                    Text("Schedule")
                }
                .tag(3)
            
            
            ReservationTabView()
                .tabItem {
                    Image(systemName: "calendar.badge.plus")
                    Text("Reservation")
                }
                .tag(4)
        }
        .accentColor(.mainBlue)
        .sheet(isPresented: $showingProfile) {
            ProfileView()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ShowProfile"))) { _ in
            showingProfile = true
        }
    }
}


struct ReservationTabView: View {
    @State private var showingInfo = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
               
                HStack {
                    Button(action: {
                        showingInfo = true
                    }) {
                        Image(systemName: "bell")
                            .font(.system(size: 25, weight: .medium))
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("NIBM")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.mainBlue)

                        Text("UNI BUDDY")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Button(action: {
                        NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 30, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 8)
                .padding(.bottom, 12)
                .background(Color(.systemBackground))
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.separator))
                        .offset(y: 0),
                    alignment: .bottom
                )

              
                if isLecturer() {
                    SlotListView()
                } else {
                    ReservationView()
                }
                
            }
            
            .navigationBarHidden(true)
            .sheet(isPresented: $showingInfo) {
                InfoView()
            }
        }
    }
    
   
    private func isLecturer() -> Bool {
        let currentEmail = UserDefaults.standard.string(forKey: "loggedInUserEmail") ?? ""
        return currentEmail.contains("lecturer")
    }

}


struct CrowdLevelView: View {
    @StateObject private var viewModel = CrowdViewModel()
    @State private var showDetail = false
    @State private var showingInfo = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack {
                    Button(action: {
                        showingInfo = true
                    }) {
                        Image(systemName: "bell")
                            .font(.system(size: 25, weight: .medium))
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("NIBM")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.mainBlue)

                        Text("UNI BUDDY")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                    Spacer()
                    
                    Button(action: {
                        NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 30, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .background(Color(.systemBackground))
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.separator))
                        .offset(y: 0),
                    alignment: .bottom
                )

                ScrollView {
                    VStack(spacing: 24) {
                        Text("Crowd Level Indicator")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.mainBlue)
                            .padding(.top, 16)
                        
                        
                        ForEach(viewModel.areas) { area in
                            CrowdLevelRow(area: area, viewModel: viewModel, isModeratorMode: false)
                        }

                        VStack(spacing: 12) {
                            Divider()
                            
                            Text("Only available for moderators")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                showDetail = true
                            }) {
                                Text("Moderator")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(.mainBlue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 40)
                        }
                        .padding(.top, 20)
                        .padding(.bottom, 100)
                    }
                    .padding(.horizontal)
                }
                .background(Color(.systemGroupedBackground))
                
                NavigationLink(destination: CrowdDetailView(viewModel: viewModel), isActive: $showDetail) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingInfo) {
                InfoView()
            }
        }
    }
}

struct ScheduleView: View {
    @StateObject private var presenter = ScheduleViewModel()
    @State private var showingInfo = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                HStack {
                    Button(action: {
                                           showingInfo = true
                                       }) {
                                           Image(systemName: "bell")
                                               .font(.system(size: 25, weight: .medium))
                                               .foregroundColor(.primary)
                                       }
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text("NIBM")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.mainBlue)

                        Text("UNI BUDDY")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)

                    
                    Spacer()
                    
                    Button(action: {
                        NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
                    }) {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 30, weight: .medium))
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 8)
                .background(Color(.systemBackground))
                .overlay(
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color(.separator))
                        .offset(y: 0),
                    alignment: .bottom
                )

                
                ScrollView {
                    VStack(spacing: 24) {
                        Text("Schedule")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.mainBlue)
                        .padding(.top, 16)}
                    LazyVStack(spacing: 8) {
                        ForEach($presenter.scheduleItems) { item in
                            ScheduleCard(item: item)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 100)
                }
                .background(Color(red: 0.95, green: 0.95, blue: 0.97))
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingInfo) {
                            InfoView()
                        }
        }
    }
}


struct LocationFinderView: View {
    @StateObject private var presenter = LocationFinderPresenter()
    @FocusState private var currentLocationFocused: Bool
    @FocusState private var targetLocationFocused: Bool
    @State private var showingInfo = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    
                    HStack {
                        Button(action: {
                                               showingInfo = true
                                           }) {
                                               Image(systemName: "bell")
                                                   .font(.system(size: 25, weight: .medium))
                                                   .foregroundColor(.primary)
                                           }
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Text("NIBM")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.mainBlue)

                            Text("UNI BUDDY")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)

                        
                        Spacer()
                        
                        Button(action: {
                            NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
                        }) {
                            Image(systemName: "person.crop.circle")
                                .font(.system(size: 30, weight: .medium))
                                .foregroundColor(.primary)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .background(Color(.systemBackground))
                    .overlay(
                        Rectangle()
                            .frame(height: 0.5)
                            .foregroundColor(Color(.separator))
                            .offset(y: 0),
                        alignment: .bottom
                    )
                    
                   
                    if !presenter.showInstructions {
                        inputView(geometry: geometry)
                    } else {
                        instructionsView(geometry: geometry)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .ignoresSafeArea(.keyboard, edges: .bottom)
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingInfo) {
                            InfoView()
                        }
        }
        .onAppear {
            currentLocationFocused = true
        }
    }
    
    private func inputView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 24) {
                Text("Map")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.mainBlue)
                .padding(.top, 16)}
            
            Image("map1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: geometry.size.height * 0.5)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Select Location")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.horizontal, 16)
                
                VStack(spacing: 12) {
                    inputField(label: "Your Location", placeholder: "Enter your current location", text: $presenter.model.currentLocation, focus: $currentLocationFocused, onCommit: {
                        targetLocationFocused = true
                    })
                    inputField(label: "Target Location", placeholder: "Enter your destination", text: $presenter.model.targetLocation, focus: $targetLocationFocused, onCommit: {
                        if !presenter.model.currentLocation.isEmpty && !presenter.model.targetLocation.isEmpty {
                            presenter.findLocation()
                        }
                    })
                }
                
                Button(action: presenter.findLocation) {
                    Text("Find Location")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color(red: 32/255.0, green: 64/255.0, blue: 133/255.0))
                        .cornerRadius(5)
                }
                .padding(.horizontal, 16)
                .disabled(presenter.model.currentLocation.isEmpty || presenter.model.targetLocation.isEmpty)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onTapGesture {
            currentLocationFocused = false
            targetLocationFocused = false
        }
    }
    
    private func inputField(label: String, placeholder: String, text: Binding<String>, focus: FocusState<Bool>.Binding, onCommit: @escaping () -> Void) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
            
            TextField(placeholder, text: text, onCommit: onCommit)
                .focused(focus)
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
    
    private func instructionsView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 0) {
            
            HStack {
                Button(action: {
                    presenter.showInstructions = false
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .medium))
                        Text("Back")
                            .font(.system(size: 16, weight: .medium))
                    }
                    .foregroundColor(Color(red: 32/255.0, green: 64/255.0, blue: 133/255.0))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                
                Spacer()
            }
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
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Location instructions")
                    .font(.system(size: 22, weight: .bold))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 4) {
                        ForEach(Array(presenter.locationInstructions.enumerated()), id: \.offset) { index, instruction in
                            HStack(alignment: .top, spacing: 10) {
                                Text("\(index + 1)")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 22, height: 22)
                                    .background(Color(red: 32/255.0, green: 64/255.0, blue: 133/255.0))
                                    .clipShape(Circle())
                                
                                Text(instruction)
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer(minLength: 0)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}


struct ProfileView: View {
    @StateObject private var store = ProfileStore()
    @State private var showingEdit = false
    @State private var showingLogin = false
    @Environment(\.presentationMode) var presentationMode

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

                HStack {
                    Spacer()
                    Button(action: {
                       
                        showingLogin = true
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
                    presentationMode.wrappedValue.dismiss()
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
            .fullScreenCover(isPresented: $showingLogin) {
                LoginView()
            }
        }
        .onAppear {
            store.loadCurrentUserProfile()
        }
    }
}



struct Profile: Codable {
    var name: String
    var email: String
    var department: String
    var studentID: String
    var phone: String
    var password: String
    var imageFilename: String?
}


class ProfileStore: ObservableObject {
    @Published var profile: Profile {
        didSet {
            saveProfile()
        }
    }

    static let profileKey = "user_profile"

    init() {
        self.profile = Profile(
            name: "User",
            email: "user@student.nibm.lk",
            department: "Technology",
            studentID: "NIBM001",
            phone: "+94 123 456 789",
            password: "********",
            imageFilename: nil
        )
        loadCurrentUserProfile()
    }

    func loadCurrentUserProfile() {
        let currentEmail = getCurrentUserEmail()
        
        
        if let data = UserDefaults.standard.data(forKey: Self.profileKey + "_" + currentEmail),
           let savedProfile = try? JSONDecoder().decode(Profile.self, from: data) {
            self.profile = savedProfile
        } else {
            
            createDefaultProfile(for: currentEmail)
        }
    }
    
    private func createDefaultProfile(for email: String) {
        let nameFromEmail = email.split(separator: "@").first?.description.capitalized ?? "User"
        let domain = email.split(separator: "@").last?.description ?? ""
        
        let department: String
        let studentType: String
        
        if domain.contains("student") {
            department = "Computer Science"
            studentType = "Student"
        } else if domain.contains("lecturer") {
            department = "Faculty"
            studentType = "Lecturer"
        } else {
            department = "Technology"
            studentType = "Student"
        }
        
        self.profile = Profile(
            name: nameFromEmail,
            email: email,
            department: department,
            studentID: generateStudentID(for: email),
            phone: "+94 123 456 789",
            password: "********",
            imageFilename: nil
        )
        
        saveProfile()
    }
    
    private func generateStudentID(for email: String) -> String {
        let prefix = email.contains("lecturer") ? "LEC" : "STU"
        let randomNum = String(format: "%04d", Int.random(in: 1000...9999))
        return "\(prefix)\(randomNum)"
    }
    
    private func getCurrentUserEmail() -> String {
        return UserDefaults.standard.string(forKey: "loggedInUserEmail") ?? "user@student.nibm.lk"
    }

    func saveProfile() {
        let currentEmail = getCurrentUserEmail()
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: Self.profileKey + "_" + currentEmail)
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

#Preview {
    MainTabView()
}
