import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Button {
                        // TODO: Phase 9 — Export
                    } label: {
                        Label("Exporter mes données", systemImage: "square.and.arrow.up")
                    }

                    Button {
                        // TODO: Phase 9 — Import
                    } label: {
                        Label("Importer mes données", systemImage: "square.and.arrow.down")
                    }
                } header: {
                    Text("Sauvegarde")
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
        }
    }
}

#Preview {
    SettingsView()
}
