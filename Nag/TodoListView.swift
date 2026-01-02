import SwiftUI

struct TodoListView: View {
    @ObservedObject var todoStore: TodoStore
    
    var pendingItems: [TodoItem] {
        todoStore.items.filter { !$0.isCompleted }
    }
    
    var completedItems: [TodoItem] {
        todoStore.items.filter { $0.isCompleted }
    }
    
    var body: some View {
        List {
            if !pendingItems.isEmpty {
                Section {
                    ForEach(pendingItems) { item in
                        TodoRowView(item: item, todoStore: todoStore)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            todoStore.deleteItem(pendingItems[index])
                        }
                    }
                }
            }
            
            if !completedItems.isEmpty {
                Section(header: Text("Completed").font(.headline).foregroundColor(.secondary)) {
                    ForEach(completedItems) { item in
                        TodoRowView(item: item, todoStore: todoStore)
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            todoStore.deleteItem(completedItems[index])
                        }
                    }
                }
            }
            
            if todoStore.items.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 60))
                        .foregroundColor(.secondary)
                    Text("No tasks yet")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Text("Tap + to add a task")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 60)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct TodoRowView: View {
    let item: TodoItem
    @ObservedObject var todoStore: TodoStore
    @State private var timeRemaining: String = ""
    @State private var timer: Timer?
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                todoStore.toggleComplete(item)
            }) {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(item.isCompleted ? .green : .gray)
            }
            .buttonStyle(.plain)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.body)
                    .strikethrough(item.isCompleted)
                    .foregroundColor(item.isCompleted ? .secondary : .primary)
                
                if !item.isCompleted {
                    Text(timeRemaining)
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .onAppear {
            updateTimeRemaining()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                updateTimeRemaining()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    private func updateTimeRemaining() {
        let elapsed = Date().timeIntervalSince(item.createdAt)
        let nextNotification = item.reminderInterval - elapsed.truncatingRemainder(dividingBy: item.reminderInterval)
        
        let minutes = Int(nextNotification) / 60
        let seconds = Int(nextNotification) % 60
        timeRemaining = String(format: "Next nag in %d:%02d", minutes, seconds)
    }
}
