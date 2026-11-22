import 'models/portfolio_models.dart';

abstract final class PortfolioData {
  static const name = 'Ahmed Ashraf Elghareeb';
  static const email = 'ahmed.elghareeb1166@gmail.com';
  static const github = 'https://github.com/AhmedAElghareeb';
  static const linkedin = 'https://www.linkedin.com/in/ahmed-elghareeb8/';

  static const stats = [
    ('3+', 'Years of Flutter experience'),
    ('12+', 'Cross-platform apps delivered'),
    ('9+', 'Flutter apps shipped at Geexar'),
  ];

  static const experiences = [
    Experience('Geexar', 'Mid-Level Mobile Developer', 'July 2024 – Present', [
      'Architected and shipped 9+ Flutter apps for Android and iOS, from scoping through store deployment.',
      'Led development of Zidcash, including deposits, withdrawals, live balances, and Visa card integration.',
      'Used Clean Architecture and BLoC/Cubit across the mobile team and integrated REST APIs, Firebase, maps, and payments.',
    ]),
    Experience('Tsquare', 'Flutter Developer', 'December 2023 – May 2024', [
      'Developed Hadramout Hamza, a multivendor restaurant platform with live order management for 10+ vendors.',
      'Built reusable Flutter widgets across vendor modules and translated Figma and Adobe XD designs into responsive interfaces.',
    ]),
    Experience('Freelance', 'Mobile Developer', 'November 2023 – Present', [
      'Independently delivered 3+ production-ready Flutter apps, from architecture to store release.',
      'Built Direct Chatting and Quran Kareem and managed requirements and feedback with clients.',
    ]),
    Experience('Al Almiya Al Hura', 'Flutter Intern', 'July 2023 – November 2023', [
      'Ranked first among 15+ trainees.',
      'Built Thimar and Thimar Delivery with REST APIs, BLoC, and responsive UI.',
      'Participated in code reviews and learned Clean Architecture with senior developers.',
    ]),
  ];

  static const skills = [
    SkillCategory(
      'Mobile Engineering',
      'Cross-platform interfaces for Android and iOS.',
      ['Flutter', 'Dart', 'Responsive UI', 'Localization', 'Animation'],
    ),
    SkillCategory(
      'Architecture & State Management',
      'Feature boundaries and predictable app state.',
      [
        'Clean Architecture',
        'Modular Architecture',
        'MVVM',
        'BLoC & Cubit',
        'SOLID',
        'GetIt',
      ],
    ),
    SkillCategory(
      'Backend & Integrations',
      'Product flows that connect to real services.',
      [
        'REST APIs · Dio',
        'Firebase · FCM',
        'Google Maps',
        'Payment gateways',
        'Local storage',
        'Social authentication',
      ],
    ),
    SkillCategory(
      'DevOps & Delivery',
      'From code review to mobile store releases.',
      ['Git & GitHub', 'Azure DevOps', 'App Store', 'Google Play'],
    ),
  ];

  static const zidcash = Project(
    title: 'Zidcash',
    category: 'Fintech',
    description:
        'A digital wallet for deposits, withdrawals, money transfers, and virtual card payments.',
    contribution:
        'Led development from deposit and withdrawal flows through real-time balances and Visa card integration.',
    technologies: [
      'Flutter',
      'Dart',
      'BLoC',
      'REST APIs',
      'Push notifications',
    ],
    features: [
      'Fund a wallet and transfer money between accounts.',
      'Review live balances and transaction history.',
      'Manage virtual cards for online payments.',
    ],
    image: 'assets/projects/zidcash.png',
    screenshots: [
      'assets/projects/screens/zidcash.webp',
      'assets/projects/screens/zidcash-card.webp',
    ],
    links: [
      ProjectLink(
        'Google Play',
        'https://play.google.com/store/apps/details?id=com.zidCach.app',
      ),
    ],
  );

