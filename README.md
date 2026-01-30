# CountriesApp
The app consumes the REST Countries API to display country information, supports offline usage, location-based defaults, and includes unit tests.

# ✨ Features

🌍 Browse and view detailed information about countries

📍 Location-based default country selection

📡 Offline support using cached data

🧪 Unit tests with mocked dependencies

🧩 Modular and scalable architecture

# 🏗 Architecture

The project follows a layered architecture inspired by Clean Architecture principles, focusing on separation of concerns, testability, and scalability.

# Layers Overview

Presentation
SwiftUI views and ViewModels responsible for UI rendering and user interaction.

Domain
Business logic, use cases, and core models.

Data
Repository implementations that coordinate between the domain layer and data sources.

Infrastructure / Network
Networking, environment configuration, request building, and response handling.

The network layer was implemented first to ensure:

Strong separation of concerns

Easy mocking and testing

# Environment-based configuration (Debug / Production)
- Extend APIs without affecting higher layers

# 📁 Project Structure

<img width="1260" height="1198" alt="Screenshot 2026-01-30 at 3 35 01 PM" src="https://github.com/user-attachments/assets/75bb807e-3bdb-494a-ab73-58dfefc5df62" />

# 🌐 Network Layer

The network layer is designed to be modular, reusable, and testable.

Key Components

API Endpoint

The app consumes the REST Countries API to fetch country data.

Get All Countries (Basic Info)

Endpoint
GET https://restcountries.com/v2/all

RequestBuilder
Builds URLRequest instances.

Interceptor
Modifies requests (headers, logging, authentication, etc.).

NetworkClient
Executes network requests using URLSession.

ResponseProcessor
Validates responses and decodes models.

NetworkError / ErrorHandler
Centralized error handling and mapping.

This design allows the app to easily:

Switch between environments

Mock network calls in unit tests

Extend APIs without affecting higher layers
