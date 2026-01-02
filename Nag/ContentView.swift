import SwiftUI

struct ContentView: View {
    @StateObject private var todoStore = TodoStore()
    @EnvironmentObject var notificationManager: NotificationManager
    @State private var showingAddTodo = false
    
    var body: some View {
        NavigationStack {
            TodoListView(todoStore: todoStore)
                .navigationTitle("Nag")
                .navigationBarTitleDisplayMode(.large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingAddTodo = true }) {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .sheet(isPresented: $showingAddTodo) {
                    AddTodoView(todoStore: todoStore)
                }
        }
    }
}

class TodoStore: ObservableObject {
    @Published var items: [TodoItem] = []
    private static let storageKey = "todoItems"
    
    init() {
        loadItems()
        rescheduleNotifications()
    }
    
    func addItem(_ item: TodoItem) {
        items.append(item)
        saveItems()
        NotificationManager.scheduleNotification(for: item)
    }
    
    func toggleComplete(_ item: TodoItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].isCompleted.toggle()
            if items[index].isCompleted {
                NotificationManager.cancelNotifications(for: item.id)
            } else {
                NotificationManager.scheduleNotification(for: items[index])
            }
            saveItems()
        }
    }
    
    func deleteItem(_ item: TodoItem) {
        items.removeAll { $0.id == item.id }
        NotificationManager.cancelNotifications(for: item.id)
        saveItems()
    }
    
    private func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: TodoStore.storageKey)
        }
    }
    
    private func loadItems() {
        if let data = UserDefaults.standard.data(forKey: TodoStore.storageKey),
           let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) {
            items = decoded
        }
    }
    
    private func rescheduleNotifications() {
        for item in items where !item.isCompleted {
            NotificationManager.scheduleNotification(for: item)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(NotificationManager())
}
