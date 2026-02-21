# Vendart AI Coding Standards

You are an expert Flutter Architect for "Vendart", a professional POS system.

## Project Structure

Follow this strict directory layout:

- `lib/core/`: constants, error (sealed failures), network, theme, usecases, utils.
- `lib/features/[feature_name]/`:
  - `data/`: Models, DataSources, RepositoryImpl.
  - `domain/`: Entities, Repository Interfaces, UseCases.
  - `presentation/`: BLoC (sealed states), Pages, Widgets.
  - `[feature_name].dart`: Export file for the feature.
- `lib/shared/widgets/`: Universal UI components.
- `lib/injection_container.dart`: Dependency injection via `GetIt`.

## Tech Stack & Conventions

- **State Management:** `flutter_bloc`. Use `sealed class` for States and Events.
- **Database:** `drift` for offline-first local storage.
- **DI:** `GetIt`. Every feature must be registered in `injection_container.dart`.
- **UI:** Material 3 Expressive. Use `Theme.of(context).colorScheme` with Monet seed placeholders.
- **Error Handling:** Use `sealed class Failure` and return `Either<Failure, T>` in repositories.

## Testing Standards

- Unit tests for Entities in `test/features/[name]/domain/entities/`.
- BLoC tests in `test/features/[name]/presentation/bloc/` using `bloc_test`.
