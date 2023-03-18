import 'package:flutter/material.dart';
import 'package:iventa/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

  static const String routeName = 'home';
}

class _HomeScreenState extends State<HomeScreen> {
  final ColumnaProvider _columnaProvider = ColumnaProvider();

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('iVentas'),
        ),
        drawer: const DraweMenu(),
        body: FutureBuilder<List<ColumnaModel>>(
          future: _columnaProvider.getColumnas(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final columnas = snapshot.data!;
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: columnas.map((columna) {
                    return FutureBuilder<List<TaskModel>>(
                      future: Provider.of<TaskProvider>(context)
                          .getTasksByColumnId(columna.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final tasks = snapshot.data!;
                          final filteredTasks = tasks
                              .where((task) => task.column_id == columna.id)
                              .toList();
                          return WidgetColumn(
                            columnId: columna.id,
                            columnName: columna.nombreColum,
                            tasks: filteredTasks
                                .map((task) => WidgetTask(
                                      taskName: task.nombreTask,
                                      color: hexToColor(task.tag),
                                    ))
                                .toList(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const CircularProgressIndicator();
                      },
                    );
                  }).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

//usar la funcion para covertir el color hexadecimal en la bd a RGB
Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
