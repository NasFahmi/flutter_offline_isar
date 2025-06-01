import 'package:flutter/material.dart';

class TaskSync extends StatelessWidget {
  const TaskSync({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskSyncView();
  }
}

class TaskSyncView extends StatefulWidget {
  const TaskSyncView({super.key});

  @override
  State<TaskSyncView> createState() => _TaskSyncViewState();
}

class _TaskSyncViewState extends State<TaskSyncView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Create Book'),
              subtitle: Text('Status Pending'),
              leading: CircleAvatar(child: Text('${index + 1}')),
            );
          },
        ),
      ),
    );
  }
}
