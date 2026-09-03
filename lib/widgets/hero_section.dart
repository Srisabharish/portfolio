import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../portfolio_data.dart';
import '../theme/app_theme.dart';
import 'social_icons.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWorkTap;
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onViewWorkTap,
    required this.onContactTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  bool _emailCopied = false;

  void _copyEmail() {
    Clipboard.setData(ClipboardData(text: PortfolioData.personal.email));
    setState(() => _emailCopied = true);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: AppColors.emerald, size: 20),
            const SizedBox(width: 10),
            Text(
              "Email copied to clipboard (${PortfolioData.personal.email})",
              style: GoogleFonts.plusJakartaSans(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: AppColors.surfaceSubtle,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.cardBorder),
        ),
        duration: const Duration(seconds: 3),
      ),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _emailCopied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = AppBreakpoints.isDesktop(context);
    final isMobile = AppBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16.0 : 36.0,
        vertical: isMobile ? 32.0 : 70.0,
      ),
      constraints: const BoxConstraints(
        maxWidth: AppBreakpoints.maxContentWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Availability Pill
          _buildStatusBadge(),
          const SizedBox(height: 24),

          // Main Hero Split: Left text, Right photo card
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(flex: 7, child: _buildHeroTextContent()),
                const SizedBox(width: 48),
                Expanded(flex: 5, child: _buildHeroPhotoCard()),
              ],
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroTextContent(),
                const SizedBox(height: 36),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: _buildHeroPhotoCard(),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 48),

          // Stats Bar
          _buildStatsBar(isMobile),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.emerald,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.emerald,
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              PortfolioData.personal.statusBadge.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
                letterSpacing: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name and Role
        Text(
          PortfolioData.personal.fullName,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryLight,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 12),

        // Bold Headline
        Text(
          "FLUTTER DEVELOPER",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 42,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            height: 1.1,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          "and Mobile Experience Architect",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 20),

        // Elevator pitch / bio
        Text(
          PortfolioData.personal.bioIntro,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            height: 1.6,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          PortfolioData.personal.bioExtended,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 13.5,
            height: 1.6,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(height: 32),

        // Action CTA Buttons
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            // View Work
            ElevatedButton.icon(
              onPressed: widget.onViewWorkTap,
              icon: const Icon(Icons.arrow_downward_rounded, size: 18),
              label: const Text("View Selected Work"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),

            // Copy Email
            OutlinedButton.icon(
              onPressed: _copyEmail,
              icon: Icon(
                _emailCopied ? Icons.check_circle : Icons.copy_rounded,
                size: 16,
                color: _emailCopied ? AppColors.emerald : AppColors.textPrimary,
              ),
              label: Text(_emailCopied ? "Email Copied!" : "Copy Email"),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: BorderSide(
                  color: _emailCopied ? AppColors.emerald : AppColors.cardBorder,
                  width: 1.2,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                backgroundColor: AppColors.surface.withValues(alpha: 0.6),
              ),
            ),

            // Contact CTA
            TextButton.icon(
              onPressed: widget.onContactTap,
              icon: const Icon(Icons.arrow_outward_rounded, size: 18),
              label: const Text("Let's Connect"),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.secondary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 28),

        // Quick Social Links Wrap (never overflows)
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 12,
          runSpacing: 10,
          children: [
            Text(
              "Socials //",
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
            _buildSocialIcon("github", "https://github.com/srisabharish"),
            _buildSocialIcon("linkedin", "https://linkedin.com/in/sri-sabharish"),
            _buildSocialIcon("email", "mailto:${PortfolioData.personal.email}"),
            _buildSocialIcon("phone", "tel:${PortfolioData.personal.phone}"),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String brand, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) launchUrl(uri);
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.cardBorder),
        ),
        child: Center(
          child: SocialBrandIcon(brand: brand, size: 16),
        ),
      ),
    );
  }

  Widget _buildHeroPhotoCard() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Ambient soft glow behind card
        Container(
          width: 340,
          height: 420,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.22),
                blurRadius: 50,
                spreadRadius: 8,
              ),
            ],
          ),
        ),

        // Photo Frame
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 360),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.cardBorder, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Photo Header Bar (Olio template style)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEF4444),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF59E0B),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF10B981),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "SRI SABHARISH // PORTFOLIO",
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.cardBorder),

              // Image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(22),
                ),
                child: Stack(
                  children: [
                    Image.asset(
                      PortfolioData.personal.heroPhoto,
                      height: 380,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    // Gradient overlay at bottom
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.background.withValues(alpha: 0.95),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Chennai, Tamil Nadu",
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 11,
                                  color: AppColors.secondary,
                                ),
                              ),
                              Text(
                                "Crafting Pixel-Perfect Mobile Apps",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: isMobile
          ? Column(
              children: [
                for (int i = 0; i < PortfolioData.personal.stats.length; i++) ...[
                  _buildStatItem(PortfolioData.personal.stats[i]),
                  if (i < PortfolioData.personal.stats.length - 1)
                    const Divider(color: AppColors.cardBorder, height: 24),
                ],
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < PortfolioData.personal.stats.length; i++) ...[
                  Expanded(child: _buildStatItem(PortfolioData.personal.stats[i])),
                  if (i < PortfolioData.personal.stats.length - 1)
                    Container(
                      width: 1,
                      height: 44,
                      color: AppColors.cardBorder,
                    ),
                ],
              ],
            ),
    );
  }

  Widget _buildStatItem(StatItem stat) {
    return Column(
      children: [
        Text(
          stat.value,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 30,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          stat.label.toUpperCase(),
          style: GoogleFonts.jetBrainsMono(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textMuted,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
