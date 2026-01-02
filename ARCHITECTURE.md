# Nag App Architecture

## Overview
Nag is a SwiftUI-based iOS application that implements a todo list with persistent, recurring notifications.

## Key Components

### 1. NagApp.swift
- Main app entry point using `@main` attribute
- Initializes the NotificationManager
- Sets up the app's environment

### 2. TodoItem.swift
- Data model for todo items
- Properties:
  - `id`: Unique identifier (UUID)
  - `title`: Task description
  - `isCompleted`: Completion status
  - `reminderInterval`: Time between notifications (in seconds)
  - `createdAt`: Creation timestamp
- Conforms to: Identifiable, Codable, Hashable

### 3. ContentView.swift
- Main content view
- Hosts TodoStore (ObservableObject) for state management
- Manages navigation and the Add Todo sheet
- TodoStore handles:
  - Adding items with notification scheduling
  - Toggling completion status
  - Deleting items
  - Persistence via UserDefaults

### 4. TodoListView.swift
- Displays the list of todos
- Separates pending and completed items
- Each TodoRowView shows:
  - Completion checkbox
  - Task title
  - Real-time countdown to next notification
- Updates every second using Timer

### 5. AddTodoView.swift
- Sheet view for adding new tasks
- Allows users to:
  - Enter task title
  - Select reminder interval (1 min to 1 hour)
- Validates input before allowing submission

### 6. NotificationManager.swift
- Handles all notification operations
- Responsibilities:
  - Request notification permissions
  - Schedule recurring notifications
  - Cancel notifications when tasks complete
  - Implement UNUserNotificationCenterDelegate
- Uses UNTimeIntervalNotificationTrigger with repeat

## Design Principles

### Minimalism
- Clean, uncluttered interface
- System fonts and icons
- Native iOS design patterns
- Minimal color palette (system colors)

### Persistence
- Recurring notifications continue until task completion
- Local storage using UserDefaults
- Notifications survive app restarts

### User Experience
- Real-time countdown shows urgency
- Clear visual separation of completed/pending tasks
- Smooth SwiftUI animations
- Intuitive gestures (swipe to delete)

## Data Flow

1. User adds task → TodoStore creates TodoItem
2. TodoStore schedules notification via NotificationManager
3. TodoItem saved to UserDefaults
4. Timer in TodoRowView updates countdown every second
5. When user marks complete → Notification canceled
6. On app restart → Items loaded from UserDefaults

## Notification Strategy

- Uses `UNTimeIntervalNotificationTrigger` with `repeats: true`
- Each task has its own notification identifier (UUID)
- Notifications persist even when app is closed
- iOS system handles delivery timing

## Technologies Used

- SwiftUI for UI
- UserNotifications framework
- UserDefaults for persistence
- Combine (via @Published/@ObservedObject)
- Timer for real-time updates

## Building Requirements

- iOS 16.0+
- Xcode 15.0+
- Swift 5.0+
