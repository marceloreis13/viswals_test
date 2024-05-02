# Flutter
Viswals Mobile Challenge

## Approx eta until now
- 9 hours 

## Difficulty 
- Medium 

## 1. Introduction

This documentation provides an overview of the architecture employed in the Viswals Challenge, a Flutter application developed under your guidance. The project follows a structured approach, ensuring modularity, reusability, and testability. Utilizing the Flutter framework and Dart language, the application is designed to maintain a clear separation of concerns, allowing for scalability and easy maintenance.

## 2. Architecture Overview

### 2.1 API/Data Services Layer

The API/Data Services layer acts as the external data source for the application. It interacts with external APIs, demonstrated using PHP in this context, to fetch and send data.

### 2.2 Provider Layer

The Provider layer serves as the first internal layer, mediating between the API/Data Services layer and the Service layer. It defines a contract through the Provider Protocol, ensuring that necessary functions are implemented for data retrieval and manipulation.

#### Provider Class Example:
```dart
class DocumentDetailsProvider implements DocumentDetailsProtocol {
  // Implementation of CRUD operations using API services
}
```

### 2.3 Service Layer

The Service layer handles raw data obtained from the Provider layer. It encapsulates business logic, data processing, and error handling. The Service layer then delivers processed data to the Data Object Model layer and manages user interactions.

#### Service Class Example:
```dart
class DocumentDetailsService extends ServiceProtocol {
  // Implementation of CRUD operations, error handling, and business logic
}
```

### 2.4 Data Object Model Layer
The Data Object Model provides a structured representation of application data. It defines specific data objects, processes raw data, and prepares it for presentation in the user interface.

#### Data Object Model Example:
```dart
class DocumentDetailsDataObject {
  // Definition of structured data objects and data processing methods
}

extension ExtDocumentDetails on DocumentDetails {
  // Extension methods for data processing specific to the DocumentDetails model
}
```

### 2.5 View Layer
The View layer represents the user interface components of the application. It receives processed data from the Data Object Model and presents it to users. Here, you design the layout and user interactions, utilizing the processed data without needing additional processing.

#### Page Example:
```dart
class DocumentDetailsPage extends StatefulWidget {
  // Implementation of UI components and user interactions
}
```

### 2.6 Routes
The Routes layer manages navigation and dependency injection within the application. It provides a structured way to navigate between different views and components while maintaining a separation of concerns.

### 3. Project Life Cycle
```bash
main.dart - FIRST FILE CALLED BY FLUTTER FW
├── root_view.dart - HERE ALL DEPENDENCIES ARE LOADED
│   ├── Splashscreen_page.dart - PRESENTING SPLASH WHILE LOADS THE NEEDED INFORMATION
│   │   ├── setEnvronmentValues() - Loading environment variables
│   │   ├── internetConnectionChecker() - Check connection avalability
│   │   ├── setUpFirebaseCrashlytics() - Instantiate the Crashlytics
│   │   ├── setUpFirebaseRemoteConfig() - Starting the firebase remote config
│   │   ├── setUpDeviceInformation() - Device information
│   │   └── setUpUserSession() - Setup the user session
│   │       └── FirstPageToBeDisplayed() - AFTER ALL INFORMATION IS LOADED, THEN, SHOW THE FIRST PAGE RESPONDER

```

### 4. Structure

#### - app
The "app" directory contains all files relevant to the application. Here, you'll find abstract functions and variables that serve as support for any project, regardless of its nature.

#### - theme
Within the "theme" directory, all elements composing the project's theme are concentrated, including color and typography definitions.

#### - domain
In the "domain" directory, you'll find files containing classes and functions related to the project's specific domain. Here, all layers of business rules, such as models, providers, and services, are grouped, forming the core functionality of the application.

#### - ui
The "ui" directory represents the user interface layer. Here, business rules are not allowed. Within this directory, the "features" subdirectory houses all application flows, while the "widgets" subdirectory contains all components used for screen construction.

```bash
lib
├── app
│   ├── constants
│   │   └── constant_files_here.dart
│   ├── extensions
│   │   └── extension_files_here.dart
│   ├── helpers
│   │   └── helper_files_here.dart
│   ├── main.dart
│   └── routes
│       └── route_files_here.dart
├── theme
│   ├── vw_colors.dart
│   ├── vw_text_styles.dart
│
├── domain
│   ├── models
│   │   ├── error
│   │   │   └── error_files_here.dart
│   │   ├── user
│   │   │   └── user_files_here.dart
│   │   └── model_files_here.dart
│   ├── providers
│   │   └── user
│   │       └── user_files_here.dart
│   └── services
│       └── service_files_here.dart
└── ui
    ├── features
    │   └── user
    │       ├── user_form_files_here.dart
    │       └── widgets
    │           ├── form
    │           │   └── user_form_files_here.dart
    │           └── list
    │               └── user_list_files_here.dart
    └── widgets
        ├── app_bars
        ├── forms
        ├── buttons
        ├── progress_circle
        └── scaffolds
```

### 5. Conclusion
The Viswals Challenge's Flutter architecture demonstrates a clear separation of concerns, modularity, and a structured approach to data handling, business logic, and user interface components. This architecture enhances maintainability, reusability, and testability, making the Viswals Project a robust and scalable application for future enhancements.

For any further details or specific inquiries, please refer to the respective code files and comments within the Viswals.
