import 'package:flutter/material.dart';

/// Widget que agrega efectos hover con scale y elevation
class AnimatedHoverButton extends StatefulWidget {
  const AnimatedHoverButton({
    super.key,
    required this.child,
    this.onTap,
    this.scaleOnHover = 1.05,
    this.elevationOnHover = 4.0,
    this.duration = const Duration(milliseconds: 150),
  });

  final Widget child;
  final VoidCallback? onTap;
  final double scaleOnHover;
  final double elevationOnHover;
  final Duration duration;

  @override
  State<AnimatedHoverButton> createState() => _AnimatedHoverButtonState();
}

class _AnimatedHoverButtonState extends State<AnimatedHoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedScale(
        scale: _isHovered ? widget.scaleOnHover : 1.0,
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: widget.duration,
          decoration: BoxDecoration(
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: widget.elevationOnHover,
                      offset: Offset(0, widget.elevationOnHover / 2),
                    ),
                  ]
                : null,
          ),
          child: GestureDetector(
            onTap: widget.onTap,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

/// Badge animado para mostrar cantidad de filtros
class AnimatedFilterBadge extends StatefulWidget {
  const AnimatedFilterBadge({
    super.key,
    required this.count,
    this.color = Colors.red,
  });

  final int count;
  final Color color;

  @override
  State<AnimatedFilterBadge> createState() => _AnimatedFilterBadgeState();
}

class _AnimatedFilterBadgeState extends State<AnimatedFilterBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int _previousCount = 0;

  @override
  void initState() {
    super.initState();
    _previousCount = widget.count;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void didUpdateWidget(AnimatedFilterBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count && widget.count > _previousCount) {
      _controller.forward(from: 0.0);
      _previousCount = widget.count;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.count == 0) return const SizedBox.shrink();

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: widget.color.withOpacity(0.4),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          '${widget.count}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// Shimmer effect para loading states
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8.0,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -2, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.grey[300]!,
                Colors.grey[100]!,
                Colors.grey[300]!,
              ],
              stops: const [0.0, 0.5, 1.0],
              transform: GradientRotation(_animation.value),
            ),
          ),
        );
      },
    );
  }
}

/// Snackbar mejorado con iconos animados
void showAnimatedSnackbar(
  BuildContext context, {
  required String message,
  required bool isSuccess,
  Duration duration = const Duration(seconds: 3),
}) {
  final icon = isSuccess ? Icons.check_circle : Icons.error;
  final color = isSuccess ? Colors.green : Colors.red;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 300),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Icon(icon, color: Colors.white),
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: color,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: duration,
      margin: const EdgeInsets.all(16),
    ),
  );
}

/// Grid skeleton loader
class GridSkeletonLoader extends StatelessWidget {
  const GridSkeletonLoader({
    super.key,
    this.rows = 10,
    this.columns = 6,
  });

  final int rows;
  final int columns;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Header
          Row(
            children: List.generate(
              columns,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ShimmerLoading(
                    width: double.infinity,
                    height: 40,
                    borderRadius: 4,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Rows
          Expanded(
            child: ListView.builder(
              itemCount: rows,
              itemBuilder: (context, rowIndex) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: List.generate(
                      columns,
                      (colIndex) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ShimmerLoading(
                            width: double.infinity,
                            height: 48,
                            borderRadius: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
