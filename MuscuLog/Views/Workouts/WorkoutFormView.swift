import SwiftUI
import SwiftData

struct WorkoutFormView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var program: Program
    var workout: WorkoutTemplate?

    @State private var name: String = ""

    var isEditing: Bool { workout != nil }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Nom de la séance", text: $name)
                        .autocorrectionDisabled()
                } header: {
                    Text("Nom")
                } footer: {
                    Text("Exemple : Upper A, Lower B, Push…")
                }
            }
            .navigationTitle(isEditing ? "Modifier" : "Nouvelle séance")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Annuler") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(isEditing ? "Enregistrer" : "Créer") {
                        save()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onAppear {
                if let workout {
                    name = workout.name
                }
            }
        }
    }

    private func save() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        if let workout {
            workout.name = trimmedName
        } else {
            let newWorkout = WorkoutTemplate(name: trimmedName, displayOrder: program.workouts.count)
            newWorkout.program = program
            modelContext.insert(newWorkout)
        }
        dismiss()
    }
}

#Preview {
    let program = Program(name: "Upper/Lower")
    return WorkoutFormView(program: program)
        .modelContainer(for: Program.self, inMemory: true)
}
