Smart Waste Management & Recycling App

Overview

A Clean-Architecture Flutter app (MVVM + Repository) using Firebase, Google Maps, and Hive for offline support. Features: waste logging, pickup scheduling, recycling center locator, rewards, admin dashboard, and offline sync.

Tech stack

- Flutter
- Firebase (Auth, Firestore, Storage)
- Google Maps
- Hive for local storage
- Provider for state management

Folder structure (lib/)

- models/
- services/
- repositories/
- viewmodels/
- views/
- widgets/
- utils/

Firestore schema (recommended)

Collections:

- users/{userId}
  - name, email, phone, role (user/admin), points, address

- waste_items/{wasteId}
  - userId, category, description, imageUrl, status (logged/scheduled/completed), pointsEarned, createdAt, scheduledAt, address, gpsLocation

- pickups/{pickupId}
  - wasteId, userId, assignedTo (collectorId), status, scheduledAt, routeInfo

- recycling_centers/{centerId}
  - name, address, location (GeoPoint), typesAccepted, contact

- admin_reports/{reportId}
  - stats, generatedAt

High-level implementation steps

1. Project setup: create Flutter project, enable Firebase, add Google Maps API key.
2. Implement auth flow (Firebase Auth) and profile management.
3. Build models and repositories for waste items, pickups, and users.
4. Implement Hive local cache and a SyncService to reconcile local changes when online.
5. Build ViewModels (ChangeNotifier) for UI binding.
6. Design UI screens: Onboarding/Login, Home Dashboard, Log Waste, Schedule Pickup, Map, Rewards, Admin Dashboard.
7. Integrate Google Maps and geolocation to show nearby recycling centers.
8. Add image upload to Firebase Storage.
9. Implement reward points logic and points dashboard.
10. Add offline support and background sync.
11. Testing, performance optimizations, and release build.

Running locally

- Install Flutter and set up Android/iOS toolchains.
- Create a Firebase project and enable Auth (Email/Password), Firestore, and Storage.
- Add the Firebase config files (google-services.json / GoogleService-Info.plist).
- Add Google Maps API key to AndroidManifest and AppDelegate.
- Run: flutter pub get
- Run: flutter run

Notes

This repository contains a scaffold with core components to accelerate development. Follow Clean Architecture and write unit/integration tests for ViewModels and Repositories.

StudentID_ProblemStatement.pdf

Include a PDF named StudentID_ProblemStatement.pdf documenting the problem statement and architecture decisions.

GitHub Workflow

Commits must follow:
1. Init project
2. Waste logging
3. Scheduling
4. Rewards & UI

Contact

This scaffold was generated to jumpstart development. Replace placeholders and implement business logic as required.
