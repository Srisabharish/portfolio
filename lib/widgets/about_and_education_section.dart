import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../portfolio_data.dart';
import '../theme/app_theme.dart';
import 'animated_cursor.dart';
import 'interactive_card.dart';

class AboutAndEducationSection extends StatelessWidget {
  const AboutAndEducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = AppBreakpoints.isDesktop(context);
    final isMobile = AppBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : 36.0,
        vertical: 50.0,
      ),
      constraints: const BoxConstraints(
        maxWidth: AppBreakpoints.maxContentWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Sub-header
          Text(
            "// 04. BACKGROUND & CREDENTIALS",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),

          // Main Section Title
          Text(
            "About Me and Education",
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 28 : 42,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 40),

          // Split Grid: Left Profile Card, Right Education & Certs
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(flex: 5, child: _buildAboutProfileCard(context)),
                const SizedBox(width: 36),
                Expanded(flex: 7, child: _buildEducationAndCerts(context)),
              ],
            )
          else
            Column(
              children: [
                _buildAboutProfileCard(context),
                const SizedBox(height: 32),
                _buildEducationAndCerts(context),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildAboutProfileCard(BuildContext context) {
    return InteractiveTiltCard(
      accentColor: AppColors.primaryLight,
      cursorLabel: "ABOUT",
      maxTiltAngle: 0.04,
      hoverScale: 1.015,
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Portrait + Bio Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  PortfolioData.personal.aboutPhoto,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      PortfolioData.personal.fullName,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      PortfolioData.personal.role,
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 11,
                        color: AppColors.secondary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 14,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            PortfolioData.personal.location,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: AppColors.cardBorder),
          const SizedBox(height: 16),

          Text(
            "Engineering Philosophy",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "I believe that outstanding software combines architectural discipline with clean, human-centric design. In Flutter development, I focus on predictable state flows, reusable component systems, responsive touch targets, and silky-smooth frame rates.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            "Whether designing complex cross-platform apps with Firebase real-time sync or building interactive web applications, I bring dedication, curiosity, and rapid adaptability to every challenge.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13.5,
              height: 1.6,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationAndCerts(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Education Title
        Row(
          children: [
            const Icon(Icons.school_rounded, color: AppColors.primary, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Education",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Education Card
        for (final edu in PortfolioData.education) ...[
          InteractiveTiltCard(
            accentColor: AppColors.secondary,
            cursorLabel: "DEGREE",
            maxTiltAngle: 0.04,
            hoverScale: 1.015,
            padding: const EdgeInsets.all(20),
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    Text(
                      edu.degree,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        edu.grade,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  "${edu.institution} • ${edu.location}",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13.5,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  edu.period,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11.5,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  edu.description,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],

        const SizedBox(height: 20),

        // Certifications Title
        Row(
          children: [
            const Icon(Icons.verified_rounded, color: AppColors.emerald, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Industry Certifications",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // Certifications List
        for (final cert in PortfolioData.certifications) ...[
          CursorInteractable(
            mode: CursorMode.pointer,
            accentColor: AppColors.emerald,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.cardBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.emerald.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: AppColors.emerald,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          spacing: 12,
                          runSpacing: 4,
                          children: [
                            Text(
                              cert.title,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              cert.date,
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 11,
                                color: AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          cert.organization,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          cert.description,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            height: 1.4,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
