# Peibo Flutter technicalt challenge

This is a technical challenge for Peibo Flutter developer position. The challenge is designed to evaluate skills in Flutter development, including  ability to write clean, maintainable code and understanding of best practices in Flutter and Software development.

![Preview](/ui_proposal.png)

## Objectives
1. Build a Flutter application that fetches and displays a list of Pokémon from the [PokeAPI](https://pokeapi.co/).
2. Creation of two screens:
   - A list of Pokémon.
   - A detail screen for each Pokémon.
3. Implement architectures principles.
4. Write clean, maintainable code.
5. State management.
6. Navigation.
7. CRUD operations.


### Conditions
1. Riverpod as state management.
2. Dio as HTTP client.

### Extra Points
1. Components driven development.
2. Unit tests.


## Clean Architecture proposal
```
lib/
├── core/
│   ├── config/                     // App-wide configurations (themes, routes, constants).
│   ├── error/                      // App-wide error/failure handling (Failure classes, exceptions).
│   ├── network/                    // Network utilities (connectivity, API client setup, interceptors).
│   └── utils/                      // Common utility functions and classes.
│
├── common/                         // Common layers transversal components or abstractions (widgets, extensions, etc.).
├── feature/
│   └── pokemon/
│       ├── data/
│       │   ├── data_source/        // Data source abstractions (remote/local API interactions).
│       │   ├── mappers/            // Mapping extension classes  to convert between DTOs and domain entities.
│       │   ├── models/             // Data Transfer Objects (DTOs) for data sources.
│       │   └── repository/         // Repository implementations (from domain layer).
│       │
│       ├── domain/
│       │   ├── entities/           // Core business objects.
│       │   ├── repository/         // Abstract repository interfaces (contracts).
│       │   └── usecases/           // Use cases encapsulating specific business logic.
│       │                           
│       └── presentation/
│           ├── common/             // Common UI components (widgets, UI Utils, etc.).
│           │  ├── providers/       // Common Riverpod providers.
│           │  └── widgets/         // Reusable feature-specific UI widgets.
│           │
│           ├── component_a/
│           │   ├── component_a.dart                  // Component A widget.
│           │   ├── component_a_provider_state.dart   // Component A state.
│           │   └── component_a_provider.dart         // Component A provider (state management).
│           │
│           └── component_b/
│               ├── component_b.dart                  // Component B widget.
│               └── component_b_provider.dart         // Component B view (UI).
└── main.dart                                         // App entry point. Initializes Riverpod.
```

## Instructions
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.