import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../portfolio_data.dart';
import '../theme/app_theme.dart';
import 'animated_cursor.dart';
import 'interactive_card.dart';
import 'social_icons.dart';

class ContactFooter extends StatefulWidget {
  final VoidCallback onScrollToTop;

  const ContactFooter({super.key, required this.onScrollToTop});

  @override
  State<ContactFooter> createState() => _ContactFooterState();
}

class _ContactFooterState extends State<ContactFooter> {
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
    final isMobile = AppBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : 40.0,
        vertical: 80.0,
      ),
      constraints: const BoxConstraints(
        maxWidth: AppBreakpoints.maxContentWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Sub-header
          Text(
            "// 05. LET'S CONNECT",
            style: GoogleFonts.jetBrainsMono(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Big Headline
          Text(
            "Ready to collaborate?",
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 36 : 56,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -1.0,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "I'm always excited to discuss new opportunities, Flutter projects, or creative ideas.",
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 16 : 20,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 48),

          // Main Contact Card
          InteractiveTiltCard(
            accentColor: AppColors.secondary,
            cursorLabel: "CONNECT",
            maxTiltAngle: 0.04,
            hoverScale: 1.01,
            padding: EdgeInsets.all(isMobile ? 24.0 : 40.0),
            borderRadius: BorderRadius.circular(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "DIRECT INBOX",
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondary,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 12),

                // Selectable / Display Email
                SelectableText(
                  PortfolioData.personal.email,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: isMobile ? 20 : 34,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 24),

                // Action Buttons: Send Mail & Copy Email
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: [
                    CursorInteractable(
                      mode: CursorMode.pointer,
                      accentColor: AppColors.primaryLight,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final uri = Uri.parse("mailto:${PortfolioData.personal.email}");
                          if (await canLaunchUrl(uri)) launchUrl(uri);
                        },
                        icon: const Icon(Icons.mail_outline_rounded, size: 18),
                        label: const Text("Open Mail Client"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),

                    CursorInteractable(
                      mode: CursorMode.pointer,
                      accentColor: AppColors.emerald,
                      child: OutlinedButton.icon(
                        onPressed: _copyEmail,
                        icon: Icon(
                          _emailCopied ? Icons.check_circle : Icons.copy_rounded,
                          size: 16,
                          color: _emailCopied ? AppColors.emerald : AppColors.textPrimary,
                        ),
                        label: Text(_emailCopied ? "Email Copied!" : "Copy Email Address"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textPrimary,
                          side: BorderSide(
                            color: _emailCopied ? AppColors.emerald : AppColors.cardBorder,
                            width: 1.2,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          backgroundColor: AppColors.surface,
                        ),
                      ),
                    ),

                    CursorInteractable(
                      mode: CursorMode.pointer,
                      accentColor: AppColors.secondary,
                      child: OutlinedButton.icon(
                        onPressed: () async {
                          final uri = Uri.parse("tel:${PortfolioData.personal.phone}");
                          if (await canLaunchUrl(uri)) launchUrl(uri);
                        },
                        icon: const Icon(Icons.phone_outlined, size: 16),
                        label: Text(PortfolioData.personal.phone),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textSecondary,
                          side: const BorderSide(color: AppColors.cardBorder),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 36),
                const Divider(color: AppColors.cardBorder),
                const SizedBox(height: 24),

                // Social handles row
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildSocialPill(
                      "github",
                      "GitHub",
                      "https://github.com/srisabharish",
                    ),
                    _buildSocialPill(
                      "linkedin",
                      "LinkedIn",
                      "https://linkedin.com/in/sri-sabharish",
                    ),
                    _buildSocialPill(
                      "whatsapp",
                      "WhatsApp / Call",
                      "https://wa.me/919092657668",
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // Bottom Footer Credit & Back To Top
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "© 2026 Sri Sabharish S",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Designed and built from the desk of Sri Sabharish S • Flutter Web",
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 12,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),

              // Back to Top Button
              CursorInteractable(
                mode: CursorMode.pointer,
                accentColor: AppColors.secondary,
                child: IconButton(
                  onPressed: widget.onScrollToTop,
                  icon: const Icon(Icons.arrow_upward_rounded),
                  color: AppColors.textSecondary,
                  tooltip: "Back to top",
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: AppColors.cardBorder),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialPill(
    String brand,
    String title,
    String url,
  ) {
    return CursorInteractable(
      mode: CursorMode.pointer,
      accentColor: AppColors.secondary,
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) launchUrl(uri);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SocialBrandIcon(brand: brand, size: 16, color: AppColors.primaryLight),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

