import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Image(systemName: "dumbbell.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)

                Text("MuscuLog")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Carnet d'entraînement")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Accueil")
        }
    }
}

#Preview {
    ContentView()
}
