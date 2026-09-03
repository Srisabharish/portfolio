// ============================================================================
// PORTFOLIO DATA CONFIGURATION
// ============================================================================
// THIS IS THE ONLY FILE YOU NEED TO EDIT TO UPDATE YOUR PORTFOLIO!
//
// 1. To update your name, bio, email, or phone: Edit `personal` below.
// 2. To add a new project: Scroll down to `projects` and copy-paste an item.
// 3. To update skills: Scroll to `skills` and add/edit tags.
// 4. To update education or certifications: Edit the respective lists.
// ============================================================================

import 'package:flutter/material.dart';

class PortfolioData {
  // ==========================================================================
  // 1. PERSONAL INFORMATION & HERO DETAILS
  // ==========================================================================
  static final PersonalInfo personal = PersonalInfo(
    fullName: "Sri Sabharish S",
    role: "Flutter Developer",
    secondaryRole: "Cross-Platform Mobile and Web Specialist",
    statusBadge: "Available for Opportunities",
    isAvailableForWork: true,
    
    // Tagline and elevator pitch (from your resume)
    headline: "CRAFTING MODERN, HIGH-PERFORMANCE FLUTTER EXPERIENCES",
    bioIntro:
        "Dedicated and detail-oriented Flutter Developer with a passion for building intuitive, visually appealing, and high-performance cross-platform Mobile and Web applications.",
    bioExtended:
        "Specialized in Flutter, Dart, Firebase, and REST API architectures. Experienced in building responsive UIs, clean state management, real-time data sync, and scalable backend integrations. Enthusiastic about creating seamless digital products that solve real-world problems.",

    // Contact Information
    email: "srisabharish1580@gmail.com",
    phone: "+91 9092657668",
    location: "Chennai, Tamil Nadu, India",
    
    // Resume Link (can be a Google Drive link, GitHub link, or relative file)
    resumeUrl: "https://github.com/srisabharish",

    // Profile Images (both user uploaded photos saved in assets/images/)
    heroPhoto: "assets/images/profile_seated.jpg",
    aboutPhoto: "assets/images/profile_portrait.jpg",

    // Social Links
    socials: [
      SocialLink(
        name: "GitHub",
        url: "https://github.com/srisabharish",
        iconName: "github",
        displayHandle: "github.com/srisabharish",
      ),
      SocialLink(
        name: "LinkedIn",
        url: "https://linkedin.com/in/sri-sabharish",
        iconName: "linkedin",
        displayHandle: "linkedin.com/in/sri-sabharish",
      ),
      SocialLink(
        name: "Email",
        url: "mailto:srisabharish1580@gmail.com",
        iconName: "envelope",
        displayHandle: "srisabharish1580@gmail.com",
      ),
      SocialLink(
        name: "Phone",
        url: "tel:+919092657668",
        iconName: "phone",
        displayHandle: "+91 9092657668",
      ),
    ],

    // Quick Stats Bar
    stats: [
      StatItem(value: "5+", label: "Projects Built"),
      StatItem(value: "100%", label: "Cross-Platform"),
      StatItem(value: "2024", label: "B.E. Graduate"),
      StatItem(value: "7.53", label: "CGPA Score"),
    ],
  );

