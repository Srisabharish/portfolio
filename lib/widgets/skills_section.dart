import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../portfolio_data.dart';
import '../theme/app_theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
            "// 03. CAPABILITIES",
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
            "Technical Stack and Core Skills",
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
              "Tools, frameworks, and foundational computer engineering competencies mastered throughout hands-on development and academic studies.",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Bento Skill Grid / List
          if (isMobile)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: PortfolioData.skillCategories.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final category = PortfolioData.skillCategories[index];
                return _SkillCategoryCard(category: category, index: index, isMobile: true);
              },
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: PortfolioData.skillCategories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 2 : 1,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: isDesktop ? 1.6 : 1.5,
              ),
              itemBuilder: (context, index) {
                final category = PortfolioData.skillCategories[index];
                return _SkillCategoryCard(category: category, index: index, isMobile: false);
              },
            ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategory category;
  final int index;
  final bool isMobile;

  const _SkillCategoryCard({
    required this.category,
    required this.index,
    required this.isMobile,
  });

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _isHovered = false;

  Color get _accentColor {
    switch (widget.index % 4) {
      case 0:
        return AppColors.primary;
      case 1:
        return AppColors.secondary;
      case 2:
        return AppColors.emerald;
      case 3:
      default:
        return AppColors.purple;
    }
  }

  IconData get _categoryIcon {
    switch (widget.index % 4) {
      case 0:
        return Icons.code_rounded;
      case 1:
        return Icons.devices_rounded;
      case 2:
        return Icons.dns_rounded;
      case 3:
      default:
        return Icons.psychology_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chipsWidget = Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.category.skills.map((skill) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Text(
            skill,
            style: GoogleFonts.jetBrainsMono(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        );
      }).toList(),
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surfaceSubtle : AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered ? _accentColor : AppColors.cardBorder,
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            if (_isHovered)
              BoxShadow(
                color: _accentColor.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: widget.isMobile ? MainAxisSize.min : MainAxisSize.max,
          children: [
            // Category Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(_categoryIcon, size: 18, color: _accentColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.category.categoryName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Skill Chips
            if (widget.isMobile)
              chipsWidget
            else
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: chipsWidget,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
