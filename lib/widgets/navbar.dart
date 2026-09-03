import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../portfolio_data.dart';
import '../theme/app_theme.dart';

class FloatingNavbar extends StatelessWidget {
  final Function(String section) onNavTap;
  final VoidCallback onResumeTap;

  const FloatingNavbar({
    super.key,
    required this.onNavTap,
    required this.onResumeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isCompact = width < 900;
          final isVerySmall = width < 450;

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isCompact ? 12.0 : 24.0,
              vertical: 12.0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: AppBreakpoints.maxContentWidth,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.glassBackground,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: AppColors.glassBorder, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.35),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo / Brand
                      Flexible(
                        child: _buildBrandLogo(context, isVerySmall),
                      ),

                      // Desktop Nav Links
                      if (!isCompact)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildNavLink("Work", "work"),
                            const SizedBox(width: 16),
                            _buildNavLink("Process", "process"),
                            const SizedBox(width: 16),
                            _buildNavLink("Skills", "skills"),
                            const SizedBox(width: 16),
                            _buildNavLink("About", "about"),
                            const SizedBox(width: 16),
                            _buildNavLink("Contact", "contact"),
                          ],
                        ),

                      // Right Actions
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Status Dot (Available for opportunities)
                          if (!isCompact && width > 1050) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.emerald.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.emerald.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 7,
                                    height: 7,
                                    decoration: const BoxDecoration(
                                      color: AppColors.emerald,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Available",
                                    style: GoogleFonts.jetBrainsMono(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.emerald,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                          ],

                          // Let's Talk CTA
                          ElevatedButton(
                            onPressed: () => onNavTap("contact"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: EdgeInsets.symmetric(
                                horizontal: isVerySmall ? 10 : 14,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Let's Talk",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                          // Mobile Menu Hamburger
                          if (isCompact) ...[
                            const SizedBox(width: 4),
                            IconButton(
                              icon: const Icon(Icons.menu, color: AppColors.textPrimary, size: 22),
                              onPressed: () => _showMobileMenu(context),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrandLogo(BuildContext context, bool isVerySmall) {
    return InkWell(
      onTap: () => onNavTap("hero"),
      borderRadius: BorderRadius.circular(12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
              child: Text(
                "SS",
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (!isVerySmall) ...[
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    PortfolioData.personal.fullName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    PortfolioData.personal.role,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 9,
                      color: AppColors.textMuted,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNavLink(String title, String section) {
    return InkWell(
      onTap: () => onNavTap(section),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.cardBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                _buildMobileMenuItem(ctx, "Work", "work", Icons.folder_outlined),
                _buildMobileMenuItem(ctx, "Process", "process", Icons.timeline_outlined),
                _buildMobileMenuItem(ctx, "Skills", "skills", Icons.code_outlined),
                _buildMobileMenuItem(ctx, "About and Education", "about", Icons.school_outlined),
                _buildMobileMenuItem(ctx, "Contact", "contact", Icons.mail_outline),
                const Divider(color: AppColors.cardBorder, height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      onResumeTap();
                    },
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text("View Resume"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileMenuItem(
    BuildContext context,
    String title,
    String section,
    IconData icon,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 20),
      title: Text(
        title,
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onNavTap(section);
      },
    );
  }
}