  // ==========================================================================
  // 2. SELECTED PROJECTS (WORK)
  // ==========================================================================
  // TO ADD A NEW PROJECT:
  // Copy one of the ProjectItem blocks below, paste it into this list,
  // and fill in your project's details!
  // ==========================================================================
  static final List<ProjectItem> projects = [
    ProjectItem(
      id: "01",
      title: "Car Rental Application",
      category: "Mobile App - Flutter and Firebase",
      subtitle: "On-demand vehicle rental platform with real-time tracking",
      description:
          "A comprehensive cross-platform vehicle rental application built with Flutter, Firebase, and REST APIs. Features seamless car discovery, dynamic booking schedules, real-time vehicle availability, and location-aware services.",
      highlights: [
        "Built responsive UI with gradient backgrounds and smooth micro-animations",
        "Integrated REST APIs to fetch real-time fleet, pricing, and reservation data",
        "Integrated Firebase Authentication, Cloud Firestore, and real-time database",
        "Implemented geolocation and location-based car search with interactive map views",
        "Handled asynchronous states, caching, and error resilience using FutureBuilder and async/await",
      ],
      technologies: ["Flutter", "Dart", "Firebase", "REST API", "Geolocation"],
      githubUrl: "https://github.com/srisabharish",
      liveDemoUrl: "",
      accentColor: Color(0xFF6366F1), // Electric Indigo
      year: "2024",
      isFeatured: true,
    ),

    ProjectItem(
      id: "02",
      title: "Real-Time Weather App",
      category: "Mobile and Web - API Integration",
      subtitle: "Live atmospheric forecasts and dynamic environmental conditions",
      description:
          "A slick weather forecasting app delivering accurate current conditions, 7-day atmospheric forecasts, wind velocity, humidity, and UV metrics with dynamic weather-reactive gradient backgrounds.",
      highlights: [
        "Connected OpenWeather REST API with robust JSON parsing and error handling",
        "Implemented automatic GPS-based geolocation and global multi-city search",
        "Crafted adaptive glassmorphic UI with animated weather condition indicators",
        "Optimized network requests with caching to deliver instant load times",
      ],
      technologies: ["Flutter", "Dart", "REST API", "Geolocation", "FutureBuilder"],
      githubUrl: "https://github.com/srisabharish",
      liveDemoUrl: "",
      accentColor: Color(0xFF38BDF8), // Sky Blue
      year: "2024",
      isFeatured: true,
    ),

    ProjectItem(
      id: "03",
      title: "Movie Collection and Streaming Guide",
      category: "Mobile App - Media Discovery",
      subtitle: "Curated cinematic experience with responsive grid and details",
      description:
          "A modern entertainment discovery application featuring trending movies, detailed synopses, cast directories, high-resolution posters, and personal watchlist curation.",
      highlights: [
        "Developed responsive grid and list layouts with smooth scroll performance",
        "Implemented efficient local asset management alongside cached network images",
        "Integrated search filtering by genre, rating, release year, and actor",
        "Designed clean transitions between browsing feed and immersive movie details",
      ],
      technologies: ["Flutter", "Dart", "Local Assets", "Responsive Grid", "UI/UX"],
      githubUrl: "https://github.com/srisabharish",
      liveDemoUrl: "",
      accentColor: Color(0xFFA855F7), // Purple
      year: "2024",
      isFeatured: true,
    ),

    ProjectItem(
      id: "04",
      title: "Smart Expression Calculator",
      category: "Utility - Flutter and Dart",
      subtitle: "Intuitive arithmetic and mathematical evaluation engine",
      description:
          "An elegant calculator utility designed with clean visual hierarchy, tactile haptic feedback simulation, and real-time expression parsing for arithmetic operations.",
      highlights: [
        "Designed clean button layout using responsive GridView and custom TextButton widgets",
        "Implemented real-time mathematical expression evaluation with error guards",
        "Created an intuitive history log for past calculations",
        "Smooth dark theme transitions conforming to modern design standards",
      ],
      technologies: ["Flutter", "Dart", "GridView", "Algorithmic Logic"],
      githubUrl: "https://github.com/srisabharish",
      liveDemoUrl: "",
      accentColor: Color(0xFF10B981), // Emerald
      year: "2023",
      isFeatured: false,
    ),

    ProjectItem(
      id: "05",
      title: "Personal Portfolio Website",
      category: "Frontend Web - Modern Stack",
      subtitle: "High-contrast developer showcase with interactive sections",
      description:
          "A sleek personal developer portfolio highlighting technical skills, engineering projects, and certifications with responsive navigation and smooth interactive sections.",
      highlights: [
        "Developed fully responsive layouts compatible across all screen sizes",
        "Implemented interactive modern navigation bar and engaging card UI",
        "Showcased front-end design mastery and clean modular architecture",
      ],
      technologies: ["HTML5", "CSS3", "JavaScript", "Bootstrap", "Responsive Design"],
      githubUrl: "https://github.com/srisabharish",
      liveDemoUrl: "",
      accentColor: Color(0xFFF59E0B), // Amber
      year: "2023",
      isFeatured: false,
    ),
  ];

  // ==========================================================================
  // 3. DEVELOPMENT PROCESS (The Olio Midnight 6-Step Workflow)
  // ==========================================================================
  static final List<ProcessStep> processSteps = [
    ProcessStep(
      number: "01",
      title: "Discovery and Architecture",
      description:
          "Understanding requirements, user journeys, data flow, and choosing the optimal architecture, state management, and project structure.",
    ),
    ProcessStep(
      number: "02",
      title: "UI/UX and Responsive Layout",
      description:
          "Translating wireframes into pixel-perfect Flutter widget trees with fluid responsiveness for mobile, tablet, desktop, and web.",
    ),
    ProcessStep(
      number: "03",
      title: "State Management and Logic",
      description:
          "Implementing clean business logic with predictable state flows, reusable service providers, and modular separation of concerns.",
    ),
    ProcessStep(
      number: "04",
      title: "Backend and API Integration",
      description:
          "Connecting Firebase services, RESTful endpoints, SQL databases, authentication flows, and real-time asynchronous data streams.",
    ),
    ProcessStep(
      number: "05",
      title: "Testing, Polish and Performance",
      description:
          "Rigorous UI testing, frame-rate profiling (60/120fps), memory leak checks, error boundary handling, and subtle micro-interactions.",
    ),
    ProcessStep(
      number: "06",
      title: "Build, Deployment and Release",
      description:
          "Compiling optimized release bundles, configuring platform permissions, CI/CD automated builds, and deploying to Play Store, App Store, or Web.",
    ),
  ];

