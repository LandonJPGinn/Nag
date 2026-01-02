import SwiftUI

struct AddTodoView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var todoStore: TodoStore
    
    @State private var title: String = ""
    @State private var selectedInterval: TimeInterval = 300
    
    let intervals: [(String, TimeInterval)] = [
        ("1 minute", 60),
        ("5 minutes", 300),
        ("10 minutes", 600),
        ("15 minutes", 900),
        ("30 minutes", 1800),
        ("1 hour", 3600)
    ]
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Task Details")) {
                    TextField("What needs to be done?", text: $title)
                        .font(.body)
                }
                
                Section(header: Text("Reminder Frequency")) {
                    Picker("Interval", selection: $selectedInterval) {
                        ForEach(intervals, id: \.1) { interval in
                            Text(interval.0).tag(interval.1)
                        }
                    }
                    .pickerStyle(.menu)
                    
                    Text("You'll be nagged every \(intervalText)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        addTodo()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                    .bold()
                }
            }
        }
    }
    
    private var intervalText: String {
        intervals.first { $0.1 == selectedInterval }?.0 ?? ""
    }
    
    private func addTodo() {
        let trimmedTitle = title.trimmingCharacters(in: .whitespaces)
        guard !trimmedTitle.isEmpty else { return }
        
        let newItem = TodoItem(
            title: trimmedTitle,
            reminderInterval: selectedInterval
        )
        todoStore.addItem(newItem)
        dismiss()
    }
}
