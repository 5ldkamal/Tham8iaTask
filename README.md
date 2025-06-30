# Tham8iaTask - iOS Audio Content App

A modern iOS application built with SwiftUI that displays and manages audio content including podcasts, episodes, audiobooks, and audio articles. The app features a clean, modular architecture following Clean Architecture principles with advanced networking, state management, and dynamic UI rendering.

## 🎵 Features

- **Home Screen**: Displays various audio content sections with different layouts
- **Search Functionality**: Real-time search with debounced input (200ms delay)
- **Multiple Content Types**: Support for podcasts, episodes, audiobooks, and audio articles
- **Dynamic Section Rendering**: Flexible UI system that adapts to different content layouts
- **Pull-to-Refresh**: Refresh content on the home screen
- **Pagination Support**: Load more content with infinite scrolling
- **Error Handling**: Comprehensive error states and empty states
- **Async Image Loading**: Efficient image loading with placeholders
- **Duration Formatting**: Human-readable duration display (e.g., "2 hr 15 min")
- **Date Formatting**: Relative date display (e.g., "2 hr ago", "yesterday")

## 🏗️ Architecture

The project follows **Clean Architecture** principles with a clear separation of concerns and modern iOS development patterns. The app is structured using **Monolithic Modules based on Feature-based Module Architecture**, where each feature is self-contained with its own data, domain, and presentation layers.

### Module Architecture

The application uses a **Monolithic Module** approach where:
- **Single App Target**: All features are contained within one app target
- **Feature-based Organization**: Each feature is organized as a complete module with its own layers
- **Shared Core**: Common functionality is shared across features through the Core and Shared modules
- **Loose Coupling**: Features are loosely coupled through well-defined interfaces and protocols
- **High Cohesion**: Each feature module contains all related functionality

### Feature Module Structure

Each feature module follows a consistent structure:
```
Feature/
├── Data/           # Data layer (DTOs, repositories)
├── Domain/         # Business logic (use cases, entities)
├── Presentation/   # UI layer (views, view models)
└── UIModel/        # UI-specific data models
```

### Project Structure

```
Tham8iaTask/
├── Core/                          # Core infrastructure
│   ├── CompositeNetwork/          # Network layer implementation
│   │   ├── DefaultDevelopmentEndPoint.swift
│   │   └── NetworkLayer/          # Network protocols and implementations
│   │       ├── EndPoint.swift     # Endpoint protocol and URLRequest conversion
│   │       ├── RequestAction.swift # Network request protocols
│   │       ├── HttpMethod.swift   # HTTP method definitions
│   │       ├── NetworkError.swift # Network error handling
│   │       ├── ParameterEncoding/ # JSON and URL encoding
│   │       └── URLComponents.swift
│   └── ErrorLogger/               # Error logging utilities
├── Features/                      # Feature modules (Monolithic)
│   ├── Home/                      # Home screen feature module
│   │   ├── Data/                  # Data layer (DTOs)
│   │   │   └── HomeDTO.swift      # Home API response models
│   │   ├── Domain/                # Business logic (Use Cases)
│   │   │   └── HomeUseCase.swift  # Home data fetching logic
│   │   ├── Presentation/          # UI layer (Views, ViewModels)
│   │   │   ├── HomeScreen.swift   # Main home view
│   │   │   ├── HomViewModel.swift # Home view model with pagination
│   │   │   ├── HomeHeaderView.swift
│   │   │   ├── RenderLogic/       # Dynamic rendering system
│   │   │   │   ├── SectionRendererRegistry.swift
│   │   │   │   ├── HeaderRendererRegistry.swift
│   │   │   │   ├── AnySectionItemsRenderer.swift
│   │   │   │   └── AnyHeaderRenderer.swift
│   │   │   └── SectionsUI/        # Section-specific UI components
│   │   │       ├── SquareSection/
│   │   │       ├── BigSquareSection/
│   │   │       ├── TwoLineGridSection/
│   │   │       └── QueueSection/
│   │   └── UIModel/               # UI data models
│   │       └── SectionContent.swift
│   └── Search/                    # Search feature module
│       ├── Data/
│       │   └── SearchDTO.swift    # Search API response models
│       ├── Domain/
│       │   └── SearchUseCase.swift # Search business logic
│       ├── Presentation/
│       │   ├── SearchScreen.swift # Search view
│       │   └── SearchViewModel.swift # Search view model with debouncing
│       └── UIModel/
│           └── SectionContent+SearchSectionDTO.swift
├── Resources/                     # App resources
│   └── Assets.xcassets/           # Images, colors, icons
│       ├── Colors/
│       │   ├── primaryBgColor.colorset
│       │   ├── primaryFontColor.colorset
│       │   └── queueCardBgColor.colorset
│       └── AppIcon.appiconset/
├── Shared/                        # Shared components
│   ├── Extensions/                # Swift extensions
│   │   ├── Int+DurationFormat.swift # Duration formatting utilities
│   │   ├── String+DateFormat.swift  # Date formatting utilities
│   │   └── URL+OptionalString.swift
│   ├── States/                    # View state management
│   │   ├── ViewState.swift        # Generic state enum
│   │   └── EmptyStateModel.swift  # Empty state models
│   └── UI/                        # Reusable UI components
│       ├── AsyncImageView.swift   # Async image loading
│       ├── SearchBar.swift        # Custom search input
│       ├── ErrorView.swift        # Error display
│       └── EmptyStateView.swift   # Empty state display
└── Tham8iaTaskApp.swift          # App entry point
```

