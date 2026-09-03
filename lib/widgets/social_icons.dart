import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SocialBrandIcon extends StatelessWidget {
  final String brand;
  final double size;
  final Color? color;

  const SocialBrandIcon({
    super.key,
    required this.brand,
    this.size = 18,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppColors.textSecondary;

    switch (brand.toLowerCase()) {
      case 'github':
        return CustomPaint(
          size: Size(size, size),
          painter: _GithubIconPainter(effectiveColor),
        );
      case 'linkedin':
        return Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: effectiveColor.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
          child: Text(
            'in',
            style: GoogleFonts.plusJakartaSans(
              fontSize: size * 0.65,
              fontWeight: FontWeight.w900,
              color: effectiveColor,
              height: 1.0,
            ),
          ),
        );
      case 'whatsapp':
        return Icon(Icons.chat_bubble_outline_rounded, size: size, color: effectiveColor);
      case 'email':
      case 'envelope':
        return Icon(Icons.mail_outline_rounded, size: size, color: effectiveColor);
      case 'phone':
        return Icon(Icons.phone_outlined, size: size, color: effectiveColor);
      default:
        return Icon(Icons.link_rounded, size: size, color: effectiveColor);
    }
  }
}

class _GithubIconPainter extends CustomPainter {
  final Color color;

  _GithubIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Outer circle silhouette
    final path = Path();
    path.addOval(Rect.fromLTWH(0, 0, w, h));

    // Inner cutouts for cat silhouette
    final headPaint = Paint()
      ..color = AppColors.surface
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Subtle face cutout for stylized minimalist git mark
    final cutout = Path()
      ..moveTo(w * 0.35, h * 0.35)
      ..lineTo(w * 0.25, h * 0.65)
      ..quadraticBezierTo(w * 0.5, h * 0.8, w * 0.75, h * 0.65)
      ..lineTo(w * 0.65, h * 0.35)
      ..close();

    canvas.drawPath(cutout, headPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
