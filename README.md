
```markdown:README.md
# Tham8iaTask - iOS Audio Content App

A modern iOS application built with SwiftUI that displays and manages audio content including podcasts, episodes, audiobooks, and audio articles. The app features a clean, modular architecture following Clean Architecture principles.

## �� Features

- **Home Screen**: Displays various audio content sections with different layouts
- **Search Functionality**: Search through audio content with real-time filtering
- **Multiple Content Types**: Support for podcasts, episodes, audiobooks, and audio articles
- **Dynamic Section Rendering**: Flexible UI system that adapts to different content layouts
- **Pull-to-Refresh**: Refresh content on the home screen
- **Error Handling**: Comprehensive error states and empty states
- **Async Image Loading**: Efficient image loading with placeholders

## ��️ Architecture

The project follows **Clean Architecture** principles with a clear separation of concerns:

### Project Structure

```
Tham8iaTask/
├── Core/                          # Core infrastructure
│   ├── CompositeNetwork/          # Network layer implementation
│   └── ErrorLogger/               # Error logging utilities
├── Features/                      # Feature modules
│   ├── Home/                      # Home screen feature
│   │   ├── Data/                  # Data layer (DTOs)
│   │   ├── Domain/                # Business logic (Use Cases)
│   │   ├── Presentation/          # UI layer (Views, ViewModels)
│   │   └── UIModel/               # UI data models
│   └── Search/                    # Search feature
│       ├── Data/
│       ├── Domain/
│       ├── Presentation/
│       └── UIModel/
├── Resources/                     # App resources
│   └── Assets.xcassets/           # Images, colors, icons
├── Shared/                        # Shared components
│   ├── Extensions/                # Swift extensions
│   ├── States/                    # View state management
│   └── UI/                        # Reusable UI components
└── Tham8iaTaskApp.swift          # App entry point
```

### Key Architectural Components

#### 1. **Network Layer** (`Core/CompositeNetwork/`)
- **EndPoint Protocol**: Defines API endpoints with URL, method, and parameters
- **RequestAction**: Handles HTTP requests with async/await support
- **Parameter Encoding**: Supports JSON and URL encoding
- **Response Validation**: Validates HTTP responses and handles errors

#### 2. **Feature Modules**
Each feature follows the same structure:
- **Data Layer**: DTOs for API communication
- **Domain Layer**: Use cases containing business logic
- **Presentation Layer**: SwiftUI views and view models
- **UI Models**: Domain-specific UI data structures

#### 3. **Dynamic Section Rendering System**
- **SectionRendererRegistry**: Manages different section renderers
- **HeaderRendererRegistry**: Handles section header rendering
- **Layout Types**: Square, Big Square, Two Lines Grid, Queue
- **Content Types**: Podcast, Episode, AudioBook, AudioArticle

## �� UI Components

### Reusable Components
- **AsyncImageView**: Asynchronous image loading with placeholders
- **SearchBar**: Customizable search input with clear functionality
- **ErrorView**: Standardized error display
- **EmptyStateView**: Empty state handling
- **PlayingView**: Audio player interface

### Section Renderers
- **SquareSection**: Compact content display
- **BigSquareSection**: Large content cards
- **TwoLineGridSection**: Grid layout with two lines
- **QueueSection**: Queue-style content display

## 📱 Screens

### Home Screen
- Displays multiple content sections
- Pull-to-refresh functionality
- Loading, error, and empty states
- Navigation to search screen

### Search Screen
- Real-time search functionality
- Filtered content display
- Custom search bar with clear option

## 🔧 Technical Details

### Dependencies
- **SwiftUI**: Modern declarative UI framework
- **Foundation**: Core iOS framework
- **URLSession**: Network requests

### State Management
- **ViewState**: Generic state enum for loading, success, error, and empty states
- **@StateObject**: SwiftUI state management for view models
- **@Binding**: Data binding between views

### Network Configuration
- **Base URL**: `api-v2-b2sit6oh3a-uc.a.run.app`
- **Default Method**: GET
- **Response Format**: JSON

### Content Types Supported
1. **Podcasts**: Series with multiple episodes
2. **Episodes**: Individual podcast episodes
3. **Audiobooks**: Book-length audio content
4. **Audio Articles**: Article-style audio content

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 17.0+
- Swift 5.9+

### Installation
1. Clone the repository
2. Open `Tham8iaTask.xcodeproj` in Xcode
3. Build and run the project

### Project Configuration
- Target: iOS 17.0+
- Deployment Target: iOS 17.0
- Swift Language Version: Swift 5.9

## 🧪 Testing

The project includes test targets:
- **Tham8iaTaskTests**: Unit tests
- **Tham8iaTaskUITests**: UI tests

## 📝 Code Style

- **SwiftUI**: Modern declarative syntax
- **MVVM**: Model-View-ViewModel pattern
- **Protocol-Oriented**: Heavy use of protocols for flexibility
- **Clean Architecture**: Clear separation of concerns
- **Async/Await**: Modern concurrency patterns

## 🔄 Data Flow

1. **API Request**: Use cases make network requests
2. **Data Transformation**: DTOs are converted to UI models
3. **State Management**: ViewModels manage UI state
4. **Rendering**: Dynamic renderers display content based on type and layout

## 🎯 Key Features Implementation

### Dynamic Section Rendering
The app uses a registry pattern to dynamically render different section types:

```swift
// Register renderers for different layouts and content types
registry.register(layout: .square, content: .podcast, renderer: SquarePodcastSectionRender())
registry.register(layout: .bigSquare, content: .audioBook, renderer: BigSquareAudioBookSectionRender())
```

### Error Handling
Comprehensive error handling with user-friendly messages and retry functionality.

### Image Loading
Efficient async image loading with placeholder support and error handling.

## 🤝 Contributing

1. Follow the existing architecture patterns
2. Add tests for new features
3. Maintain clean separation of concerns
4. Use SwiftUI best practices

## 📄 License

This project is created by Khaled Kamal.

---

**Note**: This is a task/project implementation showcasing modern iOS development practices with SwiftUI and Clean Architecture.
```
