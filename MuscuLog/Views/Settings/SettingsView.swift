import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingFileImporter = false
    @State private var showingImportAlert = false
    @State private var importMessage = ""
    @State private var importedURL: URL?

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("À chaque fois que tu termines une séance, MuscuLog génère automatiquement un fichier de sauvegarde dans l'application Fichiers (dossier 'Sur mon iPhone' > MuscuLog).")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Button {
                        BackupManager.shared.autoBackup(context: modelContext)
                    } label: {
                        Label("Forcer la création du dossier", systemImage: "folder.badge.plus")
                    }

                    Button {
                        showingFileImporter = true
                    } label: {
                        Label("Restaurer depuis une sauvegarde", systemImage: "arrow.down.doc")
                    }
                } header: {
                    Text("Sauvegarde automatique")
                }

                Section {
                    Button(role: .destructive) {
                        BackupManager.shared.deleteAllData(context: modelContext)
                    } label: {
                        Label("Tout supprimer", systemImage: "trash")
                    }
                } header: {
                    Text("Zone de danger")
                } footer: {
                    Text("Efface instantanément tout l'historique et la progression.")
                }

                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundStyle(.secondary)
                    }
                } header: {
                    Text("À propos")
                }
            }
            .navigationTitle("Réglages")
            .fileImporter(
                isPresented: $showingFileImporter,
                allowedContentTypes: [.json],
                allowsMultipleSelection: false
            ) { result in
                switch result {
                case .success(let urls):
                    if let url = urls.first {
                        importedURL = url
                        importMessage = "Attention : Restaurer une sauvegarde va effacer ton historique actuel pour le remplacer par celui du fichier. Veux-tu continuer ?"
                        showingImportAlert = true
                    }
                case .failure(let error):
                    print("Erreur d'import : \(error)")
                }
            }
            .alert("Confirmer la restauration", isPresented: $showingImportAlert) {
                Button("Annuler", role: .cancel) { }
                Button("Restaurer", role: .destructive) {
                    if let url = importedURL {
                        do {
                            try BackupManager.shared.importBackup(from: url, context: modelContext)
                        } catch {
                            print("Erreur pendant la restauration : \(error)")
                        }
                    }
                }
            } message: {
                Text(importMessage)
            }
        }
    }
}
