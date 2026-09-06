import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../portfolio_data.dart';
import '../theme/app_theme.dart';
import 'interactive_card.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = AppBreakpoints.isDesktop(context);
    final isMobile = AppBreakpoints.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20.0 : 40.0,
        vertical: 60.0,
      ),
      constraints: const BoxConstraints(
        maxWidth: AppBreakpoints.maxContentWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Sub-header
          Text(
            "// 02. METHODOLOGY",
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
            "Tried-and-True Engineering Process",
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 32 : 42,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              "A structured, end-to-end development workflow from requirements to production deployment, ensuring robust code, optimal performance, and intuitive user experiences.",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Process Grid / List
          if (isMobile)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: PortfolioData.processSteps.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final step = PortfolioData.processSteps[index];
                return _ProcessStepCard(step: step);
              },
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: PortfolioData.processSteps.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: isDesktop ? 1.05 : 1.15,
              ),
              itemBuilder: (context, index) {
                final step = PortfolioData.processSteps[index];
                return _ProcessStepCard(step: step);
              },
            ),
        ],
      ),
    );
  }
}

class _ProcessStepCard extends StatefulWidget {
  final ProcessStep step;

  const _ProcessStepCard({required this.step});

  @override
  State<_ProcessStepCard> createState() => _ProcessStepCardState();
}

class _ProcessStepCardState extends State<_ProcessStepCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InteractiveTiltCard(
        accentColor: AppColors.primaryLight,
        cursorLabel: "STEP",
        maxTiltAngle: 0.05,
        hoverScale: 1.02,
        padding: const EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "(${widget.step.number})",
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryLight,
                  ),
                ),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  offset: _isHovered ? const Offset(0.2, 0) : Offset.zero,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: _isHovered ? AppColors.primaryLight : AppColors.textMuted,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.step.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.step.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