### Key Architectural Components

#### 1. **Monolithic Feature Modules**
- **Self-Contained Features**: Each feature module contains all necessary layers
- **Feature Independence**: Features can be developed and tested independently
- **Clear Boundaries**: Well-defined interfaces between features
- **Shared Dependencies**: Common functionality shared through Core and Shared modules
- **Scalable Structure**: Easy to add new features following the same pattern

#### 2. **Network Layer** (`Core/CompositeNetwork/`)
- **EndPoint Protocol**: Defines API endpoints with URL, method, and parameters
- **RequestAction**: Handles HTTP requests with async/await, Combine, and completion handlers
- **Parameter Encoding**: Supports JSON and URL encoding
- **Response Validation**: Validates HTTP responses and handles errors
- **URL Builder**: Flexible URL construction with query parameters
- **Error Handling**: Comprehensive network error management

#### 3. **Feature Modules**
Each feature follows the same structure:
- **Data Layer**: DTOs for API communication with Codable conformance
- **Domain Layer**: Use cases containing business logic and dependency injection
- **Presentation Layer**: SwiftUI views and view models with MVVM pattern
- **UI Models**: Domain-specific UI data structures with protocol-oriented design

#### 4. **Dynamic Section Rendering System**
- **SectionRendererRegistry**: Manages different section renderers with type-safe registration
- **HeaderRendererRegistry**: Handles section header rendering
- **Layout Types**: Square, Big Square, Two Lines Grid, Queue
- **Content Types**: Podcast, Episode, AudioBook, AudioArticle
- **Protocol-Based**: Uses `AnySectionItemsRenderer` and `AnyHeaderRenderer` protocols

#### 5. **State Management**
- **ViewState**: Generic state enum for loading, success, error, and empty states
- **PaginationStatus**: Manages pagination states (idle, loading, error, endReached)
- **Combine Integration**: Reactive programming for search debouncing
- **Task Management**: Proper async task cancellation and lifecycle management

## 🎨 UI Components

### Reusable Components
- **AsyncImageView**: Asynchronous image loading with placeholders and error handling
- **SearchBar**: Customizable search input with clear functionality and keyboard management
- **ErrorView**: Standardized error display with retry functionality
- **EmptyStateView**: Empty state handling with customizable models
- **PlayingView**: Audio player interface with duration display

### Section Renderers
- **SquareSection**: Compact content display with horizontal scrolling
- **BigSquareSection**: Large content cards for featured content
- **TwoLineGridSection**: Grid layout with two lines of content
- **QueueSection**: Queue-style content display

### Custom Extensions
- **Duration Formatting**: Human-readable duration (e.g., "2 hr 15 min 30 sec")
- **Date Formatting**: Relative dates (e.g., "2 hr ago", "yesterday")
- **URL Handling**: Safe URL conversion from strings

## 📱 Screens

### Home Screen
- Displays multiple content sections with dynamic rendering
- Pull-to-refresh functionality with smooth UX
- Loading, error, and empty states with proper state management
- Navigation to search screen via sheet presentation
- Pagination support with infinite scrolling
- Task cancellation on view lifecycle changes

