import 'package:flutter/material.dart';
import 'package:iventa/models/task_models.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import 'task_home_widget.dart';

class WidgetColumn extends StatelessWidget {
  final int columnId;
  final String columnName;
  final List<WidgetTask> tasks;

  const WidgetColumn({
    Key? key,
    required this.columnId,
    required this.columnName,
    required this.tasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Container(
      width: 250,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              columnName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: DragTarget<WidgetTask>(
              onAccept: (widgetTask) {
                taskProvider.moveTask(
                    widgetTask.taskName as TaskModel, columnId);
              },
              builder: (context, candidateData, rejectedData) {
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Draggable<WidgetTask>(
                      data: task,
                      child: task,
                      feedback: task,
                      childWhenDragging: const SizedBox(),
                      onDragCompleted: () {
                        taskProvider.removeTask(task.taskName as TaskModel);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
