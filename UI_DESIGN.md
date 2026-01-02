# Nag App UI Design

## Visual Design Philosophy
The Nag app follows a hyper-minimalistic design with a focus on elegance and clarity.

## Main Screen (TodoListView)

```
┌─────────────────────────────────┐
│  < Nag                       [+]│  Navigation bar with add button
├─────────────────────────────────┤
│                                 │
│  ┌─────────────────────────┐   │  Pending Tasks Section
│  │ ○  Buy groceries        │   │  
│  │    Next nag in 4:35     │   │  Circle = uncompleted
│  └─────────────────────────┘   │  Orange text = countdown
│                                 │
│  ┌─────────────────────────┐   │
│  │ ○  Call dentist         │   │
│  │    Next nag in 2:17     │   │
│  └─────────────────────────┘   │
│                                 │
│  Completed ───────────────────  │  Separator header
│                                 │
│  ┌─────────────────────────┐   │  Completed Tasks Section
│  │ ✓  Pay bills            │   │  
│  │                         │   │  Checkmark = completed
│  └─────────────────────────┘   │  Strikethrough text
│                                 │
└─────────────────────────────────┘
```

### Design Elements:
- **Navigation Bar**: Large title "Nag" with circular plus button
- **Task Rows**: 
  - Clean white cards with subtle shadows
  - Generous padding for touch targets
  - Circle icon for incomplete (gray)
  - Checkmark for complete (green)
- **Countdown Timer**: Orange text showing urgency
- **Swipe Actions**: Swipe left to delete
- **Empty State**: When no tasks exist:
  - Large checkmark icon
  - "No tasks yet" message
  - "Tap + to add a task" hint

## Add Task Screen (AddTodoView)

```
┌─────────────────────────────────┐
│  Cancel  New Task       Add     │  Modal sheet header
├─────────────────────────────────┤
│                                 │
│  TASK DETAILS                   │  Section header
│  ┌───────────────────────────┐ │
│  │ What needs to be done?    │ │  Text input field
│  └───────────────────────────┘ │
│                                 │
│  REMINDER FREQUENCY             │  Section header
│  ┌───────────────────────────┐ │
│  │ Interval    5 minutes  ˅  │ │  Picker dropdown
│  └───────────────────────────┘ │
│                                 │
│  You'll be nagged every         │  Helper text
│  5 minutes                      │
│                                 │
└─────────────────────────────────┘
```

### Design Elements:
- **Modal Sheet**: Slides up from bottom
- **Form Style**: Native iOS grouped form
- **Text Input**: Placeholder text for guidance
- **Picker Options**:
  - 1 minute
  - 5 minutes (default)
  - 10 minutes
  - 15 minutes
  - 30 minutes
  - 1 hour
- **Action Buttons**:
  - Cancel (leading): Dismisses without saving
  - Add (trailing, bold): Disabled until title entered

## Notification

```
┌─────────────────────────────────┐
│  🔔 Nag Reminder                │
│                                 │
│  Don't forget: Buy groceries    │
│                                 │
│  now                            │
└─────────────────────────────────┘
```

### Notification Design:
- **Title**: "Nag Reminder"
- **Body**: "Don't forget: [task title]"
- **Sound**: Default system sound
- **Badge**: Shows on app icon
- **Persistence**: Repeats at chosen interval

## Color Scheme

- **Primary Text**: System black/white (adapts to light/dark mode)
- **Secondary Text**: System gray
- **Accent**: System blue (for buttons)
- **Success**: Green (completed checkmarks)
- **Warning**: Orange (countdown timers)
- **Background**: System background (white/black with mode)
- **Cards**: System grouped background

## Typography

- **Navigation Title**: Large, bold
- **Task Title**: Body, regular weight
- **Countdown**: Caption, orange
- **Section Headers**: Headline, secondary color
- **Helper Text**: Caption, secondary color

## Animations

- **Checkmark Toggle**: Smooth scale animation
- **Sheet Presentation**: Standard modal slide-up
- **List Updates**: Fade and slide
- **Timer Updates**: No animation (every second update)

## Accessibility

- **Dynamic Type**: All text scales with system settings
- **VoiceOver**: All buttons and elements labeled
- **High Contrast**: Uses system colors that adapt
- **Haptics**: Touch feedback on interactions

## Responsive Design

- **iPhone Portrait**: Primary supported orientation
- **iPad**: Scales appropriately with larger fonts
- **Safe Areas**: Respects notches and home indicators
