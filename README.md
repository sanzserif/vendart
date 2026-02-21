# Vendart

Vendart is a Flutter based POS application that implements Feature-First Clean Architecture. This project is structured to separate concerns and promote maintainability, scalability, and testability.

## Project Structure

```
vendart
├── lib
│   ├── main.dart
│   ├── app.dart
│   ├── core
│   │   ├── constants
│   │   │   └── app_constants.dart
│   │   ├── error
│   │   │   ├── exceptions.dart
│   │   │   └── failures.dart
│   │   ├── network
│   │   │   └── network_info.dart
│   │   ├── theme
│   │   │   └── app_theme.dart
│   │   ├── usecases
│   │   │   └── usecase.dart
│   │   └── utils
│   │       └── input_converter.dart
│   ├── features
│   │   ├── auth
│   │   │   ├── data
│   │   │   │   ├── datasources
│   │   │   │   │   ├── auth_local_datasource.dart
│   │   │   │   │   └── auth_remote_datasource.dart
│   │   │   │   ├── models
│   │   │   │   │   └── user_model.dart
│   │   │   │   └── repositories
│   │   │   │       └── auth_repository_impl.dart
│   │   │   ├── domain
│   │   │   │   ├── entities
│   │   │   │   │   └── user.dart
│   │   │   │   ├── repositories
│   │   │   │   │   └── auth_repository.dart
│   │   │   │   └── usecases
│   │   │   │       ├── login.dart
│   │   │   │       ├── logout.dart
│   │   │   │       └── register.dart
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       │   ├── auth_bloc.dart
│   │   │       │   ├── auth_event.dart
│   │   │       │   └── auth_state.dart
│   │   │       ├── pages
│   │   │       │   ├── login_page.dart
│   │   │       │   └── register_page.dart
│   │   │       └── widgets
│   │   │           └── auth_form.dart
│   │   ├── home
│   │   │   ├── data
│   │   │   │   ├── datasources
│   │   │   │   │   └── home_remote_datasource.dart
│   │   │   │   ├── models
│   │   │   │   │   └── product_model.dart
│   │   │   │   └── repositories
│   │   │   │       └── home_repository_impl.dart
│   │   │   ├── domain
│   │   │   │   ├── entities
│   │   │   │   │   └── product.dart
│   │   │   │   ├── repositories
│   │   │   │   │   └── home_repository.dart
│   │   │   │   └── usecases
│   │   │   │       └── get_products.dart
│   │   │   └── presentation
│   │   │       ├── bloc
│   │   │       │   ├── home_bloc.dart
│   │   │       │   ├── home_event.dart
│   │   │       │   └── home_state.dart
│   │   │       ├── pages
│   │   │       │   └── home_page.dart
│   │   │       └── widgets
│   │   │           └── product_card.dart
│   │   └── cart
│   │       ├── data
│   │       │   ├── datasources
│   │       │   │   └── cart_local_datasource.dart
│   │       │   ├── models
│   │       │   │   └── cart_item_model.dart
│   │       │   └── repositories
│   │       │       └── cart_repository_impl.dart
│   │       ├── domain
│   │       │   ├── entities
│   │       │   │   └── cart_item.dart
│   │       │   ├── repositories
│   │       │   │   └── cart_repository.dart
│   │       │   └── usecases
│   │       │       ├── add_to_cart.dart
│   │       │       ├── get_cart_items.dart
│   │       │       └── remove_from_cart.dart
│   │       └── presentation
│   │           ├── bloc
│   │           │   ├── cart_bloc.dart
│   │           │   ├── cart_event.dart
│   │           │   └── cart_state.dart
│   │           ├── pages
│   │           │   └── cart_page.dart
│   │           └── widgets
│   │               └── cart_item_tile.dart
│   └── injection_container.dart
├── test
│   ├── core
│   │   └── utils
│   │       └── input_converter_test.dart
│   └── features
│       └── auth
│           ├── data
│           │   └── repositories
│           │       └── auth_repository_impl_test.dart
│           ├── domain
│           │   └── usecases
│           │       └── login_test.dart
│           └── presentation
│               └── bloc
│                   └── auth_bloc_test.dart
├── pubspec.yaml
├── analysis_options.yaml
└── README.md
```

## Features

- **Authentication**: User login, registration, and logout functionalities.
- **Home**: Display a list of products.
- **Cart**: Manage cart items, including adding, removing, and viewing items.

## Getting Started

1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Use `flutter run` to start the application.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.

## License

This project is licensed under the MIT License. See the LICENSE file for details.
