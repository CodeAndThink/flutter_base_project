# Flutter Base Project (Movie App Demo)

A modern, responsive Flutter application showcasing a Clean Architecture implementation with a robust set of libraries and tools. This project serves as a comprehensive base for building scalable Flutter apps, currently demonstrating a Movie Database integration.

## 🚀 Tech Stack

- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Routing**: [go_router](https://pub.dev/packages/go_router)
- **Networking**: [dio](https://pub.dev/packages/dio) & [retrofit](https://pub.dev/packages/retrofit)
- **JSON Parsing**: [json_serializable](https://pub.dev/packages/json_serializable) & [json_annotation](https://pub.dev/packages/json_annotation)
- **Data Comparison**: [equatable](https://pub.dev/packages/equatable)
- **Image Caching**: [cached_network_image](https://pub.dev/packages/cached_network_image)
- **Local Storage**: [shared_preferences](https://pub.dev/packages/shared_preferences)

---

## 🏗 Project Structure

The project strictly follows **Clean Architecture** principles, dividing the code into discrete, decoupled layers:

```text
lib/
├── core/
│   ├── common/          # Shared elements like AppTheme and ThemeCubit (Light/Dark Mode)
│   ├── configs/         # App-wide configurations and constants
│   ├── database/        # Local storage solutions (e.g., SharedPreferences)
│   ├── failure/         # Error handling and failure models
│   ├── network/         # Dio client, API Constants, Retrofit ApiClients
│   └── utils/           # Helper functions and utilities
│
├── data/
│   ├── models/          # Data models (Responses, Entities, Enums) bridging JSON and UI
│   └── repositories/    # Concrete implementations for data fetching and caching
│
├── router/              # GoRouter configuration and route definitions
│
├── ui/                  # User Interface layer (pages and shared widgets)
│   ├── pages/           # Organized by Feature (e.g., home, detail, onboarding)
│   │   ├── detail/      # Movie detail screen, cubit, and navigator
│   │   ├── home/        # Home listing screen, cubit, navigator, and local widgets
│   │   └── onboarding/  # First-time user experience and onboarding bloc
│   │
│   └── widgets/         # Reusable, completely stateless UI components
│       ├── appbars/     # Custom AppBars
│       ├── buttons/     # Reusable buttons
│       ├── images/      # Network image wrappers
│       └── scaffold/    # Base scaffold widgets
│
└── main.dart            # Application entry point & root BlocProviders
```

---

## 🛠 Setup & Installation

**1. Clone the repository and install dependencies**
```bash
git clone <repository-url>
cd flutter_base_project
flutter pub get
```

**2. Run Code Generation (Crucial for Retrofit / JSON Serializable)**
Because this project utilizes code generation for API Clients and JSON parsing, you must run `build_runner` before the project can compile successfully.

```bash
# Run one time to build generated files (.g.dart)
dart run build_runner build --delete-conflicting-outputs

# OR run securely in the background checking for file changes
dart run build_runner watch --delete-conflicting-outputs
```

---

## ▶️ Running the App

You can run the app using the standard Flutter CLI commands:

```bash
# Run on connected device or simulator
flutter run

# Run in debug mode explicitly
flutter run --debug

# Run unit tests (if any)
flutter test

# Run static analysis to catch syntax or linting errors
flutter analyze
```

---

## 🌙 Features & Highlights
* **Dynamic Theming**: An interactive toggle inside the Home App Bar seamlessly switches between Light and Dark mode using a `ThemeCubit`.
* **Code-Generated API Routes**: Utilizes Retrofit to cleanly declare API routes on an interface, abstracting away complex parsing and boilerplate code.
* **Component Extraction**: All generic UI logic (Scaffolds, custom App Bars, Back Buttons, Network Images) are perfectly modularized into `lib/core/widgets` for instantaneous reuse.
