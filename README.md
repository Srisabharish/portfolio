# Sri Sabharish S — Flutter Developer Portfolio 🚀

> **Live Website**: [https://srisabharish.github.io/portfolio/](https://srisabharish.github.io/portfolio/)  
> **GitHub Repository**: [https://github.com/Srisabharish/portfolio](https://github.com/Srisabharish/portfolio)

A sleek, responsive dark minimalist developer portfolio built in **Flutter Web**, inspired by the editorial design of [Olio Midnight](https://olio-midnight.framer.website/).

---

## 🌟 Highlights

- **100% Free Hosting**: Hosted permanently on GitHub Pages at [srisabharish.github.io/portfolio](https://srisabharish.github.io/portfolio/).
- **Single-File Content Management**: All projects, bio, skills, education, and contact details are controlled in **one single file** (`lib/portfolio_data.dart`). No need to touch UI or widget code!
- **Auto-Deploy with GitHub Actions**: Any push or edit on the `main` branch automatically triggers `.github/workflows/deploy.yml` to compile and deploy the updated site.
- **Olio Midnight Aesthetic**: Dark `#090A10` backdrop, frosted glass floating navbar, numbered `(01)` to `(06)` sections, interactive project modals, and copy-to-clipboard email feedback.
- **Fully Responsive**: Fluid layout verified across Mobile (`390x844`), Tablet, and Desktop (`1440x900`).

---

## 🛠️ How to Add Projects or Change Information

Open **[`lib/portfolio_data.dart`](lib/portfolio_data.dart)** and simply update the fields:

### Add a New Project:
```dart
ProjectItem(
  id: "06",
  title: "Your New Project Title",
  category: "Mobile App - Flutter",
  subtitle: "One-line catchy summary of your app",
  description: "Detailed description of architecture and features...",
  highlights: [
    "Key engineering achievement 1",
    "Key engineering achievement 2",
  ],
  technologies: ["Flutter", "Dart", "Firebase"],
  githubUrl: "https://github.com/srisabharish/your-repo",
  liveDemoUrl: "",
  accentColor: Color(0xFF6366F1),
  year: "2025",
  isFeatured: true,
),
```

Then push to GitHub:
```bash
git add lib/portfolio_data.dart
git commit -m "Add new project"
git push origin main
```
GitHub Actions will automatically build and publish your changes to the live site!

For a full non-technical walkthrough, see [**HOW_TO_EDIT.md**](HOW_TO_EDIT.md).

---

## 💻 Running Locally

```bash
# Get dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Run tests
flutter test

# Build for Web
flutter build web --release --base-href "/portfolio/"
```