  // ==========================================================================
  // 4. TECHNICAL SKILLS & EXPERTISE
  // ==========================================================================
  static final List<SkillCategory> skillCategories = [
    SkillCategory(
      categoryName: "Languages",
      skills: ["Dart", "Java", "JavaScript", "HTML5", "CSS3", "SQL"],
    ),
    SkillCategory(
      categoryName: "Frameworks and Mobile",
      skills: ["Flutter (Mobile and Web)", "Bootstrap", "Material 3", "Cupertino Widgets"],
    ),
    SkillCategory(
      categoryName: "Backend and Databases",
      skills: ["Firebase Auth", "Cloud Firestore", "Firebase Storage", "MySQL", "REST APIs"],
    ),
    SkillCategory(
      categoryName: "Core Concepts and Tools",
      skills: [
        "OOP (Object-Oriented Programming)",
        "State Management",
        "Responsive UI Layouts",
        "FutureBuilder and async/await",
        "Git and GitHub",
        "Agile Methodology",
        "Deep Learning Basics",
        "Image Processing",
      ],
    ),
  ];

  // ==========================================================================
  // 5. EDUCATION
  // ==========================================================================
  static final List<EducationItem> education = [
    EducationItem(
      degree: "Bachelor of Electronics and Communication Engineering",
      institution: "KSR College of Engineering",
      location: "Thiruchengode, Tamil Nadu",
      period: "Graduated April 2024",
      grade: "CGPA: 7.53 / 10.00",
      description:
          "Strong foundation in core computing, digital communication, microcontrollers, object-oriented programming, and software engineering principles.",
    ),
  ];

  // ==========================================================================
  // 6. CERTIFICATIONS
  // ==========================================================================
  static final List<CertificationItem> certifications = [
    CertificationItem(
      title: "Flutter and Dart App Development",
      organization: "Greens Technologies",
      date: "May 2025",
      description:
          "Certified in building cross-platform production Flutter applications with state management, Firebase, and REST API integration.",
    ),
    CertificationItem(
      title: "MATLAB System and Signal Processing",
      organization: "Pantech e-Learning Platform",
      date: "Certified",
      description:
          "Comprehensive course on MATLAB algorithm design, matrix mathematics, and computational modeling.",
    ),
    CertificationItem(
      title: "UiPath Robotic Process Automation (RPA)",
      organization: "KSR College of Engineering",
      date: "Feb 16, 2023",
      description:
          "Design and development of intelligent software bots and automated business process workflows.",
    ),
    CertificationItem(
      title: "Foundation Course on Core JAVA",
      organization: "KSR College of Engineering",
      date: "Aug 5, 2022",
      description:
          "In-depth mastery of Object-Oriented Programming, Java collections framework, exception handling, and multi-threading.",
    ),
  ];
}

// ============================================================================
// DATA MODELS
// ============================================================================

class PersonalInfo {
  final String fullName;
  final String role;
  final String secondaryRole;
  final String statusBadge;
  final bool isAvailableForWork;
  final String headline;
  final String bioIntro;
  final String bioExtended;
  final String email;
  final String phone;
  final String location;
  final String resumeUrl;
  final String heroPhoto;
  final String aboutPhoto;
  final List<SocialLink> socials;
  final List<StatItem> stats;

  const PersonalInfo({
    required this.fullName,
    required this.role,
    required this.secondaryRole,
    required this.statusBadge,
    required this.isAvailableForWork,
    required this.headline,
    required this.bioIntro,
    required this.bioExtended,
    required this.email,
    required this.phone,
    required this.location,
    required this.resumeUrl,
    required this.heroPhoto,
    required this.aboutPhoto,
    required this.socials,
    required this.stats,
  });
}

class SocialLink {
  final String name;
  final String url;
  final String iconName;
  final String displayHandle;

  const SocialLink({
    required this.name,
    required this.url,
    required this.iconName,
    required this.displayHandle,
  });
}

class StatItem {
  final String value;
  final String label;

  const StatItem({required this.value, required this.label});
}

class ProjectItem {
  final String id;
  final String title;
  final String category;
  final String subtitle;
  final String description;
  final List<String> highlights;
  final List<String> technologies;
  final String githubUrl;
  final String liveDemoUrl;
  final Color accentColor;
  final String year;
  final bool isFeatured;

  const ProjectItem({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.description,
    required this.highlights,
    required this.technologies,
    required this.githubUrl,
    required this.liveDemoUrl,
    required this.accentColor,
    required this.year,
    required this.isFeatured,
  });
}

class ProcessStep {
  final String number;
  final String title;
  final String description;

  const ProcessStep({
    required this.number,
    required this.title,
    required this.description,
  });
}

class SkillCategory {
  final String categoryName;
  final List<String> skills;

  const SkillCategory({
    required this.categoryName,
    required this.skills,
  });
}

class EducationItem {
  final String degree;
  final String institution;
  final String location;
  final String period;
  final String grade;
  final String description;

  const EducationItem({
    required this.degree,
    required this.institution,
    required this.location,
    required this.period,
    required this.grade,
    required this.description,
  });
}

class CertificationItem {
  final String title;
  final String organization;
  final String date;
  final String description;

  const CertificationItem({
    required this.title,
    required this.organization,
    required this.date,
    required this.description,
  });
}
