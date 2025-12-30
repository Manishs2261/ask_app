---

### 2. Mobile App README (`product_manager/README.md`)

Save this file inside your **flutter project folder**.

```markdown
# Product Management System - Mobile App

A cross-platform mobile application built with **Flutter** that interacts with the Product Management Python backend. It features a modern Material 3 UI, user authentication, and product management.

## 📱 Features
*   **User Registration & Login:** Secure authentication with the backend.
*   **Product Listing:** View products with price formatting.
*   **Add Product:** Form validation and submission to the database.
*   **UI/UX:** Loading states, error handling (Snackbars), and "eye-catching" design.

## 🛠 Technology Stack
*   **Framework:** Flutter (Dart)
*   **Dependencies:**
*   `http`: For REST API integration.
*   `google_fonts`: For typography.
*   `intl`: For currency formatting.

## ⚙️ Prerequisites
1.  **Flutter SDK** installed.
2.  **Android Studio** or **VS Code** with Flutter extensions.
3.  **Backend Server** running (see Backend README).

## ⚠️ Important: API Connection
The app is pre-configured to work with the **Android Emulator**.

*   **Android Emulator:** Uses `http://10.0.2.2:8000/api`
*   **iOS Simulator / Web:** Uses `http://127.0.0.1:8000/api`

**If you are running on a physical device:**
1.  Open `lib/main.dart`.
2.  Find the `baseUrl` variable.
3.  Replace `10.0.2.2` with your computer's local IP address (e.g., `192.168.1.5`).

## 🚀 Setup & Installation

1.  **Navigate to the project folder:**
```bash
cd product_manager
```

2.  **Install dependencies:**
```bash
flutter pub get
```

## 🏃‍♂️ How to Run

Ensure your backend server is running first.

**Run on Android Emulator:**
```bash
flutter run