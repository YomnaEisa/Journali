# Journali 

**Journali** is a personal journaling app built with SwiftUI, utilizing SwiftData to persist entries. Journali allows users to create, edit, bookmark, and manage journal entries with ease, providing a seamless and organized experience.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Architecture](#architecture)

---

## Features

- **Create and Edit Entries**: Easily create and edit journal entries with titles, dates, and content.
- **Bookmark Feature**: Mark important entries as "bookmarked" for quick access.
- **Filtered Views**: View all entries, bookmarked entries, or sorted entries by date.
- **Custom Theming**: The app incorporates custom colors and themes for a personalized look.
- **Persistent Storage**: Journal entries are saved and persist between sessions using SwiftData.

## Installation

1. Clone this repository:
    ```bash
    git clone https://github.com/your-username/journali.git
    cd journali
    ```

2. Open the project in Xcode:
   - Double-click the `Journali.xcodeproj` file to open in Xcode.
   
3. Build and run the project on a simulator or physical device with iOS 15 or later.

## Usage

### Main View
- The main view displays all journal entries, along with options to filter by "Bookmarked" or "Date."
- Use the plus icon to add a new journal entry.

### Adding/Editing Entries
- Press the plus button to create a new entry. Use the provided fields to add a title, content, and date.
- Press "Save" to save the entry or "Cancel" to discard changes.

### Bookmarks
- Tap the bookmark icon next to each entry to mark it as important.
- Access all bookmarked entries through the filter menu.

## Architecture

Journali follows the MVVM (Model-View-ViewModel) design pattern:

- **Model**: Core Data entities representing each journal entry.
- **ViewModel**: Handles business logic and data manipulation, providing data to views.
- **View**: SwiftUI views display entries, use themes, and interact with user input.

### Key Classes

- **ViewModel.swift**: Contains logic for adding, editing, deleting, and filtering journal entries.
- **MainView.swift**: Displays journal entries and handles navigation.
- **Journal.swift**: Data model representing a single journal entry.

---

Happy journaling! 😊
