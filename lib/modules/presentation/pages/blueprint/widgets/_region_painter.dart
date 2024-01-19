part of '../blueprint_page.dart';

class _RegionPainter extends CustomPainter {
  final Region region;
  final bool isSelected;

  final double canvasWidth;
  final double canvasHeight;

  _RegionPainter({
    required this.region,
    required this.canvasWidth,
    required this.canvasHeight,
    this.isSelected = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final width = canvasWidth * region.relativeWidth;
    final height = canvasHeight * region.relativeHeight;

    final originX = region.relativeOriginX;
    final originY = region.relativeOriginY;

    Paint paint;
    if (isSelected) {
      paint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
    } else {
      paint = Paint()
        ..color = Colors.blue
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
    }

    canvas.drawRect(
      Rect.fromLTWH(originX, originY, width, height),
      paint,
    );

    final divisions = region.divisions;
    for (var division in divisions) {
      final lineX = division.relativeToRegionX0 * width;
      final lineY = division.relativeToRegionY0 * height;

      canvas.drawLine(
        Offset(lineX, lineY),
        Offset(lineX, lineY + height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
