# 🧩 MVVM Sign Up Flow (SwiftUI)

This project is a **basic Sign Up flow** built using **SwiftUI** and the **MVVM (Model–View–ViewModel)** architecture.  

![MVVM1](https://github.com/user-attachments/assets/7faba130-70d8-45e9-b38c-044a16423374)

It demonstrates how to structure a multi-step sign-up process with clean UI, validation logic, and navigation — while keeping business logic out of the views.

![MVVM2](https://github.com/user-attachments/assets/9de27ccc-5f33-47b6-a915-735f782cc6c7)


---

## ✨ Features

- 👤 **Username & Email Step**
  - Username input with validation
  - Email input with proper keyboard and content types
  - Clean card-style form UI

- 🔐 **Password Step**
  - Secure password input
  - Confirm password validation
  - Prevents empty or mismatched passwords

- 🧠 **MVVM Architecture**
  - Views handle UI only
  - ViewModel manages validation, state, and navigation logic

- 🚨 **User Feedback**
  - Alerts for validation errors
  - Clear messages for incorrect or missing input

- 🧭 **Multi-Step Navigation**
  - Uses `NavigationStack`
  - Smooth transitions between sign-up steps
  - Final navigation to a welcome screen

- 🎨 **Modern SwiftUI Design**
  - Gradient background
  - Material-based input fields
  - Focus management with `@FocusState`

---

## 🛠️ Tech Stack

- **SwiftUI** – Declarative UI
- **MVVM Architecture**
- **@StateObject / @ObservedObject**
- **NavigationStack**
- **FocusState**
- **Alerts & Validation Logic**

---

## 📱 Screens Overview

### 1️⃣ Username & Email Screen
- Username input
- Email input
- “Next” button with validation
- Terms & privacy text

### 2️⃣ Password Screen
- Secure password field
- Confirm password field
- “Finish” button
- Validation alerts

### 3️⃣ Welcome Screen
- Displayed after successful sign-up completion

---

## 🧠 MVVM Breakdown

### View
- `SignUpUsernameEmailView`
- `SignUpPasswordStepView`

Responsibilities:
- UI layout
- User interaction
- Navigation bindings

### ViewModel
- `SignUpUsernameEmailViewModel`

Responsibilities:
- Input validation
- Alert messages
- Navigation state
- Shared sign-up data

This separation keeps the UI clean and testable.

---

## 🧪 SwiftUI Previews

The project includes SwiftUI previews for fast UI iteration without running the full app.

---

## 🚀 Getting Started

### Requirements
- Xcode 15 or later
- iOS 17 or later

### Installation
1. Clone the repository
2. Open the project in **Xcode**
3. Build and run on a simulator or device
4. Walk through the sign-up flow

---

## 📌 Project Purpose

This project is designed as:
- A **learning example** for MVVM in SwiftUI
- A **reference implementation** for multi-step forms
- A **starter template** for authentication flows
- A **portfolio-ready UI demo**

---

## 🧩 Key Concepts Demonstrated

- MVVM architecture in SwiftUI
- State sharing across multiple views
- Form validation
- Navigation-driven flows
- Focus management
- Clean and modern UI composition
  
---

## 📄 License

This project is for educational purposes.  
You are free to modify, extend, and reuse it for learning or personal projects.

---

Made with ❤️ using SwiftUI & MVVM
