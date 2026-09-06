import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../portfolio_data.dart';
import '../theme/app_theme.dart';
import 'animated_cursor.dart';
import 'interactive_card.dart';
import 'social_icons.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
            "// 01. SELECTED WORK",
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
            "Featured Applications",
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 28 : 42,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Text(
              "A collection of cross-platform mobile apps and frontend solutions engineered with Flutter, Dart, Firebase, and REST APIs.",
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Project List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: PortfolioData.projects.length,
            separatorBuilder: (context, index) => const SizedBox(height: 28),
            itemBuilder: (context, index) {
              final project = PortfolioData.projects[index];
              return _ProjectCard(project: project);
            },
          ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  void _openDetailsModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => _ProjectDetailsDialog(project: widget.project),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = AppBreakpoints.isMobile(context);

    return InteractiveTiltCard(
      accentColor: widget.project.accentColor,
      cursorLabel: "PROJECT",
      maxTiltAngle: 0.05,
      hoverScale: 1.015,
      padding: EdgeInsets.all(isMobile ? 20.0 : 32.0),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Number, Category and Year
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            runSpacing: 8,
            children: [
              Text(
                "(${widget.project.id})",
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: widget.project.accentColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: widget.project.accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.project.category.toUpperCase(),
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: widget.project.accentColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Text(
                widget.project.year,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Title
          Text(
            widget.project.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle
          Text(
            widget.project.subtitle,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(height: 14),

          // Description
          Text(
            widget.project.description,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 18),

          // Bullet points
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.project.highlights.map((highlight) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Icon(
                        Icons.arrow_right_alt_rounded,
                        size: 16,
                        color: widget.project.accentColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        highlight,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5,
                          height: 1.5,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Tech Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.project.technologies.map((tech) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Text(
                  tech,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Action Buttons Wrap (never overflows horizontally)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              if (widget.project.githubUrl.isNotEmpty)
                CursorInteractable(
                  mode: CursorMode.pointer,
                  accentColor: Colors.white,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final uri = Uri.parse(widget.project.githubUrl);
                      if (await canLaunchUrl(uri)) launchUrl(uri);
                    },
                    icon: const SocialBrandIcon(brand: "github", size: 14, color: Colors.white),
                    label: const Text("View Code"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.surface,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      side: const BorderSide(color: AppColors.cardBorder),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

              CursorInteractable(
                mode: CursorMode.pointer,
                accentColor: widget.project.accentColor,
                child: OutlinedButton.icon(
                  onPressed: () => _openDetailsModal(context),
                  icon: const Icon(Icons.info_outline_rounded, size: 16),
                  label: const Text("Project Overview"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                    side: const BorderSide(color: AppColors.cardBorder),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
}

class _ProjectDetailsDialog extends StatelessWidget {
  final ProjectItem project;

  const _ProjectDetailsDialog({required this.project});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: const BorderSide(color: AppColors.cardBorder, width: 1.5),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650, maxHeight: 680),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Dialog Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: project.accentColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        project.category,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: project.accentColor,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.textMuted),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Text(
                project.title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                project.subtitle,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 14),
              const Divider(color: AppColors.cardBorder),
              const SizedBox(height: 14),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Architecture and Implementation",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.description,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 13.5,
                          height: 1.6,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 18),

                      Text(
                        "Key Highlights and Engineering Deliverables",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: project.highlights.map((h) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  size: 16,
                                  color: project.accentColor,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    h,
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 13.5,
                                      height: 1.5,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 18),

                      Text(
                        "Technologies Used",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceSubtle,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.cardBorder),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.jetBrainsMono(
                                fontSize: 11.5,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: CursorInteractable(
                  mode: CursorMode.pointer,
                  accentColor: project.accentColor,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final uri = Uri.parse(project.githubUrl);
                      if (await canLaunchUrl(uri)) launchUrl(uri);
                    },
                    icon: const SocialBrandIcon(brand: "github", size: 16, color: Colors.white),
                    label: const Text("View on GitHub"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
