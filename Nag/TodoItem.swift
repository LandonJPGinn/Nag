import Foundation

struct TodoItem: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var reminderInterval: TimeInterval
    var createdAt: Date
    
    init(id: UUID = UUID(), title: String, isCompleted: Bool = false, reminderInterval: TimeInterval = 300, createdAt: Date = Date()) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.reminderInterval = reminderInterval
        self.createdAt = createdAt
    }
}
