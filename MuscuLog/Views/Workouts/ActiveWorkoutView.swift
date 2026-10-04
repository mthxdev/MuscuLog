import SwiftUI
import SwiftData

struct ActiveWorkoutView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let workoutTemplate: WorkoutTemplate

    @State private var completedWorkout: CompletedWorkout?
    @State private var showingCancelAlert = false

    var body: some View {
        NavigationStack {
            Group {
                if let completedWorkout {
                    List {
                        ForEach(completedWorkout.exercises.sorted(by: { $0.displayOrder < $1.displayOrder })) { exercise in
                            Section {
                                ForEach(exercise.sets.sorted(by: { $0.setNumber < $1.setNumber })) { set in
                                    ActiveSetRowView(set: set)
                                }
                            } header: {
                                Text(exercise.exerciseName)
                                    .font(.headline)
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                } else {
                    ProgressView("Préparation de la séance…")
                }
            }
            .navigationTitle("En cours")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler", role: .destructive) {
                        showingCancelAlert = true
                    }
                    .foregroundStyle(.red)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Terminer") {
                        finishWorkout()
                    }
                    .bold()
                }
            }
            .alert("Annuler la séance ?", isPresented: $showingCancelAlert) {
                Button("Continuer l'entraînement", role: .cancel) { }
                Button("Supprimer et quitter", role: .destructive) {
                    cancelWorkout()
                }
            } message: {
                Text("Toutes les données de cette séance seront perdues.")
            }
            .onAppear {
                startWorkout()
            }
        }
    }

    @MainActor
    private func getPreviousExercise(name: String) -> CompletedExercise? {
        let descriptor = FetchDescriptor<CompletedWorkout>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        let allWorkouts = (try? modelContext.fetch(descriptor)) ?? []
        
        for w in allWorkouts {
            if let ex = w.exercises.first(where: { $0.exerciseName == name }) {
                return ex
            }
        }
        return nil
    }

    @MainActor
    private func startWorkout() {
        guard completedWorkout == nil else { return }

        let newCompletedWorkout = CompletedWorkout(
            programName: workoutTemplate.program?.name ?? "Sans programme",
            workoutName: workoutTemplate.name
        )
        modelContext.insert(newCompletedWorkout)

        let sortedTemplates = workoutTemplate.exercises.sorted(by: { $0.displayOrder < $1.displayOrder })
        
        for (index, exTemplate) in sortedTemplates.enumerated() {
            let compEx = CompletedExercise(exerciseName: exTemplate.name, displayOrder: index)
            compEx.workout = newCompletedWorkout
            modelContext.insert(compEx)

            let previousEx = getPreviousExercise(name: exTemplate.name)

            for i in 1...exTemplate.targetSets {
                let prevSet = previousEx?.sets.first(where: { $0.setNumber == i })
                let weight = prevSet?.weight ?? 0
                let reps = prevSet?.reps ?? 0
                
                let compSet = CompletedSet(weight: weight, reps: reps, setNumber: i)
                compSet.exercise = compEx
                modelContext.insert(compSet)
            }
        }

        completedWorkout = newCompletedWorkout
    }

    @MainActor
    private func finishWorkout() {
        completedWorkout?.finishedAt = Date()
        try? modelContext.save()
        
        // Vibration de succès native Apple
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        BackupManager.shared.autoBackup(context: modelContext)
        dismiss()
    }

    @MainActor
    private func cancelWorkout() {
        if let completedWorkout {
            modelContext.delete(completedWorkout)
            try? modelContext.save()
        }
        dismiss()
    }
}