### Search Screen
- Real-time search functionality with 200ms debouncing
- Filtered content display with dynamic rendering
- Custom search bar with clear option and keyboard management
- Background color customization
- Proper state management for search results

## 🔧 Technical Details

### Dependencies
- **SwiftUI**: Modern declarative UI framework
- **Foundation**: Core iOS framework
- **Combine**: Reactive programming for search debouncing
- **URLSession**: Network requests with async/await support

### State Management
- **ViewState**: Generic state enum for loading, success, error, and empty states
- **@StateObject**: SwiftUI state management for view models
- **@Binding**: Data binding between views
- **@Published**: Combine publishers for reactive updates
- **Task Management**: Proper async task lifecycle management

### Network Configuration
- **Home API**: `api-v2-b2sit6oh3a-uc.a.run.app/home_sections`
- **Search API**: `mock.apidog.com/m1/735111-711675-default/search`
- **Default Method**: GET
- **Response Format**: JSON with Codable conformance
- **Error Handling**: Comprehensive error validation and logging

### Content Types Supported
1. **Podcasts**: Series with multiple episodes, episode counts, and popularity scores
2. **Episodes**: Individual podcast episodes with season numbers and types
3. **Audiobooks**: Book-length audio content with author information
4. **Audio Articles**: Article-style audio content with popularity badges

### Pagination System
- **PaginationInfo**: Tracks current page, total pages, and load more capability
- **Load More Logic**: Smart pagination with section-based triggers
- **State Management**: Separate pagination status from main content state
- **Task Cancellation**: Proper cleanup of pagination tasks

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
- Minimum iOS Version: 17.0

## 🧪 Testing

The project includes test targets:
- **Tham8iaTaskTests**: Unit tests for business logic
- **Tham8iaTaskUITests**: UI tests for user interactions

## 📝 Code Style

- **SwiftUI**: Modern declarative syntax with proper view composition
- **MVVM**: Model-View-ViewModel pattern with clear separation
- **Protocol-Oriented**: Heavy use of protocols for flexibility and testability
- **Clean Architecture**: Clear separation of concerns across layers
- **Async/Await**: Modern concurrency patterns with proper error handling
- **Combine**: Reactive programming for data binding and search debouncing
- **Dependency Injection**: Constructor-based dependency injection for testability

## 🔄 Data Flow

1. **API Request**: Use cases make network requests with proper error handling
2. **Data Transformation**: DTOs are converted to UI models with mapping functions
3. **State Management**: ViewModels manage UI state with proper lifecycle management
4. **Rendering**: Dynamic renderers display content based on type and layout
5. **User Interaction**: Proper task cancellation and state updates on user actions

## 🎯 Key Features Implementation

### Dynamic Section Rendering
The app uses a registry pattern to dynamically render different section types:

```swift
// Register renderers for different layouts and content types
registry.register(layout: .square, content: .podcast, renderer: SquarePodcastSectionRender())
registry.register(layout: .bigSquare, content: .audioBook, renderer: BigSquareAudioBookSectionRender())
registry.register(layout: .twoLinesGrid, content: .episode, renderer: TwoLineGridEpisodeSectionRender())
```

### Search with Debouncing
Real-time search with 200ms debounce to optimize API calls:

```swift
$searchText
    .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
    .removeDuplicates()
    .sink { [weak self] text in
        self?.searchQuery(word: text)
    }
```

### Pagination System
Smart pagination with proper state management:

```swift
func shouldLoadMore(for section: SectionContent) -> Bool {
    guard sections.last?.id == section.id,
          paginationStatus == .idle,
          paginationInfo.canLoadMore
    else {
        return false
    }
    return true
}
```

### Error Handling
Comprehensive error handling with user-friendly messages and retry functionality.

### Image Loading
Efficient async image loading with placeholder support and error handling.

### Duration and Date Formatting
Human-readable formatting for better user experience:

```swift
// Duration formatting
content.duration.formatDuration() // "2 hr 15 min 30 sec"

// Date formatting  
content.releaseDate.formatDate() // "2 hr ago", "yesterday"
```

## 🤝 Contributing

1. Follow the existing architecture patterns and Clean Architecture principles
2. Add tests for new features and business logic
3. Maintain clean separation of concerns across layers
4. Use SwiftUI best practices and modern iOS development patterns
5. Implement proper error handling and state management
6. Follow the established naming conventions and code style