  static const ufoo = Project(
    title: 'UFOO',
    category: 'Ride-Hailing',
    description:
        'Customer and driver apps for booking, accepting, and managing rides in Saudi Arabia.',
    contribution:
        'Developed both apps and implemented map-based destinations, OTP sign-in, localization, trip history, and notifications.',
    technologies: [
      'Flutter',
      'Dart',
      'BLoC/Cubit',
      'Google Maps',
      'Firebase',
      'REST APIs',
    ],
    features: [
      'Customers choose a destination, book a trip, and track their driver.',
      'Drivers manage availability, respond to nearby ride requests, and navigate trips.',
    ],
    image: 'assets/projects/ufoo_driver.png',
    screenshots: [
      'assets/projects/screens/ufoo.webp',
      'assets/projects/screens/ufoo-map.webp',
    ],
    links: [
      ProjectLink(
        'Customer · Google Play',
        'https://play.google.com/store/apps/details?id=com.ufoClient.app',
      ),
      ProjectLink(
        'Customer · App Store',
        'https://apps.apple.com/eg/app/ufoo/id6748603810',
      ),
      ProjectLink(
        'Driver · Google Play',
        'https://play.google.com/store/apps/details?id=com.ufoDriver.app',
      ),
      ProjectLink(
        'Driver · App Store',
        'https://apps.apple.com/eg/app/ufoo-driver/id6748874649',
      ),
    ],
  );

  static const geta = Project(
    title: 'Geta',
    category: 'Logistics',
    description:
        'A customer and driver platform for booking freight, quoting shipments, and tracking deliveries.',
    contribution:
        'Developed both apps and integrated shipment pricing, live route tracking, maps, and status notifications.',
    technologies: [
      'Flutter',
      'Dart',
      'BLoC/Cubit',
      'Google Maps',
      'Firebase',
      'REST APIs',
    ],
    features: [
      'Customers choose pickup and delivery locations, request a quote, and track a shipment.',
      'Drivers manage assigned deliveries and update shipment statuses.',
    ],
    screenshots: ['assets/projects/screens/geta.jpg'],
    links: [
      ProjectLink(
        'Customer · Google Play',
        'https://play.google.com/store/apps/details?id=com.geexar.getauser',
      ),
      ProjectLink(
        'Customer · App Store',
        'https://apps.apple.com/om/app/geta-user/id6752566292',
      ),
      ProjectLink(
        'Driver · Google Play',
        'https://play.google.com/store/apps/details?id=com.geexar.getadriver',
      ),
      ProjectLink(
        'Driver · App Store',
        'https://apps.apple.com/us/app/g-driver/id6788644426',
      ),
    ],
  );

  static const p2p = Project(
    title: 'P2P Syria',
    category: 'Fintech',
    description:
        'A multilingual financial platform for electronic currency deposits, withdrawals, and transfers.',
    contribution:
        'Implemented authentication, peer-to-peer transfers, live balance tracking, and transaction history.',
    technologies: ['Flutter', 'Dart', 'Firebase', 'BLoC', 'REST APIs'],
    features: [
      'Manage electronic currency balances and review account activity.',
      'Transfer funds to other registered users.',
    ],
    image: 'assets/projects/p2p_syria.png',
    screenshots: ['assets/projects/screens/p2p.webp'],
  );

  static const coreTeam = Project(
    title: 'Core Team – SmartHub',
    category: 'Education',
    description:
        'A staff app for organizing classes, attendance, assignments, exams, and academic reporting.',
    technologies: ['Flutter', 'Dart'],
    features: [
      'Manage student groups, sessions, attendance, and submissions.',
      'Coordinate teaching assistants and review academic reports.',
    ],
    screenshots: ['assets/projects/screens/core-team.jpg'],
    links: [
      ProjectLink(
        'Google Play',
        'https://play.google.com/store/apps/details?id=com.hkteam.teacher',
      ),
      ProjectLink(
        'App Store',
        'https://apps.apple.com/us/app/core-team-smarthub/id6812734640',
      ),
    ],
  );

  static const gebal = Project(
    title: 'Gebal Alrwasay',
    category: 'Transportation',
    description:
        'A bilingual app for coordinating worker transport during the Hajj season.',
    contribution:
        'Built the app and implemented transport requests, live tracking, and Arabic and English support.',
    technologies: ['Flutter', 'Dart', 'Firebase', 'REST APIs', 'Localization'],
    features: [
      'Create transport requests with pickup and destination details.',
      'Follow request status and expected arrival.',
    ],
    image: 'assets/projects/gebal.png',
    links: [
      ProjectLink(
        'Google Play',
        'https://play.google.com/store/apps/details?id=sa.gebalAlrwasay.app',
      ),
      ProjectLink('App Store', 'https://apps.apple.com/eg/app/id6744922960'),
    ],
  );

