import SwiftUI

struct ScheduleView: View {
    @StateObject private var presenter = ScheduleViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
               
                HStack {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "bell")
                            .foregroundColor(.black)
                            .font(.system(size: 20, weight: .medium))
                    }

                    Spacer()

                    HStack(spacing: 0) {
                        Text("NIBM ")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.blue)
                        Text("UNI BUDDY")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.red)
                    }

                    Spacer()

                    Button(action: {
                        
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 24))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .background(Color.white)

               
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(presenter.scheduleItems) { item in
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
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
