import 'package:flutter/material.dart';
import 'package:operaeasy_app/config/theme.dart';

/// Card em superfície elevada com resposta tátil ao toque.
///
/// A escala ao pressionar confirma que o toque registrou — o técnico usa
/// o app de luva e sob sol, onde o ripple padrão do Material some.
class PressableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color? accentBorder;
  final EdgeInsetsGeometry padding;

  const PressableCard({
    super.key,
    required this.child,
    this.onTap,
    this.accentBorder,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  State<PressableCard> createState() => _PressableCardState();
}

class _PressableCardState extends State<PressableCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final tappable = widget.onTap != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // RepaintBoundary isola o repaint da escala: pressionar um card não
    // repinta os demais itens da lista.
    return RepaintBoundary(
      child: GestureDetector(
        onTapDown: tappable ? (_) => setState(() => _pressed = true) : null,
        onTapUp: tappable ? (_) => setState(() => _pressed = false) : null,
        onTapCancel: tappable ? () => setState(() => _pressed = false) : null,
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _pressed ? 0.985 : 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: isDark ? OperaEasyTheme.darkNeutral200 : Colors.white,
              borderRadius: BorderRadius.circular(OperaEasyTheme.radiusCard),
              border: Border.all(
                color: widget.accentBorder ??
                    (isDark
                        ? OperaEasyTheme.darkNeutral200
                        : OperaEasyTheme.neutral200),
              ),
              boxShadow: isDark ? null : OperaEasyTheme.shadowSoft,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Etiqueta de estado: fundo tintado + texto na cor forte.
///
/// Nunca texto branco sobre a cor cheia — reprova contraste AA nos tons
/// claros e some sob sol.
class StatusBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final Color tint;

  const StatusBadge({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.tint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(OperaEasyTheme.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
