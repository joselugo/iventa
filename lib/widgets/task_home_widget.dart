import 'package:flutter/material.dart';

class WidgetTask extends StatelessWidget {
  final String taskName;
  final String? label;
  final Color color;

  const WidgetTask({
    Key? key,
    required this.taskName,
    this.label,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: taskName,
      child: Card(
        elevation: 2,
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                taskName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              if (label != null)
                Text(
                  label!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
      ),
      feedback: Material(
        child: Card(
          elevation: 2,
          color: color.withOpacity(0.7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              taskName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: Card(
          elevation: 2,
          color: color.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  taskName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                if (label != null)
                  Text(
                    label!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
