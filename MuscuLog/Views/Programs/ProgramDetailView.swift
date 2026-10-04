import SwiftUI
import SwiftData

struct ProgramDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var program: Program

    @State private var showingEditProgram = false
    @State private var showingAddWorkout = false

    var sortedWorkouts: [WorkoutTemplate] {
        program.workouts.sorted { $0.displayOrder < $1.displayOrder }
    }

    var body: some View {
        List {
            // Séances du programme
            Section {
                if sortedWorkouts.isEmpty {
                    Text("Aucune séance")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(sortedWorkouts) { workout in
                        VStack(alignment: .leading, spacing: 2) {
                            Text(workout.name)
                                .font(.headline)
                            Text("\(workout.exercises.count) exercice\(workout.exercises.count > 1 ? "s" : "")")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: deleteWorkouts)
                }
            } header: {
                Text("Séances")
            }
        }
        .navigationTitle(program.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button {
                        showingAddWorkout = true
                    } label: {
                        Label("Ajouter une séance", systemImage: "plus")
                    }
                    Button {
                        showingEditProgram = true
                    } label: {
                        Label("Renommer le programme", systemImage: "pencil")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .sheet(isPresented: $showingEditProgram) {
            ProgramFormView(program: program)
        }
        .sheet(isPresented: $showingAddWorkout) {
            WorkoutFormView(program: program)
        }
    }

    private func deleteWorkouts(at offsets: IndexSet) {
        let workoutsToDelete = offsets.map { sortedWorkouts[$0] }
        for workout in workoutsToDelete {
            modelContext.delete(workout)
        }
    }
}

#Preview {
    let program = Program(name: "Upper/Lower")
    return NavigationStack {
        ProgramDetailView(program: program)
    }
    .modelContainer(for: Program.self, inMemory: true)
}
