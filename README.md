# Boby AI Case - Movie App

App Screen Recording: https://drive.google.com/file/d/188CljdLbt4L5SHAke9oHYQX7VaReVclb/view?usp=share_link

## 🏗️ Build Environments (Flavors/Schemes)

This project implements three distinct build environments:

| Environment | App Name  | Bundle ID Suffix | Description                                  |
| ----------- | --------- | ---------------- | -------------------------------------------- |
| **Dev**     | Movie DEV | `.dev`           | Development environment with verbose logging |
| **Staging** | Movie STG | `.staging`       | Pre-production testing environment           |
| **Prod**    | Movie     | (none)           | Production release                           |

### Key Features

- ✅ **Unique App Icons** - Each environment has a distinct icon for easy identification
- ✅ **Separate Bundle IDs** - Allows installing all three versions simultaneously
- ✅ **Configurable API Endpoints** - Easy to change base URLs per environment
- ✅ **Conditional Logging** - Enabled in Dev/Staging, disabled in Production

---

## 🚀 Getting Started (Local Setup)

To run this project locally, you need to set up your environment variables.

1.  **Create an `.env` file:**
    Duplicate the `.env_example` file in the root directory and rename it to `.env`.

    ```bash
    cp .env_example .env
    ```

2.  **Add your API Key:**
    Open the newly created `.env` file and replace the placeholder with your actual API key.

    ```
    API_KEY=your_real_api_key_here
    ```

3.  **Run the App:**
    Use the build commands below to run the specific flavor you want.

---

## 🛠️ Build Commands

### Development Build

```bash
# Run (Android/iOS)
flutter run --flavor dev -t lib/main_dev.dart

# Build APK
flutter build apk --flavor dev -t lib/main_dev.dart

# Build iOS (requires Mac with Xcode)
flutter build ios --flavor dev -t lib/main_dev.dart
```

### Staging Build

```bash
# Run
flutter run --flavor staging -t lib/main_staging.dart

# Build APK
flutter build apk --flavor staging -t lib/main_staging.dart

# Build iOS
flutter build ios --flavor staging -t lib/main_staging.dart
```

### Production Build

```bash
# Run
flutter run --flavor prod -t lib/main_prod.dart

# Build Release APK
flutter build apk --release --flavor prod -t lib/main_prod.dart

# Build App Bundle (for Play Store)
flutter build appbundle --release --flavor prod -t lib/main_prod.dart

# Build iOS
flutter build ios --release --flavor prod -t lib/main_prod.dart
```

---

## 🔧 Configuration Injection

Environment-specific configurations are managed through `FlavorConfig` class:

```dart
// lib/core/config/app_flavor.dart
FlavorConfig.initialize(
  flavor: AppFlavor.dev,
  appName: 'Movie DEV',
  baseUrl: 'https://api.themoviedb.org/3/',
  enableLogging: true,
);
```

### Adding New Configuration Values

1. Add the field to `FlavorConfig` class
2. Update `FlavorConfig.initialize()` in each `main_*.dart` entry point
3. Expose via `AppConfig` for easy access throughout the app

---

## 📱 CI/CD Considerations

### GitHub Actions / CI Pipeline Recommendations

#### 1. Parallel Flavor Builds

```yaml
strategy:
  matrix:
    flavor: [dev, staging, prod]

steps:
  - name: Build ${{ matrix.flavor }}
    run: flutter build apk --flavor ${{ matrix.flavor }} -t lib/main_${{ matrix.flavor }}.dart
```

#### 2. Environment Variables

- Store API keys in CI secrets (e.g., `TMDB_API_KEY`)
- Generate `.env` file during build: `echo "API_KEY=$TMDB_API_KEY" > .env`

#### 3. Artifact Separation

- Name artifacts with flavor suffix: `app-dev-release.apk`, `app-prod-release.apk`
- Store each flavor's build outputs separately

#### 4. Deployment Strategies

| Flavor  | Deployment Target                          |
| ------- | ------------------------------------------ |
| Dev     | Firebase App Distribution (Internal)       |
| Staging | TestFlight / Play Console Internal Testing |
| Prod    | App Store Connect / Google Play Console    |

#### 5. Signing Configuration

- Dev/Staging: Use debug keystore or development certificates
- Prod: Use production keystore/certificates stored securely in CI secrets

### Fastlane Integration Example

```ruby
# fastlane/Fastfile
lane :build_dev do
  flutter_build(flavor: 'dev', target: 'lib/main_dev.dart')
end

lane :build_staging do
  flutter_build(flavor: 'staging', target: 'lib/main_staging.dart')
end

lane :build_prod do
  flutter_build(flavor: 'prod', target: 'lib/main_prod.dart')
end
```

---

## 📁 Project Structure (Flavor-Related Files)

```
lib/
├── main_dev.dart         # Dev entry point
├── main_staging.dart     # Staging entry point
├── main_prod.dart        # Production entry point
└── core/
    └── config/
        ├── app_config.dart   # Configuration accessor
        └── app_flavor.dart   # FlavorConfig & AppFlavor enum

android/app/
├── build.gradle.kts      # Product flavors definition
└── src/
    ├── dev/res/          # Dev-specific resources (icon)
    ├── staging/res/      # Staging-specific resources (icon)
    └── prod/res/         # Prod-specific resources (icon)

ios/
├── Flutter/
│   ├── Dev.xcconfig      # Dev build settings
│   ├── Staging.xcconfig  # Staging build settings
│   └── Prod.xcconfig     # Production build settings
└── Runner/Assets.xcassets/
    ├── AppIcon-Dev.appiconset/
    ├── AppIcon-Staging.appiconset/
    └── AppIcon.appiconset/
```

---
