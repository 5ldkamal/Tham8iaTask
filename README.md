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

The project follows **Clean Architecture** principles with a clear separation of concerns and modern iOS development patterns:

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
├── Features/                      # Feature modules
│   ├── Home/                      # Home screen feature
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
│   └── Search/                    # Search feature
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

#### 1. **Network Layer** (`Core/CompositeNetwork/`)
- **EndPoint Protocol**: Defines API endpoints with URL, method, and parameters
- **RequestAction**: Handles HTTP requests with async/await, Combine, and completion handlers
- **Parameter Encoding**: Supports JSON and URL encoding
- **Response Validation**: Validates HTTP responses and handles errors
- **URL Builder**: Flexible URL construction with query parameters
- **Error Handling**: Comprehensive network error management

#### 2. **Feature Modules**
Each feature follows the same structure:
- **Data Layer**: DTOs for API communication with Codable conformance
- **Domain Layer**: Use cases containing business logic and dependency injection
- **Presentation Layer**: SwiftUI views and view models with MVVM pattern
- **UI Models**: Domain-specific UI data structures with protocol-oriented design

#### 3. **Dynamic Section Rendering System**
- **SectionRendererRegistry**: Manages different section renderers with type-safe registration
- **HeaderRendererRegistry**: Handles section header rendering
- **Layout Types**: Square, Big Square, Two Lines Grid, Queue
- **Content Types**: Podcast, Episode, AudioBook, AudioArticle
- **Protocol-Based**: Uses `AnySectionItemsRenderer` and `AnyHeaderRenderer` protocols

#### 4. **State Management**
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

## 📄 License

This project is created by Khaled Kamal.

---

**Note**: This is a task/project implementation showcasing modern iOS development practices with SwiftUI, Clean Architecture, and advanced networking patterns. 