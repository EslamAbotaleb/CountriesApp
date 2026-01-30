# CountriesApp
The app consumes the REST Countries API to display country information, supports offline usage, location-based defaults, and includes unit tests.

## Architecture

The project follows a layered architecture inspired by Clean Architecture principles:

- **Presentation** – SwiftUI views & ViewModels
- **Domain** – Business logic & use cases
- **Data** – Repositories
- **Network** – API communication, request building, response handling

The network layer was implemented first to ensure:
- Strong separation of concerns
- Easy mocking & testing
- Environment-based configuration

## 🌐 Network Layer

The network layer is designed to be modular, reusable, and testable.

Key components:
- `Endpoint` – Describes API endpoints
- `RequestBuilder` – Builds URLRequest objects
- `Interceptor` – Handles request modification (e.g. headers, logging)
- `NetworkClient` – Executes requests using URLSession
- `ResponseProcessor` – Validates responses and decodes models
- `NetworkError` – Centralized error handling

This design allows the app to easily:
- Switch environments
- Mock network calls in tests
- Extend APIs without affecting higher layers
