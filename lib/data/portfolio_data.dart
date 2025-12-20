import 'models/portfolio_models.dart';

class PortfolioData {
  static const personalInfo = {
    "name": "Ahmed Ashraf Elghareeb",
    "title": "Mid-Level Flutter Developer",
    "location": "Mansoura, Ad Daqahliya, Egypt",
    "email": "ahmed.elghareeb1166@gmail.com",
    "phone": "+201064503827",
    "whatsapp": "+201064503827",
    "linkedin": "https://www.linkedin.com/in/ahmed-elghareeb8/",
    "github": "https://github.com/AhmedAElghareeb",
    "yearsOfExperience": "2+",
    "projectsDelivered": "8+",
    "appsPublished": "5+",
  };

  static const String bio = """
Flutter Developer with 2+ years of experience building cross-platform mobile applications using Flutter, Dart, and Firebase. Delivered 8+ production apps in fintech, e-commerce, and ride-hailing sectors across App Store and Play Store. Skilled in clean architecture, Bloc state management, and agile workflows.
""";

  static const taglineOptions = [
    "Crafting Pixel-Perfect Mobile Experiences",
    "Turning Ideas into Powerful Flutter Apps",
    "Building Tomorrow's Apps, Today",
  ];

  static const heroSection = {
    "greeting": "Hello, I'm",
    "name": "Ahmed Ashraf Elghareeb",
    "titles": [
      "Flutter Developer",
      "Mobile App Engineer",
      "Cross-Platform Specialist",
      "UI/UX Enthusiast"
    ],
    "stats": [
      {"value": "2+", "label": "Years Experience"},
      {"value": "8+", "label": "Apps Delivered"},
      {"value": "5+", "label": "Published Apps"},
      {"value": "4", "label": "Companies Worked"}
    ]
  };

  static const aboutSection = {
    "title": "About Me",
    "subtitle": "Get to know me better",
    "description": """
I'm a passionate Flutter Developer based in Mansoura, Egypt, with over 2 years of hands-on experience in building beautiful, high-performance cross-platform mobile applications.

My journey in mobile development has led me to work on diverse projects spanning fintech, e-commerce, ride-hailing, and transportation sectors. I've successfully delivered 8+ production applications that are live on both the App Store and Play Store.

I specialize in clean architecture, Bloc state management, and creating pixel-perfect UIs that users love. When I'm not coding, I'm exploring new technologies and contributing to the Flutter community.
    """,
    "highlights": [
      {
        "icon": "rocket",
        "title": "Fast Learner",
        "desc": "Quick to adapt to new technologies"
      },
      {
        "icon": "code",
        "title": "Clean Coder",
        "desc": "Writing maintainable, scalable code"
      },
      {
        "icon": "mobile",
        "title": "Cross-Platform",
        "desc": "One codebase, multiple platforms"
      },
      {
        "icon": "team",
        "title": "Team Player",
        "desc": "Agile workflow experience"
      }
    ],
    "funFacts": [
      "🏆 Ranked 1st among 15+ peers in internship",
      "📱 5+ apps live on App Store & Play Store",
      "🌍 Built apps used across Egypt, Saudi Arabia & Syria",
      "🎓 A+ Graduation Project in Biometrics"
    ]
  };

  static const List<Experience> experiences = [
    Experience(
        period: "July 2024 - Present",
        role: "Flutter Developer",
        company: "Geexar",
        location: "Mansoura, Daqahliyah",
        type: "Full-time",
        description: [
          "Engineered and maintained 5+ high-performance cross-platform mobile apps (Android & iOS)",
          "Managed full development and deployment lifecycle of Zidcash e-wallet app",
          "Improved code efficiency by 30% through optimizing reusable Flutter widgets",
          "Delivered significant UI/UX improvements for four major applications",
          "Applied clean architecture and Bloc pattern within Agile team (Azure DevOps)"
        ],
        technologies: [
          "Flutter",
          "Dart",
          "Bloc",
          "Firebase",
          "Azure DevOps",
          "REST APIs"
        ],
        color: "#0553B1"),
    Experience(
        period: "December 2023 - May 2024",
        role: "Flutter Developer",
        company: "Tsquare",
        location: "Alexandria, Egypt",
        type: "Full-time",
        description: [
          "Developed Hadrmout Hamza multivendor restaurant web application (10+ vendors)",
          "Refactored complex UI components, reducing code duplication by 40%",
          "Translated Figma/Adobe XD designs into pixel-perfect responsive layouts",
          "Optimized application performance and improved load times"
        ],
        technologies: ["Flutter", "Dart", "REST APIs", "Figma", "Adobe XD"],
        color: "#02569B"),
    Experience(
        period: "July 2023 - November 2023",
        role: "Flutter Intern",
        company: "Al Almiya Al Hura",
        location: "Mansoura, Daqahliyah",
        type: "Internship",
        description: [
          "🏆 Secured 1st place among 15+ peers for top-performing applications",
          "Built Thimar and Thimar Delivery e-commerce apps with integrated APIs",
          "Applied clean architecture principles and MVVM pattern",
          "Implemented responsive design for 20+ device sizes"
        ],
        technologies: [
          "Flutter",
          "Dart",
          "MVVM",
          "REST APIs",
          "Clean Architecture"
        ],
        color: "#13B9FD"),
    Experience(
        period: "February 2023 - June 2023",
        role: "Flutter Intern",
        company: "RMS 4 Design",
        location: "Giza, Cairo",
        type: "Internship",
        description: [
          "Developed 3+ cross-platform applications with Firebase integration",
          "Implemented Google Maps services and location features",
          "Built strong foundation in Dart programming and architectural patterns",
          "Learned industry standards for clean code and project structure"
        ],
        technologies: ["Flutter", "Dart", "Firebase", "Google Maps"],
        color: "#667EEA")
  ];

