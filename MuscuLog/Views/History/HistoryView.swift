import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \CompletedWorkout.date, order: .reverse) private var workouts: [CompletedWorkout]

    var body: some View {
        NavigationStack {
            List {
                if workouts.isEmpty {
                    ContentUnavailableView(
                        "Aucune séance",
                        systemImage: "clock",
                        description: Text("Tes séances terminées apparaîtront ici.")
                    )
                } else {
                    ForEach(workouts) { workout in
                        NavigationLink(destination: HistoryDetailView(workout: workout)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(workout.workoutName)
                                    .font(.headline)
                                HStack {
                                    Text(workout.programName)
                                    Text("—")
                                    Text(workout.date.formatted(date: .numeric, time: .shortened))
                                }
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .navigationTitle("Historique")
        }
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: CompletedWorkout.self, inMemory: true)
}
