import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'portfolio_data.dart';
import 'theme/app_theme.dart';
import 'widgets/about_and_education_section.dart';
import 'widgets/contact_footer.dart';
import 'widgets/hero_section.dart';
import 'widgets/navbar.dart';
import 'widgets/process_section.dart';
import 'widgets/projects_section.dart';
import 'widgets/skills_section.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sri Sabharish S | Flutter Developer Portfolio",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _processKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(String section) {
    GlobalKey? targetKey;
    switch (section) {
      case "hero":
        targetKey = _heroKey;
        break;
      case "work":
        targetKey = _workKey;
        break;
      case "process":
        targetKey = _processKey;
        break;
      case "skills":
        targetKey = _skillsKey;
        break;
      case "about":
        targetKey = _aboutKey;
        break;
      case "contact":
        targetKey = _contactKey;
        break;
    }

    if (targetKey?.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey!.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openResume() async {
    final uri = Uri.parse(PortfolioData.personal.resumeUrl);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Ambient Midnight Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 600,
            left: -150,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 400,
            right: -150,
            child: Container(
              width: 550,
              height: 550,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main Scrollable Body
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 90), // Space for floating navbar

                // Hero Section
                Container(
                  key: _heroKey,
                  alignment: Alignment.center,
                  child: HeroSection(
                    onViewWorkTap: () => _scrollToSection("work"),
                    onContactTap: () => _scrollToSection("contact"),
                  ),
                ),

                // Selected Work Section
                Container(
                  key: _workKey,
                  alignment: Alignment.center,
                  child: const ProjectsSection(),
                ),

                // Engineering Process Section
                Container(
                  key: _processKey,
                  alignment: Alignment.center,
                  child: const ProcessSection(),
                ),

                // Skills and Tech Stack Section
                Container(
                  key: _skillsKey,
                  alignment: Alignment.center,
                  child: const SkillsSection(),
                ),

                // About and Education Section
                Container(
                  key: _aboutKey,
                  alignment: Alignment.center,
                  child: const AboutAndEducationSection(),
                ),

                // Contact and Footer Section
                Container(
                  key: _contactKey,
                  alignment: Alignment.center,
                  child: ContactFooter(onScrollToTop: _scrollToTop),
                ),
              ],
            ),
          ),

          // Floating Top Navbar
          FloatingNavbar(
            onNavTap: _scrollToSection,
            onResumeTap: _openResume,
          ),
        ],
      ),
    );
  }
}
