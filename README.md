# Ahmed Elghareeb - Flutter Developer Portfolio 🚀

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Responsiveness](https://img.shields.io/badge/Responsive-Mobile%20%7C%20Tablet%20%7C%20Web-orange?style=for-the-badge)

A stunning, modern, and fully responsive portfolio web application built with Flutter. Designed to showcase my projects, skills, and professional experience with a premium, glassmorphism-inspired UI.

## ✨ Features

- **Responsive Design**: Adapts seamlessly to Desktop, Tablet, and Mobile screens.
- **Glassmorphism UI**: Modern, translucent card designs with gradient borders.
- **Theme System**: Dynamic Dark/Light mode toggle with persistent state.
- **Interactive Animations**:
  - Entrance animations (Fade, Slide, Scale).
  - Hover effects on cards and buttons.
  - Typewriter text effects.
  - Animated background particles (in Dark Mode).
- **Navigation**: Smooth scroll-to-section functionality.
- **Project Filtering**: Filter projects by category (Fintech, E-commerce, etc.).
- **Contact Integration**: Working contact form (via `mailto`) and social links.
- **Downloadable CV**: Direct link to download/view Resume.
- **PWA Ready**: Optimized for web performance.

## 🛠️ Tech Stack & Architecture

This project follows a **Clean Architecture** approach to ensure scalability and maintainability.

- **Framework**: Flutter (Web)
- **Language**: Dart
- **State Management**: `flutter_bloc` & `Cubit`
- **Routing**: `go_router`
- **Architecture Layers**:
  - `core`: Constants, Theme, Utils (Responsive logic).
  - `data`: Data models and static content.
  - `presentation`: Widgets, Pages, Blocs.
  - `routes`: Navigation configuration.

### Key Packages
- `flutter_bloc`: State management for Theme.
- `flutter_animate`: Declarative animations.
- `glassmorphism`: Frosted glass effects.
- `url_launcher`: Opening external links and emails.
- `font_awesome_flutter`: Social icons.
- `google_fonts`: Typography (Poppins, Inter).
- `timeline_tile` (Custom Impl): Experience timeline visualization.

## 🚀 Getting Started

1.  **Clone the repository**
    ```bash
    git clone https://github.com/yourusername/my_portfolio.git
    ```

2.  **Install dependencies**
    ```bash
    flutter pub get
    ```

3.  **Run the application**
    ```bash
    flutter run -d chrome
    ```

## 📂 Project Structure

```
lib/
├── core/
│   ├── constants/    # App colors, strings
│   ├── theme/        # Light/Dark theme data, Cubit
│   └── utils/        # Responsive helpers
├── data/
│   ├── models/       # Data classes (Project, Experience)
│   └── portfolio_data.dart  # Static data content
├── presentation/
│   ├── pages/        # Main screens (HomePage)
│   └── widgets/      # Reusable widgets & Sections
│       ├── common/   # Buttons, GlassCard
│       └── sections/ # Hero, About, Projects, etc.
└── routes/           # AppRouter configuration
```

## 📬 Contact

**Ahmed Ashraf Elghareeb** - Flutter Developer

- **LinkedIn**: [Ahmed Elghareeb](https://www.linkedin.com/in/ahmed-elghareeb8/)
- **Email**: ahmed.elghareeb1166@gmail.com
- **WhatsApp**: [+201156750391](https://wa.me/+201156750391)

---
*Built with 💙 using Flutter*
