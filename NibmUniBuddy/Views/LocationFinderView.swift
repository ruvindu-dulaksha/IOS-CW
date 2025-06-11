import SwiftUI

struct LocationFinderView: View {
    @StateObject private var presenter = LocationFinderPresenter()
    @FocusState private var currentLocationFocused: Bool
    @FocusState private var targetLocationFocused: Bool
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                headerView
                
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
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear {
            currentLocationFocused = true
        }
    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                if presenter.showInstructions {
                    presenter.resetInstructions()
                }
            }) {
                HStack(spacing: 4) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Text("Back")
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                }
            }
            Spacer()
            Text("Map")
                .font(.system(size: 23, weight: .bold))
                .foregroundColor(Color(red: 32/255.0, green: 64/255.0, blue: 133/255.0))
            Spacer()
            HStack(spacing: 4) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16))
                Text("Back")
                    .font(.system(size: 17))
            }
            .opacity(0)
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .frame(height: 44)
    }
    
    private func inputView(geometry: GeometryProxy) -> some View {
        VStack(spacing: 0) {
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
                        .cornerRadius(25)
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

struct LocationFinderView_Previews: PreviewProvider {
    static var previews: some View {
        LocationFinderView()
    }
}
