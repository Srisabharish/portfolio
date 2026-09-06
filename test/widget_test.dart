import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/portfolio_data.dart';

void main() {
  testWidgets('Portfolio renders on desktop viewport (1440x900)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify Name and Role from PortfolioData
    expect(find.textContaining(PortfolioData.personal.fullName), findsWidgets);
    expect(find.textContaining(PortfolioData.personal.role), findsWidgets);
    expect(find.text('FLUTTER DEVELOPER'), findsOneWidget);

    // Verify Nav Links on desktop
    expect(find.text('Work'), findsOneWidget);
    expect(find.text('Process'), findsOneWidget);
    expect(find.text('Skills'), findsOneWidget);
    expect(find.text('Contact'), findsWidgets);

    // Verify Featured Projects from data file
    expect(find.text('Car Rental Application'), findsOneWidget);
    expect(find.text('Real-Time Weather App'), findsOneWidget);
    expect(find.text('Movie Collection and Streaming Guide'), findsOneWidget);
  });

  testWidgets('Portfolio renders on mobile viewport (390x844)', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const PortfolioApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Verify Name and Header exist
    expect(find.textContaining(PortfolioData.personal.fullName), findsWidgets);

    // Verify Hamburger icon exists on mobile
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