## 🚀 Planned Updates & Improvements

The project is designed to be easily extensible and maintainable. The following enhancements are planned to improve the development experience, code quality, and app performance:

### 🏗️ Architecture Enhancements

#### **Coordinator Pattern**
- **Navigation Management**: Implement Coordinator pattern for better navigation flow management
- **Deep Linking**: Support for deep linking and universal links
- **Screen Transitions**: Centralized screen transition logic
- **Dependency Injection**: Improved dependency management for coordinators

#### **Data Manager (Repository Pattern)**
- **Repository Layer**: Add repository pattern for data access abstraction
- **Local Storage**: Implement local caching and offline support
- **Data Sources**: Abstract data sources (remote, local, cache)
- **Data Synchronization**: Handle data conflicts and synchronization

### 🛠️ Development Tools

#### **Code Quality Tools**
- **SwiftLint**: Enforce Swift style and conventions
  - Custom rules for project-specific requirements
  - Integration with Xcode build process
  - Automated code style enforcement
- **SwiftFormat**: Automatic code formatting
  - Consistent code style across the project
  - Integration with pre-commit hooks
  - Custom formatting rules

#### **Monitoring & Analytics**
- **Error Log SDK**: Comprehensive error tracking
  - Structured error logging
  - Error categorization and prioritization
  - Integration with monitoring services
- **Crash Analytics**: Crash reporting and analysis
  - Automatic crash detection and reporting
  - Stack trace analysis
  - Performance monitoring

### 📱 App Features

#### **Caching Feature**
- **Image Caching**: Efficient image caching with memory and disk storage
- **Data Caching**: API response caching with TTL (Time To Live)
- **Offline Support**: Offline-first approach with data synchronization
- **Cache Management**: Intelligent cache eviction and cleanup

### 🚀 CI/CD & Deployment

#### **Fastlane**
- **Automated Builds**: Automated build process for different environments
- **Code Signing**: Automated code signing and provisioning
- **App Store Deployment**: Automated App Store submission
- **Beta Testing**: Automated TestFlight distribution
- **Release Management**: Automated version bumping and changelog generation

### 📄 Project Documentation

#### **Git Configuration**
- **Enhanced .gitignore**: Comprehensive gitignore for iOS development
  - Xcode build artifacts
  - CocoaPods/Swift Package Manager files
  - IDE-specific files
  - Temporary and cache files

#### **Changelog Management**
- **CHANGELOG.md**: Automated changelog generation
  - Conventional commits support
  - Version history tracking
  - Release notes automation
  - Feature and bug fix documentation

### 🔧 Implementation Roadmap

#### **Phase 1: Foundation**
1. Add SwiftLint and SwiftFormat configuration
2. Implement basic repository pattern
3. Set up enhanced .gitignore
4. Create CHANGELOG.md template

#### **Phase 2: Architecture**
1. Implement Coordinator pattern for navigation
2. Add comprehensive data manager with caching
3. Set up error logging SDK
4. Implement crash analytics

#### **Phase 3: Automation**
1. Configure Fastlane for CI/CD
2. Set up automated testing pipeline
3. Implement automated deployment
4. Add performance monitoring

#### **Phase 4: Optimization**
1. Optimize caching strategies
2. Implement offline-first features
3. Add advanced analytics
4. Performance optimization

### 📋 Development Guidelines

When implementing these features, follow these guidelines:

#### **Code Quality**
- Use SwiftLint rules consistently
- Follow SwiftFormat guidelines
- Write comprehensive unit tests
- Document public APIs

#### **Architecture**
- Maintain Clean Architecture principles
- Keep features loosely coupled
- Use dependency injection
- Follow SOLID principles

#### **Performance**
- Implement efficient caching strategies
- Monitor memory usage
- Optimize network requests
- Use background processing appropriately

#### **User Experience**
- Ensure offline functionality
- Provide meaningful error messages
- Implement proper loading states
- Maintain app responsiveness

## 📄 License

This project is created by Khaled Kamal.

---

**Note**: This is a task/project implementation showcasing modern iOS development practices with SwiftUI, Clean Architecture, and advanced networking patterns. The project is designed to be easily extensible and maintainable with planned enhancements for production readiness. 