  static const List<SkillCategory> skills = [
    SkillCategory(title: "Mobile Development", icon: "smartphone", skills: [
      Skill(name: "Flutter", level: 95, icon: "flutter"),
      Skill(name: "Dart", level: 95, icon: "dart"),
      Skill(name: "Bloc & Cubit", level: 90, icon: "bloc"),
      Skill(name: "Responsive UI", level: 90, icon: "responsive"),
      Skill(name: "Animations", level: 85, icon: "animation"),
      Skill(name: "Localization", level: 85, icon: "language"),
      Skill(name: "GetIt (DI)", level: 85, icon: "injection")
    ]),
    SkillCategory(
        title: "Architecture & Patterns",
        icon: "architecture",
        skills: [
          Skill(name: "Clean Architecture", level: 90, icon: "clean"),
          Skill(name: "MVVM", level: 88, icon: "mvvm"),
          Skill(name: "Modular Architecture", level: 85, icon: "modular"),
          Skill(name: "SOLID Principles", level: 85, icon: "solid")
        ]),
    SkillCategory(title: "Backend & Integration", icon: "cloud", skills: [
      Skill(name: "RESTful APIs", level: 92, icon: "api"),
      Skill(name: "Firebase", level: 88, icon: "firebase"),
      Skill(name: "Google Maps", level: 85, icon: "maps"),
      Skill(name: "Payment Gateways", level: 80, icon: "payment"),
      Skill(name: "Push Notifications", level: 85, icon: "notification"),
      Skill(name: "Local Storage", level: 88, icon: "storage")
    ]),
    SkillCategory(title: "DevOps & Tools", icon: "tools", skills: [
      Skill(name: "Git & GitHub", level: 90, icon: "git"),
      Skill(name: "Azure DevOps", level: 85, icon: "azure"),
      Skill(name: "CI/CD", level: 80, icon: "cicd"),
      Skill(name: "Fastlane", level: 78, icon: "fastlane"),
      Skill(name: "App Store Publishing", level: 90, icon: "appstore"),
      Skill(name: "Play Store Publishing", level: 92, icon: "playstore")
    ])
  ];

