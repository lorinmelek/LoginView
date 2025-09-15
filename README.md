# LoginView - iOS Login Screen

A modern, clean iOS login interface built with UIKit following MVVM architecture pattern and best practices.

## Features

- **Clean Architecture**: MVVM pattern with separation of concerns
- **Real-time Validation**: Live form validation with user feedback
- **Error Handling**: Comprehensive error management using Swift enums
- **Social Login Support**: Google, Apple, and Facebook login buttons
- **Responsive Design**: Auto Layout with safe area support
- **Password Visibility Toggle**: Eye icon to show/hide password
- **Custom Constants**: Organized text and image constants

## Screenshots

### Login Screen
![Login Screen](Screenshots/loginScreen.png)

### Validation Error
![Validation Error](Screenshots/validationError.png)
![Validation Toggle](Screenshots/validationError1.png)

### Password Toggle
![Password Toggle](Screenshots/showPassword.png)


## Architecture

### MVVM Pattern
- **View (LoginVC)**: Handles UI interactions and updates
- **ViewModel (LoginVM)**: Contains business logic and validation
- **Model**: ValidationError enum for type-safe error handling

### File Structure
```
LoginView/
├── Controller/
│   └── LoginVC.swift
├── ViewModel/
│   └── LoginVM.swift
├── Constants/
│   ├── LoginTexts.swift
│   └── LoginImages.swift
└── Resources/
    └── Assets.xcassets
└── View/
    └── Login.storyboard
```

## Technical Implementation

### Validation Features
- **Email/Username**: Minimum 3 characters, email format validation
- **Password**: Minimum 5 characters, secure entry
- **Real-time Feedback**: Instant validation as user types
- **Error Display**: Clear error messages with visual feedback

### UI Components
- Welcome label with custom font
- Email and password text fields with icons
- Password visibility toggle button
- Social login buttons (Google, Apple, Facebook)
- Error message label with dynamic visibility
- Responsive button states

### Code Quality
- **Constants Management**: Centralized text and image constants
- **Error Handling**: Swift enum-based validation errors
- **Memory Management**: Weak references to prevent retain cycles
- **Clean Code**: Single responsibility principle, readable method names

## Installation

1. Clone the repository
```bash
git clone https://github.com/lorinmelek/LoginView.git
```

2. Open `LoginView.xcodeproj` in Xcode

3. Add required assets to Assets.xcassets:
   - `googleIcon`: Google logo image
   - `facebookIcon`: Facebook logo image

4. Build and run the project

## Validation Rules

| Field | Rule | Error Message |
|-------|------|---------------|
| Email/Username | Required | "Required email or username" |
| Email/Username | Min 3 chars | "Username should be at least 3 character" |
| Email Format | Valid email if contains @ | "Enter valid email" |
| Password | Required | "Required password" |
| Password | Min 5 chars | "Password should be at least 5 character" |

## Dependencies

- UIKit
- Foundation

## Future Enhancements

- [ ] Biometric authentication (Face ID/Touch ID)
- [ ] Remember me functionality
- [ ] Password strength indicator
- [ ] Forgot password flow
- [ ] User registration screen
- [ ] Localization support
- [ ] Dark mode support
- [ ] Accessibility improvements

## Author

**LORIN VURAL**  
*iOS Developer*

---

*Built with ❤️ using Swift and UIKit*