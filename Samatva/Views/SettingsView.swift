import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var state: AppState
    @Environment(\.dismiss) private var dismiss
    @State private var confirmErase = false

    var body: some View {
        NavigationStack {
            Form {
                Section("You") {
                    TextField("Name", text: $state.userName)
                        .onSubmit { state.save() }
                }

                Section("About Samatva") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Samatva — Sanskrit for equanimity. \u{201C}Samatvam yoga ucyate\u{201D}: evenness of mind is excellence in action (Bhagavad Gita 2.48).")
                        Text("Built as a pocket support system for demanding days: short lessons, honest check-ins, and tools for the moments that run hot.")
                            .foregroundStyle(.secondary)
                    }
                    .font(.subheadline)
                    .padding(.vertical, 4)
                }

                Section("Privacy") {
                    Label("Everything stays on this phone. No account, no cloud, no analytics.", systemImage: "lock")
                        .font(.subheadline)
                }

                Section {
                    Text("Samatva is an educational companion, not a medical or mental-health service. If low mood, anger or anxiety are seriously affecting your life, a professional is the right next step — in the UK, you can self-refer to NHS Talking Therapies, or call Samaritans on 116 123 any time.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                } header: {
                    Text("A note on limits")
                }

                Section {
                    Button("Erase all data", role: .destructive) {
                        confirmErase = true
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        state.save()
                        dismiss()
                    }
                }
            }
            .confirmationDialog("Erase everything? This can't be undone.",
                                isPresented: $confirmErase,
                                titleVisibility: .visible) {
                Button("Erase all data", role: .destructive) {
                    state.eraseAll()
                    dismiss()
                }
            }
        }
    }
}