  static const List<Project> projects = [
    Project(
        id: 1,
        title: "Zidcash",
        subtitle: "E-Wallet Application",
        category: "Fintech",
        description:
            "Built secure digital wallet app with deposit, withdrawal, and money transfer features",
        longDescription: """
A comprehensive e-wallet solution providing secure financial transactions. 
Features include:
• Secure deposit and withdrawal system
• Peer-to-peer money transfers
• Real-time balance tracking
• Complete transaction history
• Advanced security with authentication
• Integrated account management
      """,
        technologies: ["Flutter", "Dart", "REST APIs", "Bloc"],
        features: [
          "Secure Authentication",
          "Real-time Balance",
          "Money Transfers",
          "Transaction History",
          "Account Management"
        ],
        image: "assets/projects/zidcash.png",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.zidCach.app",
        appStoreUrl: null,
        color: "#4CAF50",
        featured: true),
    Project(
        id: 2,
        title: "UFOO Driver",
        subtitle: "Ride-Hailing Driver App",
        category: "Transportation",
        description:
            "Professional ride-hailing app for drivers in Saudi Arabia with smart ride management",
        longDescription: """
A complete ride-hailing solution for drivers operating in Saudi Arabia.
Features include:
• Smart ride management system
• Interactive map interface with Google Maps
• Real-time ride tracking
• Transparent earnings dashboard
• Secure in-app communication with riders
• Seamless onboarding flow
• Profile management
      """,
        technologies: [
          "Flutter",
          "Dart",
          "Google Maps",
          "Firebase",
          "REST APIs"
        ],
        features: [
          "Smart Ride Management",
          "Interactive Maps",
          "Earnings Dashboard",
          "Rider Communication",
          "Profile Management"
        ],
        image: "assets/projects/ufoo_driver.png",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.ufoDriver.app",
        appStoreUrl: "https://apps.apple.com/eg/app/id6748874649",
        color: "#2196F3",
        featured: true),
    Project(
        id: 3,
        title: "Gebal Alrwasay",
        subtitle: "Transportation Service App",
        category: "Transportation",
        description:
            "Transportation service app for Hajj season in Saudi Arabia with real-time tracking",
        longDescription: """
Specialized transportation app designed for Hajj season operations.
Features include:
• Worker request creation
• Real-time tracking system
• Multilingual support (Arabic/English)
• Efficient route management
• Service scheduling
      """,
        technologies: ["Flutter", "Dart", "Firebase", "REST APIs"],
        features: [
          "Request Management",
          "Real-time Tracking",
          "Multilingual (AR/EN)",
          "Route Management"
        ],
        image: "assets/projects/gebal.png",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=sa.gebalAlrwasay.app",
        appStoreUrl: "https://apps.apple.com/eg/app/id6744922960",
        color: "#9C27B0",
        featured: false),
    Project(
        id: 4,
        title: "P2P Syria",
        subtitle: "Financial Management Platform",
        category: "Fintech",
        description:
            "Multilingual financial platform supporting multiple currencies with secure transactions",
        longDescription: """
A robust financial management platform for the Syrian market.
Features include:
• Multi-currency support
• Secure real-time transactions
• Transfers, withdrawals, and deposits
• Country-specific transfer methods
• User authentication and security
• Multilingual interface
      """,
        technologies: ["Flutter", "Dart", "Firebase", "REST APIs", "Bloc"],
        features: [
          "Multi-Currency",
          "Secure Transactions",
          "Multiple Transfer Methods",
          "Multilingual Support"
        ],
        image: "assets/projects/p2p_syria.png",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=com.p2psyria.app",
        appStoreUrl: null,
        color: "#FF5722",
        featured: true),
    Project(
        id: 5,
        title: "Lirat Wallet",
        subtitle: "Fintech E-Wallet Application",
        category: "Fintech",
        description:
            "E-wallet with multi-currency transaction support and advanced security protocols",
        longDescription: """
Modern e-wallet solution with comprehensive financial features.
Features include:
• Multi-currency transaction support
• Advanced security protocols
• User-friendly interface
• Multilingual support
• Secure authentication
      """,
        technologies: ["Flutter", "Dart", "Firebase", "REST APIs"],
        features: [
          "Multi-Currency",
          "Advanced Security",
          "User-Friendly UI",
          "Multilingual"
        ],
        image: "assets/projects/lirat.png",
        playStoreUrl:
            "https://play.google.com/store/apps/details?id=store.lirat.paymoney",
        appStoreUrl: null,
        color: "#00BCD4",
        featured: false)
  ];

  static const education = Education(
      degree: "Bachelor of Communications and Electronics Engineering",
      institution: "Nile Higher Institute for Engineering and Technology",
      accreditation: "ABET Accredited",
      period: "2017 - 2022",
      location: "Mansoura, Daqahliyah",
      gpa: "2.81 / 4.0",
      graduationProject: GraduationProject(
          title: "Biometric Lock System",
          grade: "A+",
          description:
              "Advanced lock system using fingerprint and facial recognition technologies",
          technologies: [
            "Embedded Systems",
            "Fingerprint Recognition",
            "Facial Recognition",
            "IoT"
          ]),
      highlights: [
        "ABET Accredited Program",
        "A+ Graduation Project",
        "Specialized in Communications & Electronics"
      ]);

  static const List<Achievement> achievements = [
    Achievement(
        icon: "trophy",
        title: "1st Place - Internship Competition",
        description:
            "Ranked 1st among 15+ peers at Al Almiya Al Hura for developing top-performing applications",
        year: "2023"),
    Achievement(
        icon: "star",
        title: "A+ Graduation Project",
        description:
            "Developed Biometric Lock System using fingerprint and facial recognition",
        year: "2022"),
    Achievement(
        icon: "rocket",
        title: "5+ Published Apps",
        description:
            "Successfully published apps on both App Store and Play Store",
        year: "2024"),
    Achievement(
        icon: "code",
        title: "30% Code Efficiency Improvement",
        description: "Optimized reusable Flutter widgets at Geexar",
        year: "2024"),
    Achievement(
        icon: "clean",
        title: "40% Code Duplication Reduction",
        description: "Refactored complex UI components at Tsquare",
        year: "2024")
  ];

  static const contactInfo = ContactInfo(
      title: "Let's Work Together",
      subtitle: "Have a project in mind? Let's discuss!",
      email: "ahmed.elghareeb1166@gmail.com",
      phone: "+201064503827",
      whatsapp: "+201064503827",
      location: "Mansoura, Ad Daqahliya, Egypt",
      availability: "Available for freelance & full-time opportunities",
      formFields: ["Name", "Email", "Subject", "Message"],
      socialLinks: SocialLinks(
          github: "https://github.com/AhmedAElghareeb",
          linkedin: "https://www.linkedin.com/in/ahmed-elghareeb8/",
          whatsapp: "https://wa.me/201064503827"));
}
