import SwiftUI
import SwiftData

struct HomeView: View {
    @Query(sort: \Program.createdAt) private var programs: [Program]
    @Query(sort: \CompletedWorkout.date, order: .reverse) private var completedWorkouts: [CompletedWorkout]

    var body: some View {
        NavigationStack {
            List {
                // Dernière séance
                if let lastWorkout = completedWorkouts.first {
                    Section {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(lastWorkout.workoutName)
                                .font(.headline)
                            Text("\(lastWorkout.programName) — \(lastWorkout.date.formatted(date: .long, time: .omitted))")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    } header: {
                        Text("Dernière séance")
                    }
                }

                // Programmes
                Section {
                    if programs.isEmpty {
                        Text("Aucun programme")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(programs) { program in
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(program.name)
                                        .font(.headline)
                                    Text("\(program.workouts.count) séance\(program.workouts.count > 1 ? "s" : "")")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                } header: {
                    Text("Mes programmes")
                }
            }
            .navigationTitle("MuscuLog")
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [Program.self, CompletedWorkout.self], inMemory: true)
}
