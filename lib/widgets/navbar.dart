import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../portfolio_data.dart';
import '../theme/app_theme.dart';
import 'animated_cursor.dart';

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

                      // Desktop Nav Links with hover animations
                      if (!isCompact)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _NavLinkItem(title: "Work", section: "work", onNavTap: onNavTap),
                            const SizedBox(width: 8),
                            _NavLinkItem(title: "Process", section: "process", onNavTap: onNavTap),
                            const SizedBox(width: 8),
                            _NavLinkItem(title: "Skills", section: "skills", onNavTap: onNavTap),
                            const SizedBox(width: 8),
                            _NavLinkItem(title: "About", section: "about", onNavTap: onNavTap),
                            const SizedBox(width: 8),
                            _NavLinkItem(title: "Contact", section: "contact", onNavTap: onNavTap),
                          ],
                        ),

                      // Right Actions
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Status Dot (Available for opportunities) with pulsing radar
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
                                  const PulsingRadarDot(color: AppColors.emerald, size: 7),
                                  const SizedBox(width: 8),
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
                          CursorInteractable(
                            mode: CursorMode.pointer,
                            accentColor: AppColors.primaryLight,
                            child: _AnimatedCtaButton(
                              label: "Let's Talk",
                              isVerySmall: isVerySmall,
                              onTap: () => onNavTap("contact"),
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
    return CursorInteractable(
      mode: CursorMode.pointer,
      accentColor: AppColors.secondary,
      child: InkWell(
        onTap: () => onNavTap("hero"),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
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
              const SizedBox(width: 10),
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

/// Animated navigation link item with hover pill effect
class _NavLinkItem extends StatefulWidget {
  final String title;
  final String section;
  final Function(String) onNavTap;

  const _NavLinkItem({
    required this.title,
    required this.section,
    required this.onNavTap,
  });

  @override
  State<_NavLinkItem> createState() => _NavLinkItemState();
}

class _NavLinkItemState extends State<_NavLinkItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return CursorInteractable(
      mode: CursorMode.pointer,
      accentColor: AppColors.primaryLight,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: () => widget.onNavTap(widget.section),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
            ),
            child: Text(
              widget.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13.5,
                fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                color: _isHovered ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Pulsing radar ring surrounding status dot
class PulsingRadarDot extends StatefulWidget {
  final Color color;
  final double size;

  const PulsingRadarDot({
    super.key,
    required this.color,
    this.size = 8.0,
  });

  @override
  State<PulsingRadarDot> createState() => _PulsingRadarDotState();
}

class _PulsingRadarDotState extends State<PulsingRadarDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, child) {
        final progress = _anim.value;
        final waveSize = widget.size + progress * 10;
        final waveAlpha = (1.0 - progress) * 0.7;

        return SizedBox(
          width: widget.size + 10,
          height: widget.size + 10,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Expanding radar wave
              Container(
                width: waveSize,
                height: waveSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.color.withValues(alpha: waveAlpha),
                    width: 1.5,
                  ),
                ),
              ),

              // Solid inner glowing dot
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.color,
                      blurRadius: 6,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Animated CTA button with hover scale & glow
class _AnimatedCtaButton extends StatefulWidget {
  final String label;
  final bool isVerySmall;
  final VoidCallback onTap;

  const _AnimatedCtaButton({
    required this.label,
    required this.isVerySmall,
    required this.onTap,
  });

  @override
  State<_AnimatedCtaButton> createState() => _AnimatedCtaButtonState();
}

class _AnimatedCtaButtonState extends State<_AnimatedCtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(
            horizontal: widget.isVerySmall ? 10 : 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered
                  ? [AppColors.primaryLight, AppColors.primary]
                  : [AppColors.primary, const Color(0xFF4F46E5)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: _isHovered ? 0.45 : 0.2),
                blurRadius: _isHovered ? 14 : 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
