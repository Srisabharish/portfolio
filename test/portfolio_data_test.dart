import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/portfolio_data.dart';

void main() {
  group('PortfolioData Single-Source-of-Truth Tests', () {
    test('Personal info is properly configured', () {
      expect(PortfolioData.personal.fullName, 'Sri Sabharish S');
      expect(PortfolioData.personal.role, 'Flutter Developer');
      expect(PortfolioData.personal.email, contains('@'));
      expect(PortfolioData.personal.phone, contains('9092657668'));
      expect(PortfolioData.personal.socials, isNotEmpty);
      expect(PortfolioData.personal.stats, isNotEmpty);
    });

    test('Projects list has valid entries with required fields', () {
      expect(PortfolioData.projects.length, greaterThanOrEqualTo(5));
      for (final project in PortfolioData.projects) {
        expect(project.id, isNotEmpty);
        expect(project.title, isNotEmpty);
        expect(project.category, isNotEmpty);
        expect(project.description, isNotEmpty);
        expect(project.highlights, isNotEmpty);
        expect(project.technologies, isNotEmpty);
      }
    });

    test('Process methodology contains 6 structured steps', () {
      expect(PortfolioData.processSteps.length, 6);
      for (final step in PortfolioData.processSteps) {
        expect(step.number, isNotEmpty);
        expect(step.title, isNotEmpty);
        expect(step.description, isNotEmpty);
      }
    });

    test('Skills categories and credentials exist', () {
      expect(PortfolioData.skillCategories, isNotEmpty);
      expect(PortfolioData.education, isNotEmpty);
      expect(PortfolioData.certifications, isNotEmpty);
    });
  });
}
