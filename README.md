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

CountriesApp
├── App
│   ├── CountriesAppApp.swift
│   └── ContentView.swift
│
├── Common
│   ├── Config
│   │   └── Debug
│   └── Utilities
│       └── LocationManager.swift
│
├── Data
│   └── (Repositories & data sources)
│
├── Domain
│   └── (Use cases, domain models)
│
├── Infrastructure
│   ├── Environment
│   │   └── Environment.swift
│   │
│   └── Network
│       ├── Context
│       │   ├── CountriesContext.swift
│       │   └── NetworkContext.swift
│       │
│       ├── Endpoint
│       │   └── Countries
│       │       └── Endpoint.swift
│       │
│       ├── Error
│       │   ├── CountriesRepositoryError.swift
│       │   ├── ErrorHandler.swift
│       │   └── NetworkError.swift
│       │
│       ├── Request
│       │   ├── RequestBuilder.swift
│       │   ├── RequestModifier.swift
│       │   ├── ContentType.swift
│       │   ├── CountriesEnvironment.swift
│       │   ├── Interceptor.swift
│       │   ├── NetworkClient.swift
│       │   ├── NetworkProvider.swift
│       │   ├── NetworkService.swift
│       │   └── ResponseProcessor.swift
│
├── Presentation
│   ├── BaseViewModel
│   │   └── BaseViewModel.swift
│   │
│   └── Features
│       ├── MainView
│       │   ├── View
│       │   │   └── CountriesMainView.swift
│       │   ├── ViewModel
│       │   └── CustomViews
│       │
│       └── DetailsView
│           └── View
│               └── CountryDetailsView.swift
│
├── Resources
│   └── Info.plist
│
└── CountriesAppTests
    ├── Countries
    │   ├── Mock
    │   │   └── MockGetCountriesUseCase.swift
    │   └── CountriesViewModelTests.swift
    │
    ├── Network
    └── CountriesAppTests.swift


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