  static const featured = [zidcash, ufoo, geta, coreTeam, p2p, gebal];

  static const projects = [
    coreTeam,
    Project(
      title: 'Hussein Khaled',
      category: 'Education',
      description:
          'A learning app for students and parents with course materials, exams, assignments, and progress tracking.',
      technologies: ['Flutter', 'Dart'],
      links: [
        ProjectLink(
          'Google Play',
          'https://play.google.com/store/apps/details?id=com.hkteam.student',
        ),
        ProjectLink(
          'App Store',
          'https://apps.apple.com/us/app/hussein-khaled/id6812695424',
        ),
      ],
    ),
    zidcash,
    Project(
      title: 'Lirat Wallet',
      category: 'Fintech',
      description:
          'A wallet for deposits, withdrawals, online payments, digital cards, and tracking transactions.',
      contribution:
          'Developed wallet flows for funding, card requests, and digital purchases.',
      technologies: [
        'Flutter',
        'Dart',
        'Firebase',
        'REST APIs',
        'Social authentication',
      ],
      image: 'assets/projects/lirat.png',
    ),
    p2p,
    Project(
      title: 'Card App',
      category: 'Fintech',
      description:
          'An app for virtual cards, digital payments, transfers, and transaction history.',
      technologies: [
        'Flutter',
        'Dart',
        'Clean Architecture',
        'BLoC/Cubit',
        'REST APIs',
      ],
    ),
    geta,
    ufoo,
    gebal,
    Project(
      title: 'Benaa',
      category: 'E-commerce',
      description:
          'A building materials marketplace that connects product discovery, quotation requests, checkout, and order tracking.',
      technologies: [
        'Flutter',
        'Dart',
        'BLoC/Cubit',
        'REST APIs',
        'Google Maps',
      ],
      links: [
        ProjectLink(
          'Project overview',
          'https://geexar.com/ar/portfolio/%D8%A8%D9%86%D8%A7%D8%A1/',
        ),
      ],
    ),
    Project(
      title: 'Hadramout Hamza',
      category: 'E-commerce',
      description:
          'A responsive Flutter web platform for browsing restaurant vendors, viewing menus, and managing orders.',
      contribution:
          'Built reusable interfaces across vendor modules for a platform supporting 10+ vendors.',
      technologies: ['Flutter Web', 'Dart', 'REST APIs', 'Responsive UI'],
    ),
    Project(
      title: 'Quran Kareem',
      category: 'Utilities',
      description:
          'A Quran reading app with chapter browsing and saved reading preferences.',
      contribution: 'Built independently as a freelance project.',
      technologies: ['Flutter', 'Dart', 'Local storage'],
    ),
    Project(
      title: 'Direct Chatting',
      category: 'Utilities',
      description:
          'A utility for opening a WhatsApp conversation without saving a contact.',
      contribution: 'Built independently as a freelance project.',
      technologies: ['Flutter', 'Dart', 'Deep linking', 'URL Launcher'],
    ),
    Project(
      title: 'Thimar',
      category: 'E-commerce',
      description:
          'A grocery shopping app for browsing products, managing a cart, and placing orders.',
      contribution: 'Built during the Al Almiya Al Hura internship.',
      technologies: ['Flutter', 'Dart', 'BLoC', 'REST APIs', 'Responsive UI'],
      links: [
        ProjectLink(
          'Source code',
          'https://github.com/AhmedAElghareeb/Thimar_app',
        ),
      ],
    ),
    Project(
      title: 'Thimar Delivery',
      category: 'E-commerce',
      description:
          'A driver app for receiving grocery deliveries, updating order status, and reviewing completed work.',
      contribution: 'Built during the Al Almiya Al Hura internship.',
      technologies: ['Flutter', 'Dart', 'BLoC', 'REST APIs', 'Responsive UI'],
      links: [
        ProjectLink(
          'Source code',
          'https://github.com/AhmedAElghareeb/Thimar_Driver',
        ),
      ],
    ),
  ];
}
