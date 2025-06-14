import SwiftUI

struct CrowdDetailView: View {
    @ObservedObject var viewModel: CrowdViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Moderator - Crowd Details")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(Color("MainBlueColor"))

            Text("Tap the person icons to adjust crowd levels")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)

            
            ForEach(viewModel.areas) { area in
                CrowdLevelRow(area: area, viewModel: viewModel, isModeratorMode: true)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Moderator Panel")
        .navigationBarTitleDisplayMode(.inline)
    }
}
