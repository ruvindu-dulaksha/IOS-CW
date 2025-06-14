import SwiftUI

struct CrowdLevelRow: View {
    var area: Area
    @ObservedObject var viewModel: CrowdViewModel
    var isModeratorMode: Bool = true     
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(area.name)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text(area.status.rawValue)
                    .font(.subheadline)
                    .foregroundColor(area.status.color)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(area.status.color.opacity(0.1))
                    .cornerRadius(8)
            }
            
            HStack(spacing: 12) {
                ForEach(0..<6) { index in
                    Image(systemName: "person.fill")
                        .font(.system(size: 18))
                        .foregroundColor(index < area.peopleCount ? area.status.color : Color(.systemGray4))
                        .onTapGesture {
                           
                            if isModeratorMode {
                                if index < area.peopleCount {
                                    viewModel.decreasePeople(in: area)
                                } else {
                                    viewModel.increasePeople(in: area)
                                }
                            }
                        }
                        
                        .opacity(isModeratorMode ? 1.0 : 0.8)
                }

                Spacer()

                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 12, height: 50)
                    .foregroundColor(area.status.color)
            }
            
            if !isModeratorMode {
                HStack {
                    Image(systemName: "lock.fill")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text("Read Only - Moderator access required")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.top, 4)
            }
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: Color(.black).opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
