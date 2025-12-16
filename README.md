# Flutter Task

A comprehensive Flutter application demonstrating modern UI implementation, state management with MVVM, local data persistence, and responsive design.

## 1. Dependencies Used & Why

This project utilizes a curated set of packages to ensure scalability, maintainability, and a premium user experience:

-   **`flutter_screenutil`**:  
    Used to implement a fully responsive UI that adapts to different screen sizes and pixel densities. It allows us to set a reference design size (375x812) and scale dimensions (`.w`, `.h`), font sizes (`.sp`), and radii (`.r`) proportionally.

-   **`shared_preferences`**:  
    Used for local data persistence. It allows the app to save the user's training plan (dragged workouts) and reload them upon app restart, ensuring a persistent user experience.

-   **`go_router`**:  
    Used for centralized routing. It handles deep linking (future-proof), stateful shell routes (preserving tab state), and smooth custom transition animations between screens.

-   **`flutter_svg`**:  
    Used to render high-quality SVG assets (icons, illustrations) instead of raster images, ensuring crisp visuals on any device resolution.

-   **`intl`**:  
    Used for date formatting (e.g., displaying "Today" or specific dates in the calendar header) and strict date handling logic.

-   **`google_fonts`**:  
    Used to implement custom typography (e.g., 'Lato', 'Integral CF') easily without manually bundling font files, ensuring consistent branding.

-   **`cupertino_icons`**:  
    Provides standardized iOS-style icons for a native feel where appropriate.

## 2. Project Structure

The project follows the **MVVM (Model-View-ViewModel)** architectural pattern to ensure separation of concerns and testability.

```
lib/
 ├── models/          # Data classes defining the structure of objects (e.g., TrainingDay, WorkoutData).
 ├── views/           # UI components, screens, and widgets.
 │   ├── home/        # Home/Nutrition screen and its specific widgets.
 │   ├── plan/        # Training Calendar screen and draggable/droppable widgets.
 │   ├── mood/        # Mood tracking screen with custom painters and animations.
 │   └── widgets/     # Reusable shared widgets (e.g., AppButton, Common Cards).
 ├── viewmodels/      # Business logic and state management. Connects Views to Models/Repositories.
 ├── services/        # Data handling layer (e.g., TrainingRepository for persistence).
 ├── utils/           # Helper classes for Colors, Typography, Assets, and Date logic.
 └── main.dart        # Application entry point and global configuration (ScreenUtilInit).
```

### Key Architectural Decisions:
-   **MVVM**: Views (UI) listen to ViewModels (ChangeNotifiers) using `ListenableBuilder`. ViewModels handle all logic and update the UI only when necessary.
-   **Service/Repository Pattern**: `TrainingRepository` encapsulates the logic for saving/loading data to `shared_preferences`. The ViewModel communicates with this repository, keeping the UI ignorant of *how* data is stored.
-   **Responsiveness**: All UI elements are built using `flutter_screenutil` extensions to guarantee pixel-perfect matching of the design on any device.

## 3. App Screenshots

[**Download ScreenShots**](https://drive.google.com/drive/folders/1rhlU5rEO79kkaY7YLfWeyxmeNWm2WbVc?usp=sharing)

## 4. App Video

Check out the demonstration of the app's flow, including the drag-and-drop workout planning and mood tracking features.

[**Watch App Demo Video**](https://drive.google.com/drive/folders/1XQG3dHmghG3TdVjKQoP5R_qdwtKpBIcr?usp=sharing)

## 5. App APK

You can download the latest APK to test the application on an Android device.

[**Download APK From Drive**](https://drive.google.com/drive/folders/1IJS37D6OoyhvKZNEyysEWxhbwESoJ0_A?usp=sharing)
[**Download APK From Git**](https://github.com/MuhammadBilalTahir007/wellness-app/releases/tag/First_Release)

---

### Would've loved to add the app icon and a detailed Splash Screen but didn't for now ###
