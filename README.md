# OivanAssignmentHub - Stack Overflow Users App

A Flutter application that displays Stack Overflow users with their profiles and reputation history.

## 🚀 Features

- **User List**: Browse Stack Overflow users with infinite scroll pagination
- **User Details**: View detailed user profiles with reputation history
- **Bookmarks**: Save and manage favorite users locally
- **Pull-to-Refresh**: Refresh data on all pages
- **Offline Storage**: Bookmark data persisted using Hive
- **Responsive UI**: Custom widgets with adaptive text scaling
- **Clean Architecture**: BLoC pattern with separation of concerns

## 📱 Screenshots

The app includes:
- User list page with shimmer loading
- User detail page with custom profile header
- Bookmark page for saved users
- Reputation history with pagination

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **BLoC** state management:

```
lib/
├── core/              # Core utilities and services
├── di/                # Dependency injection
├── features/          # Feature modules
│   ├── bookmark/
│   ├── user_details/
│   └── user_list/
└── shared_widgets/    # Reusable UI components
```

## 📦 Tech Stack

- **Framework**: Flutter 3.0+
- **State Management**: BLoC/Cubit
- **Networking**: Dio
- **Local Storage**: Hive + SharedPreferences
- **Dependency Injection**: GetIt
- **Image Caching**: cached_network_image
- **UI**: Custom widgets with shimmer effects

## 🛠️ Setup & Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- iOS Simulator / Android Emulator

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/maryamamr/OivanAssignmentHub.git
   cd OivanAssignmentHub
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 📚 Documentation

Comprehensive project documentation is available in `PROJECT_DOCUMENTATION.md`, which includes:
- Detailed architecture overview
- Feature descriptions
- Code examples
- API integration details
- Setup instructions

## 🔑 Key Dependencies

| Package | Purpose |
|---------|---------|
| flutter_bloc | State management |
| dio | HTTP client |
| hive | Local NoSQL database |
| get_it | Dependency injection |
| cached_network_image | Image caching |
| shimmer | Loading effects |

## 🌐 API

The app uses the Stack Overflow API:
- Base URL: `https://api.stackexchange.com/2.3`
- No authentication required

## 📝 Project Structure

- **Clean Architecture**: Separation of data, domain, and presentation layers
- **BLoC Pattern**: Predictable state management
- **Repository Pattern**: Abstract data sources
- **Dependency Injection**: Centralized service management

## 🎯 Features Implemented

- ✅ User list with pagination (15 users per page)
- ✅ User detail page with reputation history
- ✅ Bookmark functionality with local storage
- ✅ Pull-to-refresh on all pages
- ✅ Shimmer loading effects
- ✅ Error handling and retry mechanisms
- ✅ Responsive text scaling
- ✅ Custom UI components

## 🔧 Development

### Running Tests
```bash
flutter test
```

### Building for Production
```bash
# iOS
flutter build ios

# Android
flutter build apk
```

## 📄 License

This project is created as an assignment for educational purposes.

## 👤 Author

Maryam Amr

## 🙏 Acknowledgments

- Stack Overflow API for providing the data
- Flutter community for excellent packages
