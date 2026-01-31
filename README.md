# Excelerate Connect

Excelerate Connect is a cross-platform mobile application developed as part of an internship project to provide a centralized, mobile-first engagement platform within the Excelerate ecosystem.

The application addresses the current fragmentation caused by multiple web portals and high-volume email communication by consolidating program information, announcements, learning resources, and participant feedback into a single mobile application.

---

## 📱 Project Overview

Excelerate Connect aims to improve accessibility, engagement, and communication efficiency for Excelerate participants by offering a unified mobile platform built using Flutter. The application supports both Android and iOS platforms from a single codebase.

---

## 🎯 Objectives

- Centralize Excelerate program information in one mobile platform
- Deliver real-time announcements through a dynamic dashboard
- Improve user engagement via a mobile-optimized interface
- Establish a structured feedback mechanism

---

## 🔍 Features 

### Implemented Features

- Secure user authentication (Sign Up & Login)
- Form validation for all user inputs
- Dynamic dashboard for announcements and updates
- Searchable and filterable program catalog
- Program and learning module previews
- Feedback and registration forms
- Protected routing for authenticated users
- Success and confirmation screens

---

### Out-of-Scope (Future Enhancements)

- In-app video conferencing
- Real-time peer-to-peer chat
- Payment gateway integration

---

## 🛠️ Technology Stack

- **Frontend Framework:** Flutter (Dart)
- **State Management:** Provider / Riverpod
- **UI/UX Design:** Figma
- **Version Control:** Git & GitHub
- **Data Handling:** JSON (Mock Database)
- **Routing:** Flutter Navigator (Protected Routes)

---

## Repository Structure

The repository includes:
- lib directory containing all Flutter source code
- assets directory for images and static resources
- mock_data directory for JSON files
- pubspec.yaml for dependency management
- README.md for project documentation

---
## 🔐 Authentication System

The application includes a complete authentication workflow implemented during the final sprint:

- User account creation (Sign Up)
- Secure login functionality
- Input validation for authentication forms
- JSON-based user data storage
- Protected dashboard access for authenticated users only
- Success screens after successful authentication

All authentication flows were tested and verified after merging the final sprint branch into the main branch.

---

## 🧩 Development Methodology

The project follows an iterative and modular development approach aligned with IEEE-recommended software engineering practices. The development lifecycle includes requirement analysis, UI/UX design, implementation, testing, and documentation.

---
## Setup Instructions

Follow the steps below to run the application locally.

### Prerequisites

- Flutter SDK installed
- Android Studio or VS Code
- Android emulator or physical device
- Xcode is required for iOS builds on macOS

### Steps

1. Clone the repository
```bash
https://github.com/AnushkaGyawali/excelerateconnect
```
2. Navigate to the project root directory
```bash
cd excelerateconnect
```
3. Run the following command to install dependencies
```bash
flutter pub get
```
4. Connect an emulator or physical device
5. Run the application
```bash
   flutter run
```
The application uses mock JSON data. No backend or API configuration is required.

---

## 📦 Project Status

✅ **Final Sprint Completed**

The core features of the application have been implemented and tested successfully.  
This includes authentication, dashboard functionality, program catalog, protected routing, and form validations.

---

✅ **Final Sprint Summary**

- Complete authentication system implemented (Sign Up & Login)
- Form validations added for user inputs
- JSON-based user data handling
- Protected routes for authenticated users
- Dashboard and Program Catalog fully functional
- Program Catalog & Details screens use sample JSON data
- Registration forms tested and verified
- UI flows tested after final sprint merge
- Screenshots updated in README

---

## 📸 Screenshots

<table>
  <tr>
  <td align="center">
      <img src="/assets/screenshots/signup.png" width="250"/>
      <br/>
      <b>Sign up Screen</b>
    </td>
    <td align="center">
      <img src="/assets/screenshots/login.png" width="250"/>
      <br/>
      <b>Login Screen</b>
    </td>
    <td align="center">
      <img src="/assets/screenshots/registration.png" width="250"/>
      <br/>
      <b> Login Registration</b>
    </td>
    <td align="center">
      <img src="/assets/screenshots/dashboard.png" width="250"/>
      <br/>
      <b>Dashboard</b>
    </td>
     <td align="center">
      <img src="/assets/screenshots/programs.png" width="250"/>
      <br/>
      <b>Program Catalog</b>
    </td>
  </tr>

  <tr>
     <td align="center">
      <img src="/assets/screenshots/search-screen.png" width="250"/>
      <br/>
      <b>search screen</b>
    </td>
    <td align="center">
      <img src="/assets/screenshots/program_details.png" width="250"/>
      <br/>
      <b>Program Details</b>
    </td>
        <td align="center">
      <img src="/assets/screenshots/registration-form.png" width="250"/>
      <br/>
      <b>Registration and Payment Form</b>
    </td>
       <td align="center">
      <img src="/assets/screenshots/registration-form1.png" width="250"/>
      <br/>
      <b>Registration and Payment Form</b>
    </td>
     <td align="center">
      <img src="/assets/screenshots/course-success.png" width="250"/>
      <br/>
      <b>Enrollment Message</b>
    </td>
  </tr>

 <tr>
    <td align="center">
      <img src="/assets/screenshots/myprogram.png" width="250"/>
      <br/>
      <b>My Enrolled Program</b>
    </td>
    <td align="center">
      <img src="/assets/screenshots/message-screen.png" width="250"/>
      <br/>
      <b>Message Screen</b>
    </td>
    <td align="center">
      <img src="/assets/screenshots/profile-screen.png" width="250"/>
      <br/>
      <b>My Profile Screen</b>
    </td>
    <td align="center">
      <img src="/assets/screenshots/login-error.png" width="250"/>
      <br/>
      <b>Login-error Page</b>
    </td>
   <td align="center">
      <img src="/assets/screenshots/login-success.png" width="250"/>
      <br/>
      <b>Login-success Page</b>
    </td>
  </tr>
</table>

---

## ✅ Testing & Verification

After the final sprint merge, the application was tested to verify:
- Account creation and login flow
- Form validation behavior
- Protected routing and dashboard security
- Navigation between core screens
All tested features are functioning as expected.

---

## 🤝 Collaboration

This is a shared repository maintained by the project team. Contributors are expected to follow standard Git practices, including meaningful commit messages and pull request-based collaboration.

---

## 📄 License

This project is developed for educational and internship purposes. Licensing details will be added if required.
