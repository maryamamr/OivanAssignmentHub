# Stack Overflow Users - Project Documentation

## Table of Contents
1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Project Structure](#project-structure)
4. [Features](#features)
5. [Core Components](#core-components)
6. [Dependencies](#dependencies)
7. [Setup & Installation](#setup--installation)
8. [Code Examples](#code-examples)

---

## Project Overview

**Project Name:** Oivan Assignment (Stack Overflow Users)  
**Framework:** Flutter  
**Language:** Dart  
**SDK Version:** ^3.0.0  
**Version:** 1.0.0+1

### Description
This is a Flutter application that displays Stack Overflow users with their profiles and reputation history. The app allows users to browse Stack Overflow users, view detailed user profiles, track reputation changes, and bookmark favorite users for quick access.

### Key Features
- Browse Stack Overflow users with pagination
- View detailed user profiles
- Track reputation history with pagination
- Bookmark/unbookmark users
- Offline storage using Hive
- Responsive UI with custom widgets
- Pull-to-refresh functionality
- Localization support

---

## Architecture

The project follows **Clean Architecture** principles combined with **BLoC (Business Logic Component)** pattern for state management.

### Architecture Layers

```
┌─────────────────────────────────────┐
│      Presentation Layer             │
│  (Pages, Widgets, BLoC/Cubit)       │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│       Domain Layer                  │
│    (Business Logic, Models)         │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│        Data Layer                   │
│  (Repositories, Data Sources)       │
└─────────────────────────────────────┘
              ↓
┌─────────────────────────────────────┐
│      External Services              │
│  (Network, Cache, Local Storage)    │
└─────────────────────────────────────┘
```

### Design Patterns Used

1. **BLoC Pattern**: State management using Cubits
2. **Repository Pattern**: Abstract data access
3. **Dependency Injection**: Using GetIt for service locator
4. **Flyweight Pattern**: Singleton instances for services
5. **Factory Pattern**: Model creation from JSON

---

## Project Structure

```
lib/
├── core/
│   ├── abstract/
│   │   └── base_cubit.dart              # Base cubit with error handling
│   ├── exceptions/
│   │   └── connection_exception.dart    # Custom exceptions
│   ├── localization/
│   │   └── app_localizations.dart       # Localization service
│   ├── service/
│   │   ├── cache_service.dart           # SharedPreferences wrapper
│   │   ├── hive_service.dart            # Hive database service
│   │   └── network_service.dart         # Dio HTTP client wrapper
│   └── utils/
│       ├── app_assets.dart              # Asset paths
│       ├── app_colors.dart              # Color constants
│       ├── profile_header_painter.dart  # Custom painter
│       ├── style.dart                   # App styles
│       └── ui_const.dart                # UI constants
│
├── di/
│   └── injector.dart                    # Dependency injection setup
│
├── features/
│   ├── bookmark/
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── bookmark_local_datasource.dart
│   │   │   └── repositories/
│   │   │       └── bookmark_repository.dart
│   │   └── presentation/
│   │       ├── blocs/
│   │       │   └── bookmark_cubit/
│   │       │       ├── bookmark_cubit.dart
│   │       │       └── bookmark_state.dart
│   │       └── pages/
│   │           └── bookmark_page.dart
│   │
│   ├── user_details/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── reputation_model.dart
│   │   │   └── repositories/
│   │   │       └── reputation_repository.dart
│   │   └── presentation/
│   │       ├── blocs/
│   │       │   └── reputation_cubit/
│   │       │       ├── reputation_cubit.dart
│   │       │       └── reputation_state.dart
│   │       ├── pages/
│   │       │   └── user_detail_page.dart
│   │       └── widgets/
│   │           └── profile_header.dart
│   │
│   └── user_list/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── user_remote_datasource.dart
│       │   ├── models/
│       │   │   └── user_model.dart
│       │   └── repositories/
│       │       └── user_repository.dart
│       └── presentation/
│           ├── blocs/
│           │   └── user_list_cubit/
│           │       ├── user_list_cubit.dart
│           │       └── user_list_state.dart
│           ├── pages/
│           │   └── user_list_page.dart
│           └── widgets/
│               └── user_item_widget.dart
│
├── shared_widgets/
│   └── stateless/
│       ├── appbar.dart                  # Custom app bar
│       ├── custom_app_page.dart         # Page wrapper
│       ├── custom_loading.dart          # Loading indicators
│       ├── custom_network_image.dart    # Cached network images
│       └── custom_text.dart             # Responsive text widget
│
└── main.dart                            # Application entry point
```

---

## Features

### 1. User List Feature

**Purpose:** Display a paginated list of Stack Overflow users

**Components:**
- `UserListPage`: Main page displaying users
- `UserListCubit`: Manages user list state and pagination
- `UserRepository`: Handles data fetching and bookmark integration
- `UserRemoteDataSource`: API calls to Stack Overflow
- `UserItemWidget`: Individual user card widget

**Key Functionality:**
- Infinite scroll pagination (15 users per page)
- Pull-to-refresh
- Bookmark toggle
- Navigation to user details
- Shimmer loading effect
- Error handling

**State Management:**
```dart
enum UserListStatus { initial, loading, success, error }

class UserListState {
  final UserListStatus status;
  final List<UserModel> users;
  final bool hasReachedMax;
  final String? errorMessage;
}
```

**Pagination Logic:**
- Page counter increments before API call
- Prevents concurrent requests
- Handles errors by decrementing page counter
- Detects end of list when empty response received

---

### 2. User Details Feature

**Purpose:** Display detailed user profile and reputation history

**Components:**
- `UserDetailPage`: User profile and reputation history
- `ReputationCubit`: Manages reputation data and pagination
- `ReputationRepository`: Fetches reputation history
- `ProfileHeader`: Custom painted profile header

**Key Functionality:**
- User profile display with custom header
- Paginated reputation history
- Scroll-based pagination (loads at 90% scroll)
- Pull-to-refresh
- Date formatting
- Color-coded reputation changes (green/red)

**Reputation Model:**
```dart
class ReputationModel {
  final String reputationHistoryType;
  final int reputationChange;
  final int creationDate;
}
```

---

### 3. Bookmark Feature

**Purpose:** Save and manage bookmarked users locally

**Components:**
- `BookmarkPage`: Display bookmarked users
- `BookmarkCubit`: Manages bookmark state
- `BookmarkRepository`: Local data operations
- `BookmarkLocalDataSource`: Hive database operations

**Key Functionality:**
- Add/remove bookmarks
- Persist bookmarks locally using Hive
- Display bookmarked users
- Sync bookmark status across features

**Storage:**
- Uses Hive for local storage
- Box name: 'bookmarks'
- Stores user IDs as keys with UserModel as values

---

## Core Components

### 1. Dependency Injection (Injector)

**File:** `lib/di/injector.dart`

**Purpose:** Centralized dependency management using GetIt and Flyweight pattern

**Services Registered:**
- `SharedPreferences`: Persistent key-value storage
- `HiveService`: Local database service
- `NetworkService`: HTTP client
- `CacheService`: SharedPreferences wrapper

**Features Registered:**
- User List (Cubit, Repository, DataSource)
- Bookmark (Cubit, Repository, DataSource)
- Reputation (Cubit, Repository)

**Pattern:**
```dart
class Injector {
  static final Injector _singleton = Injector._internal();
  final _flyweightMap = <String, dynamic>{};
  
  // Flyweight pattern for singleton instances
  NetworkService get networkService =>
      _flyweightMap['networkService'] ??= NetworkServiceImpl();
}
```

---

### 2. Network Service

**File:** `lib/core/service/network_service.dart`

**Technology:** Dio HTTP client

**Configuration:**
- Connect timeout: 30 seconds
- Receive timeout: 30 seconds
- Validates all status codes
- Logging enabled

**Error Handling:**
- Throws `ConnectionException` on failures
- Logs all requests and responses

---

### 3. Cache Service

**File:** `lib/core/service/cache_service.dart`

**Purpose:** Wrapper around SharedPreferences for type-safe caching

**Methods:**
- `saveString(key, value)`
- `getString(key)`
- `saveBool(key, value)`
- `getBool(key)`
- `remove(key)`
- `clear()`

---

### 4. Hive Service

**File:** `lib/core/service/hive_service.dart`

**Purpose:** Local NoSQL database for bookmarks

**Features:**
- Asynchronous initialization
- Type-safe box operations
- CRUD operations for bookmarks

**Methods:**
- `init()`: Initialize Hive
- `getBox<T>(boxName)`: Get or create box
- `saveData(boxName, key, value)`
- `getData(boxName, key)`
- `deleteData(boxName, key)`
- `getAllData(boxName)`

---

### 5. Localization Service

**File:** `lib/core/localization/app_localizations.dart`

**Supported Languages:** English (en)

**Translations:**
- app_title: "Stack Overflow Users"
- bookmarks: "Bookmarks"
- error: "Error"
- no_users_found: "No users found"
- no_bookmarks_yet: "No bookmarks yet"
- reputation: "Reputation"
- reputation_history: "Reputation History"
- no_reputation_history: "No reputation history"

**Usage:**
```dart
AppLocalizations.appTitle
AppLocalizations.bookmarks
```

---

### 6. Base Cubit

**File:** `lib/core/abstract/base_cubit.dart`

**Purpose:** Base class for all Cubits with common functionality

**Features:**
- Error handling
- Loading states
- State emission helpers

---

## Shared Widgets

### 1. CustomText

**File:** `lib/shared_widgets/stateless/custom_text.dart`

**Purpose:** Responsive text widget using MediaQuery and TextScaler

**Features:**
- Automatic text scaling
- Style customization
- Font weight support
- Color support

**Usage:**
```dart
CustomText(
  'Hello World',
  style: TextStyle(fontSize: 18),
  fontWeight: FontWeight.bold,
)
```

---

### 2. CustomNetworkImage

**File:** `lib/shared_widgets/stateless/custom_network_image.dart`

**Purpose:** Cached network image with loading and error states

**Technology:** cached_network_image package

**Features:**
- Image caching
- Shimmer loading effect
- Error placeholder
- Custom dimensions

---

### 3. CustomLoading

**File:** `lib/shared_widgets/stateless/custom_loading.dart`

**Purpose:** Reusable loading indicators

**Styles:**
- `shimmerList`: Shimmer effect for lists
- `shimmerGrid`: Shimmer effect for grids
- `pagination`: Small loading indicator for pagination
- `circular`: Standard circular progress indicator

---

### 4. CustomAppBar

**File:** `lib/shared_widgets/stateless/appbar.dart`

**Purpose:** Consistent app bar across the application

**Features:**
- Custom title
- Back button
- Consistent styling

---

### 5. CustomAppPage

**File:** `lib/shared_widgets/stateless/custom_app_page.dart`

**Purpose:** Page wrapper with consistent padding and background

---

## Dependencies

### Production Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter | sdk | Flutter framework |
| cupertino_icons | ^1.0.8 | iOS style icons |
| dio | ^5.4.0 | HTTP client |
| flutter_bloc | ^8.1.3 | BLoC state management |
| bloc | ^8.1.2 | BLoC core |
| dartz | ^0.10.1 | Functional programming (Either type) |
| equatable | ^2.0.5 | Value equality |
| get_it | ^7.6.6 | Dependency injection |
| shared_preferences | ^2.2.2 | Key-value storage |
| intl | ^0.19.0 | Internationalization |
| url_launcher | ^6.2.4 | Launch URLs |
| cached_network_image | ^3.3.1 | Image caching |
| shimmer | ^3.0.0 | Shimmer loading effect |
| flutter_svg | ^2.1.0 | SVG support |
| size_helper | ^2.1.0 | Responsive sizing |
| hive | ^2.2.3 | NoSQL database |
| hive_flutter | ^1.1.0 | Hive Flutter integration |
| flutter_screenutil | ^5.9.3 | Screen adaptation |

### Development Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| flutter_test | sdk | Testing framework |
| flutter_lints | ^5.0.0 | Linting rules |

---

## Setup & Installation

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- iOS Simulator / Android Emulator
- Xcode (for iOS development)
- Android Studio (for Android development)

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
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

4. **Build for production**
   ```bash
   # iOS
   flutter build ios
   
   # Android
   flutter build apk
   ```

### Configuration

**API Endpoint:**
The app uses Stack Overflow API:
- Base URL: `https://api.stackexchange.com/2.3`
- Endpoints:
  - Users: `/users?site=stackoverflow`
  - Reputation: `/users/{id}/reputation-history?site=stackoverflow`

**Localization:**
- Default language: English (en)
- Locale files: `assets/locales/en.json`

---

## Code Examples

### 1. Fetching Users with Pagination

```dart
class UserListCubit extends BaseCubit<UserListState> {
  final UserRepository _userRepository;
  int _page = 1;
  static const int _pageSize = 15;

  Future<void> getUsers({bool isRefresh = false}) async {
    if (state.hasReachedMax && !isRefresh) return;
    if (state.status == UserListStatus.loading && !isRefresh) return;

    try {
      if (state.status == UserListStatus.initial || isRefresh) {
        _page = 1;
        emit(state.copyWith(status: UserListStatus.loading));
        final users = await _userRepository.getUsers(
          page: _page, 
          pageSize: _pageSize
        );
        emit(state.copyWith(
          status: UserListStatus.success,
          users: users,
          hasReachedMax: users.isEmpty,
        ));
      } else {
        _page++;
        final users = await _userRepository.getUsers(
          page: _page, 
          pageSize: _pageSize
        );
        if (users.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        } else {
          emit(state.copyWith(
            status: UserListStatus.success,
            users: List.of(state.users)..addAll(users),
            hasReachedMax: false,
          ));
        }
      }
    } catch (e) {
      if (state.status != UserListStatus.initial && !isRefresh) {
        _page--;
      }
      emit(state.copyWith(
        status: UserListStatus.error, 
        errorMessage: e.toString()
      ));
    }
  }
}
```

### 2. Bookmark Management with Hive

```dart
class BookmarkLocalDataSourceImpl implements BookmarkLocalDataSource {
  final HiveService _hiveService;
  static const String _boxName = 'bookmarks';

  @override
  Future<void> bookmarkUser(UserModel user) async {
    await _hiveService.saveData(
      _boxName, 
      user.userId.toString(), 
      user.toJson()
    );
  }

  @override
  Future<void> unbookmarkUser(int userId) async {
    await _hiveService.deleteData(_boxName, userId.toString());
  }

  @override
  Future<List<UserModel>> getBookmarkedUsers() async {
    final data = await _hiveService.getAllData(_boxName);
    return data.values
        .map((json) => UserModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  @override
  Future<bool> isUserBookmarked(int userId) async {
    final data = await _hiveService.getData(_boxName, userId.toString());
    return data != null;
  }
}
```

### 3. Custom Responsive Text Widget

```dart
class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final FontWeight? fontWeight;
  final Color? color;

  const CustomText(
    this.text, {
    super.key,
    this.style,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textScaler = MediaQuery.of(context).textScaler;
    
    return Text(
      text,
      style: (style ?? const TextStyle()).copyWith(
        fontWeight: fontWeight,
        color: color,
        fontSize: textScaler.scale(style?.fontSize ?? 14),
      ),
    );
  }
}
```

### 4. Network Service Implementation

```dart
class NetworkServiceImpl implements NetworkService {
  final Dio _dio = Dio(BaseOptions(
    validateStatus: (_) => true,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters
  }) async {
    try {
      final response = await _dio.get(
        url, 
        queryParameters: queryParameters
      );
      log('GET $url\nResponse: ${response.statusCode}\nData: ${response.data}');
      return response;
    } catch (e) {
      throw ConnectionException(e.toString());
    }
  }
}
```

### 5. Dependency Injection Setup

```dart
class Injector {
  static Future<void> init() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(sharedPreferences);

    final hiveService = HiveService();
    await hiveService.init();
    GetIt.I.registerSingleton<HiveService>(hiveService);
  }

  // Flyweight pattern for services
  NetworkService get networkService =>
      _flyweightMap['networkService'] ??= NetworkServiceImpl();
      
  UserListCubit get userListCubit => UserListCubit(userRepository);
}
```

---

## UI/UX Features

### 1. Shimmer Loading
- Used during initial data load
- Provides visual feedback
- Improves perceived performance

### 2. Pull-to-Refresh
- Available on all list pages
- Uses `RefreshIndicator.adaptive`
- Platform-specific animations

### 3. Infinite Scroll
- Automatic pagination
- Loads at 90% scroll position
- Prevents duplicate requests

### 4. Custom Profile Header
- Custom painter for unique design
- Displays user avatar with border
- Purple accent color

### 5. Responsive Design
- Uses `flutter_screenutil` for screen adaptation
- Custom text scaling with `MediaQuery`
- Adapts to different screen sizes

---

## Error Handling

### Network Errors
- Connection timeout handling
- Custom `ConnectionException`
- User-friendly error messages

### State Management Errors
- Try-catch blocks in all Cubits
- Error states in UI
- Retry mechanisms

### Data Validation
- Null safety throughout
- Default values in models
- Type-safe operations

---

## Performance Optimizations

1. **Image Caching**: Using `cached_network_image` for efficient image loading
2. **Lazy Loading**: Pagination prevents loading all data at once
3. **Flyweight Pattern**: Singleton services reduce memory usage
4. **Hive Database**: Fast local storage for bookmarks
5. **BLoC Pattern**: Efficient state management and rebuilds
6. **Const Constructors**: Reduces widget rebuilds

---

## Testing Considerations

### Unit Tests
- Test Cubits with mock repositories
- Test repositories with mock data sources
- Test models serialization/deserialization

### Widget Tests
- Test individual widgets
- Test user interactions
- Test state changes

### Integration Tests
- Test complete user flows
- Test navigation
- Test data persistence

---

## Future Enhancements

1. **Search Functionality**: Search users by name or location
2. **Filters**: Filter by reputation, location, or join date
3. **Sorting**: Sort users by different criteria
4. **Dark Mode**: Theme switching support
5. **Multi-language**: Support for more languages
6. **User Authentication**: Login with Stack Overflow account
7. **Offline Mode**: Full offline support with sync
8. **Analytics**: Track user behavior
9. **Push Notifications**: Notify on reputation changes
10. **Share Feature**: Share user profiles

---

## Troubleshooting

### Common Issues

**Issue: Build fails with dependency errors**
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

**Issue: Hive initialization fails**
- Ensure `WidgetsFlutterBinding.ensureInitialized()` is called
- Check write permissions

**Issue: Network requests fail**
- Check internet connection
- Verify API endpoint
- Check timeout settings

**Issue: Images not loading**
- Verify image URLs
- Check cache storage permissions
- Clear image cache

---

## Contributing Guidelines

1. Follow Flutter style guide
2. Use BLoC pattern for state management
3. Write clean, documented code
4. Add tests for new features
5. Update documentation
6. Follow Git commit conventions

---

## License

This project is created as an assignment and is for educational purposes.

---

## Contact & Support

For questions or issues, please contact the development team.

---

**Document Version:** 1.0  
**Last Updated:** November 2025  
**Author:** Development Team
