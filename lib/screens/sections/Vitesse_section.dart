import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class VitesseSection extends StatefulWidget {
  const VitesseSection({super.key});

  @override
  _VitesseSectionState createState() => _VitesseSectionState();
}

class _VitesseSectionState extends State<VitesseSection> {
  int _speedLimit = 0;

  // Determine speed color based on range
  Color getSpeedColor(int speed, ThemeColors colors) {
    if (speed >= 0 && speed <= 25) {
      return colors.green;
    } else if (speed > 25 && speed <= 55) {
      return colors.orange;
    } else {
      return colors.error; // Using error as red
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      children: [
        const Icon(Icons.speed,
            size: 60, color: Color.fromARGB(255, 2, 47, 83)),
        const SizedBox(height: 10),
        Text(
          "$_speedLimit km/h",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: getSpeedColor(_speedLimit, colors),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, size: 40),
              onPressed: () =>
                  setState(() => _speedLimit = (_speedLimit - 5).clamp(0, 80)),
            ),
            const SizedBox(width: 30),
            IconButton(
              icon: const Icon(Icons.add_circle_outline, size: 40),
              onPressed: () =>
                  setState(() => _speedLimit = (_speedLimit + 5).clamp(0, 80)),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: colors.primary,
            inactiveTrackColor: colors.secondary.withOpacity(0.5),
            thumbColor: colors.textPrimary,
            overlayColor: colors.primary.withOpacity(0.2),
            valueIndicatorColor: colors.surface,
            valueIndicatorTextStyle: TextStyle(color: colors.textPrimary),
          ),
          child: Slider(
            value: _speedLimit.toDouble(),
            min: 0,
            max: 80,
            divisions: 16,
            label: "$_speedLimit km/h",
            onChanged: (value) => setState(() => _speedLimit = value.toInt()),
          ),
        ),
      ],
    );
  }
}
