import SwiftUI
import SwiftData

struct ActiveWorkoutView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let workoutTemplate: WorkoutTemplate

    // État local pour le workout en cours
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

    private func startWorkout() {
        guard completedWorkout == nil else { return }

        // Créer l'objet historique
        let newCompletedWorkout = CompletedWorkout(
            programName: workoutTemplate.program?.name ?? "Sans programme",
            workoutName: workoutTemplate.name
        )
        modelContext.insert(newCompletedWorkout)

        // Générer les exercices et les séries vides
        let sortedTemplates = workoutTemplate.exercises.sorted(by: { $0.displayOrder < $1.displayOrder })
        for (index, exTemplate) in sortedTemplates.enumerated() {
            let compEx = CompletedExercise(exerciseName: exTemplate.name, displayOrder: index)
            compEx.workout = newCompletedWorkout
            modelContext.insert(compEx)

            for i in 1...exTemplate.targetSets {
                let compSet = CompletedSet(weight: 0, reps: 0, setNumber: i)
                compSet.exercise = compEx
                modelContext.insert(compSet)
            }
        }

        completedWorkout = newCompletedWorkout
    }

    private func finishWorkout() {
        completedWorkout?.finishedAt = Date()
        try? modelContext.save()
        dismiss()
    }

    private func cancelWorkout() {
        if let completedWorkout {
            modelContext.delete(completedWorkout)
            try? modelContext.save()
        }
        dismiss()
    }
}
