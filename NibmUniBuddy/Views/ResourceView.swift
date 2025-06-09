
import SwiftUI

struct ResourceView: View {
    @StateObject private var presenter = ResourcePresenter()
    @State private var selectedResourceID: UUID?

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Our Resources")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("MainBlueColor"))
                    .padding(.bottom, 10)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .center)

                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(presenter.resources) { resource in
                            ResourceCard(resource: resource, isSelected: selectedResourceID == resource.id)
                                .onTapGesture {
                                    selectedResourceID = resource.id
                                }
                        }
                    }
                    .padding(.horizontal, 5)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("< Back") {
                        
                    }.foregroundColor(Color("subGreycolor"))
                    
                }
            }
        }
    }
}

struct ResourceCard: View {
    let resource: Resource
    let isSelected: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(resource.title)
                .font(.headline)
                .foregroundColor(Color("MainBlueColor"))
            Text("Contact Person - \(resource.contactPerson)")
                .font(.subheadline)
                .foregroundColor(Color("subGreycolor"))
            Text("Contact Details - \(resource.contactDetails)")
                .font(.subheadline)
                .foregroundColor(Color("subGreycolor"))
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isSelected ? Color.blue.opacity(0.1) : Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: isSelected ? 2 : 1)
        )
        .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
        .padding(.horizontal, 8)
    }
}

#Preview {
    ResourceView()
}
