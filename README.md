# 📢 University Notice Board App

A modern, cross-platform Flutter application for managing university notices and announcements. This app provides an intuitive interface for creating, viewing, filtering, and searching notices across different categories.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)

---

## 📋 Table of Contents

- [Features](#-features)
- [Screenshots](#-screenshots)
- [Project Structure](#-project-structure)
- [Technology Stack](#-technology-stack)
- [Getting Started](#-getting-started)
- [Usage](#-usage)
- [Architecture](#-architecture)
- [Contributing](#-contributing)

---

## ✨ Features

### Core Features
- **📝 Create Notices** - Add new notices with title, description, and category
- **📖 View Notice Details** - View complete notice information in a detailed view
- **🔍 Search Functionality** - Search notices by title or description
- **🏷️ Category Filtering** - Filter notices by categories (Exam, Event, Academic, General)
- **📎 File Attachment Support** - Attach files to notices (PDF, JPG, PNG, DOC, etc.)

### Categories
| Category | Color | Icon | Use Case |
|----------|-------|------|----------|
| 🔴 Exam | Red | School | Examination schedules, results |
| 🟢 Event | Green | Event | University events, functions |
| 🔵 Academic | Blue | Book | Academic announcements |
| 🟠 General | Orange | Info | General information |

### UI/UX Features
- **Material Design** - Clean and modern UI following Material Design principles
- **Responsive Layout** - Works seamlessly across different screen sizes
- **Category Color Coding** - Visual distinction between different notice types
- **Horizontal Category Filter** - Easy swipe-based category selection
- **Card-based Layout** - Beautiful card design for notice display

---

## 📸 Screenshots

### Home Screen - Notice List
<p align="center">
  <img src="Screenshots/Screenshot 2025-10-03 134706.png" width="250" alt="Home Screen"/>
  <img src="Screenshots/Screenshot 2025-10-03 135634.png" width="250" alt="Notice List"/>
</p>

### Category Filter & Search
<p align="center">
  <img src="Screenshots/Screenshot 2025-10-03 135717.png" width="250" alt="Category Filter"/>
  <img src="Screenshots/Screenshot 2025-10-03 135725.png" width="250" alt="Search Feature"/>
</p>

### Add Notice & Notice Details
<p align="center">
  <img src="Screenshots/Screenshot 2025-10-03 135740.png" width="250" alt="Add Notice"/>
  <img src="Screenshots/Screenshot 2025-10-03 135756.png" width="250" alt="Notice Details"/>
  <img src="Screenshots/Screenshot 2025-10-03 135804.png" width="250" alt="Notice Form"/>
</p>

---

## 📁 Project Structure

```
university_notice_board_app/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── database/
│   │   ├── database_helper.dart     # Database operations (CRUD)
│   │   └── db_helper.dart           # Additional DB utilities
│   ├── models/
│   │   ├── notice.dart              # Notice data model
│   │   └── category.dart            # Category enum & helper
│   ├── screens/
│   │   ├── notice_list_screen.dart  # Main list view
│   │   ├── notice_entry_screen.dart # Add/Edit notice form
│   │   └── notice_detail_screen.dart# Notice detail view
│   ├── utils/
│   │   ├── constants.dart           # App constants & strings
│   │   └── file_helper.dart         # File handling utilities
│   └── widgets/
│       ├── notice_cart.dart         # Notice card widgets
│       ├── category_filter.dart     # Category filter widget
│       └── file_upload_widget.dart  # File upload component
├── android/                         # Android platform files
├── ios/                             # iOS platform files
├── linux/                           # Linux platform files
├── macos/                           # macOS platform files
├── web/                             # Web platform files
├── windows/                         # Windows platform files
├── Screenshots/                     # App screenshots
├── test/                            # Widget tests
├── pubspec.yaml                     # Dependencies & config
└── README.md                        # Project documentation
```

---

## 🛠️ Technology Stack

| Technology | Purpose |
|------------|---------|
| **Flutter 3.x** | Cross-platform UI framework |
| **Dart 3.8.1+** | Programming language |
| **Material Design** | UI/UX design system |
| **In-Memory Database** | Data persistence (Singleton pattern) |

### Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.8.1 or higher)
- Dart SDK (3.8.1 or higher)
- Android Studio / VS Code with Flutter extensions
- Android Emulator / iOS Simulator / Physical device

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/AnshGajera/Flutter_Projects.git
   cd university_notice_board_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   # For debug mode
   flutter run
   
   # For specific platform
   flutter run -d android
   flutter run -d ios
   flutter run -d chrome  # Web
   flutter run -d windows # Windows
   ```

4. **Build for production**
   ```bash
   # Android APK
   flutter build apk --release
   
   # Android App Bundle
   flutter build appbundle --release
   
   # iOS
   flutter build ios --release
   
   # Web
   flutter build web --release
   ```

---

## 📖 Usage

### Adding a Notice
1. Tap the **+** floating action button on the home screen
2. Fill in the notice details:
   - **Title**: Enter a descriptive title (max 100 characters)
   - **Description**: Provide detailed information (max 1000 characters)
   - **Category**: Select from Exam, Event, Academic, or General
   - **Attachment**: Optionally attach a file
3. Tap **"Add Notice"** to save

### Searching Notices
1. Use the search bar at the top of the home screen
2. Type keywords to search by title or description
3. Results filter in real-time as you type

### Filtering by Category
1. Scroll horizontally through category chips below the search bar
2. Tap a category (All, Exam, Event, Academic, General)
3. The notice list updates to show only matching notices

### Viewing Notice Details
1. Tap on any notice card in the list
2. View complete notice information including:
   - Title
   - Category badge
   - Date
   - Full description
   - Attachment status

---

## 🏗️ Architecture

### Design Pattern
The app follows a **simple MVC-like architecture**:

```
┌─────────────────────────────────────────────────────────┐
│                        Screens                          │
│  (notice_list_screen, notice_entry_screen, detail_screen)│
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────┐
│                      Widgets                            │
│    (notice_card, category_filter, file_upload)          │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────┐
│                       Models                            │
│              (Notice, Category)                         │
└─────────────────────────┬───────────────────────────────┘
                          │
┌─────────────────────────▼───────────────────────────────┐
│                    Database                             │
│              (DatabaseHelper - Singleton)               │
└─────────────────────────────────────────────────────────┘
```

### Data Model

#### Notice Model
```dart
class Notice {
  final int? id;
  final String title;
  final String description;
  final String category;
  final String date;
  final String? filePath;
}
```

#### Category Enum
```dart
enum NoticeCategory { exam, event, academic, general }
```

### Database Operations
The `DatabaseHelper` class provides:
- `insertNotice()` - Create new notice
- `getAllNotices()` - Retrieve all notices
- `getNoticesByCategory()` - Filter by category
- `updateNotice()` - Update existing notice
- `deleteNotice()` - Remove notice
- `searchNotices()` - Search functionality

---

## 🎨 UI Constants

| Constant | Value | Usage |
|----------|-------|-------|
| Default Padding | 16.0 | Standard spacing |
| Border Radius | 12.0 | Card corners |
| Title Font Size | 22.0 | Main headings |
| Body Font Size | 14.0 | Regular text |
| Max Title Length | 100 | Input validation |
| Max Description Length | 1000 | Input validation |

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

## 👨‍💻 Author

**Ansh Gajera**

- GitHub: [@AnshGajera](https://github.com/AnshGajera)

---

## 🙏 Acknowledgments

- Flutter Team for the amazing framework
- Material Design for UI guidelines
- All contributors and testers

---

<p align="center">
  Made with ❤️ using Flutter
</p>
