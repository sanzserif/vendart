# Vendart Project Agent Context

## Business Logic & Persistence

1. **Local-First:** All business logic (UseCases) must operate on Entities. DataSources must implement `Drift` DAOs.
2. **Device Sync:** Store user settings (colors, preferences) in a device-specific Drift table; sync using "Last-Write-Wins" logic per device type.
3. **DI Pattern:** When adding a new feature, instructions MUST include updating `lib/injection_container.dart` to register the new BLoC, UseCase, and Repository.

## Code Generation constraints

- **Exports:** Always create a `feature_name.dart` file at the root of a feature folder to manage public exports.
- **Immutability:** Use `freezed` or `dart 3` records/sealed classes for data transfer objects (DTOs).
- **Material 3:** Prioritize `FilledButton.tonal`, `Card.outlined`, and expressive large-corner shapes (24dp).
