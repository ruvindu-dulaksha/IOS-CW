import SwiftUI

struct ResourceView: View {
    @StateObject private var presenter = ResourcePresenter()
    @State private var selectedResourceID: UUID?
    @State private var showingInfo = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
             HStack {
                 Button {
                     presentationMode.wrappedValue.dismiss()
                 } label: {
                     Image(systemName: "chevron.down")
                         .font(.system(size: 20, weight: .semibold))
                         .foregroundColor(.blue)
                         .padding(10)
                         .contentShape(Rectangle())
                 }

                 Spacer()
             }
             .padding(.horizontal)
             .padding(.top, 12)
             
             Divider()
                 .padding(.bottom, 12)

                
                ScrollView {
                    LazyVStack(spacing: 0) {
                        
                        VStack(spacing: 8) {
                            Text("Our Resources")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            
                            Text("Find all the resources you need for your academic journey")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 32)
                        .padding(.horizontal, 24)

                        
                        LazyVStack(spacing: 16) {
                            ForEach(presenter.resources) { resource in
                                ResourceCard(
                                    resource: resource,
                                    isSelected: selectedResourceID == resource.id
                                )
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        selectedResourceID = selectedResourceID == resource.id ? nil : resource.id
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 120)
                    }
                }
                .background(Color(.systemGroupedBackground))
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingInfo) {
                            InfoView()                         }
        }
    }
}

struct ResourceCard: View {
    let resource: Resource
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            VStack(alignment: .leading, spacing: 12) {
                
                HStack(spacing: 12) {
                    Image(systemName: "book.closed.fill")
                        .font(.title2)
                        .foregroundColor(.mainBlue)
                        .frame(width: 32, height: 32)
                        .background(Color.mainBlue.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(resource.title)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                            .lineLimit(2)
                        
                        if isSelected {
                            Text("Tap to collapse")
                                .font(.caption2)
                                .foregroundColor(.mainBlue)
                                .transition(.opacity.combined(with: .scale(scale: 0.8)))
                        }
                    }
                    
                    Spacer()
                    
                    
                    Image(systemName: isSelected ? "chevron.up" : "chevron.down")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.mainBlue)
                        .rotationEffect(.degrees(isSelected ? 180 : 0))
                        .animation(.easeInOut(duration: 0.2), value: isSelected)
                }
                
                
                if isSelected {
                    VStack(alignment: .leading, spacing: 16) {
                        Divider()
                            .padding(.vertical, 4)
                        
                        
                        HStack(spacing: 12) {
                            Image(systemName: "person.circle.fill")
                                .font(.title3)
                                .foregroundColor(.mainBlue)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Contact Person")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
                                    .textCase(.uppercase)
                                    .tracking(0.5)
                                
                                Text(resource.contactPerson)
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                        
                       
                        HStack(spacing: 12) {
                            Image(systemName: "phone.circle.fill")
                                .font(.title3)
                                .foregroundColor(.mainBlue)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Contact Details")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
                                    .textCase(.uppercase)
                                    .tracking(0.5)
                                
                                Text(resource.contactDetails)
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundColor(.primary)
                            }
                            
                            Spacer()
                        }
                        
                        
                        HStack(spacing: 12) {
                            Button(action: {
                               
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: "phone.fill")
                                        .font(.caption)
                                    Text("Call")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.mainBlue)
                                .clipShape(Capsule())
                            }
                            
                            Button(action: {
                                
                            }) {
                                HStack(spacing: 6) {
                                    Image(systemName: "envelope.fill")
                                        .font(.caption)
                                    Text("Email")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                }
                                .foregroundColor(.mainBlue)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color.mainBlue.opacity(0.1))
                                .clipShape(Capsule())
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 8)
                    }
                    .transition(.asymmetric(
                        insertion: .opacity.combined(with: .move(edge: .top)),
                        removal: .opacity.combined(with: .move(edge: .top))
                    ))
                }
            }
            .padding(20)
        }
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    isSelected ? Color.mainBlue.opacity(0.3) : Color(.separator),
                    lineWidth: isSelected ? 2 : 0.5
                )
        )
        .shadow(
            color: isSelected ? Color.mainBlue.opacity(0.15) : Color.black.opacity(0.05),
            radius: isSelected ? 8 : 4,
            x: 0,
            y: isSelected ? 4 : 2
        )
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
}
