# 📘 How to Edit Your Portfolio (Quick & Easy Guide)

Welcome to your portfolio! Everything on your website is controlled by **one single file**:
📁 **lib/portfolio_data.dart**

You do **NOT** need to touch any UI code, layout widgets, or design files. Just edit lib/portfolio_data.dart, save, and your website updates automatically.

---

## 1. 🚀 How to Add a New Project

1. Open lib/portfolio_data.dart.
2. Scroll to the projects section (around line 90).
3. Copy this template, paste it into the projects list, and fill in your details:

`dart
ProjectItem(
  id: 06, // Project number (e.g. 06, 07, ...)
  title: Your Project Name,
  category: Mobile App • Flutter,
  subtitle: One sentence summary of what your project does,
  description:
      A more detailed description of what the project accomplishes, the problems it solves, and how you built it.,
  highlights: [
    Key feature or achievement 1,
    Key feature or achievement 2,
    Used Provider / BLoC for clean state management,
    Integrated REST API or Firebase,
  ],
  technologies: [Flutter, Dart, Firebase, REST API],
  githubUrl: https://github.com/srisabharish/your-repo-name,
  liveDemoUrl: https://your-demo-url.com, // Or leave empty "
 accentColor: Color(0xFF6366F1), // Custom accent color
 year: 2025,
 isFeatured: true,
),
`

4. Save the file. That's it! Your new project will appear on the site with full styling, hover glow effects, tags, and links.

---

## 2. 👤 How to Change Your Personal Info (Bio, Email, Phone, Socials)

In lib/portfolio_data.dart, find the personal section at the top:

- **Name**: Change ullName: Sri Sabharish S
- **Role / Title**: Change ole: Flutter Developer
- **Email**: Change email: srisabharish1580@gmail.com
- **Phone**: Change phone: +91 9092657668
- **Location**: Change location: Chennai, Tamil Nadu, India
- **Resume URL**: Change esumeUrl: https://... (paste your Google Drive or GitHub resume link)
- **Availability Status**: Set isAvailableForWork: true or alse

---

## 3. 🛠️ How to Add or Change Skills

In lib/portfolio_data.dart, find skillCategories:
- To add a skill to an existing category, just add New Skill to the list.
- Example:
 `dart
 SkillCategory(
 categoryName: Languages,
 skills: [Dart, Java, JavaScript, HTML5, CSS3, SQL, Python],
 ),
 `

---

## 4. 🎓 How to Update Education & Certifications

Scroll to education or certifications in lib/portfolio_data.dart.
Add a new certification like this:

`dart
CertificationItem(
 title: Your New Certification Name,
 organization: Issuing Organization,
 date: Month Year,
 description: What you learned and accomplished in this certification.,
),
`

---

## 5. 📸 How to Change Your Photos

Your photos are located in:
📁 **ssets/images/**
- profile_seated.jpg (Used in the hero section)
- profile_portrait.jpg (Used in the about / journey card)

To replace them, simply put your new photos into ssets/images/ with the same names (or update the file paths inside lib/portfolio_data.dart).

---

## 6. 🌐 How to Run or Test Locally

Open your terminal in this folder and run:
`ash
flutter run -d chrome
`
Or for Windows desktop:
`ash
flutter run -d windows
`

To build for the web:
`ash
flutter build web --release
`
