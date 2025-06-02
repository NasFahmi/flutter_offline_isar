import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_mode/app/database/queueService/model/sync_queue_model.dart';
import 'package:offline_mode/app/feature/taskSync/view/bloc/task_sync_bloc.dart';

class TaskSync extends StatelessWidget {
  const TaskSync({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskSyncBloc(),
      child: const TaskSyncView(),
    );
  }
}

class TaskSyncView extends StatefulWidget {
  const TaskSyncView({super.key});

  @override
  State<TaskSyncView> createState() => _TaskSyncViewState();
}

class _TaskSyncViewState extends State<TaskSyncView> {
  @override
  void initState() {
    context.read<TaskSyncBloc>().add(GetTaskSync());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),
      body: BlocBuilder<TaskSyncBloc, TaskSyncState>(
        builder: (context, state) {
          if (state is TaskSyncLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskSyncSuccess) {
            final data = state.data;
            if (data.isEmpty) {
              return Center(child: Text('No Data Found'));
            }
            return SafeArea(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(data[index].collectionName),
                    subtitle: Text('Operation : ${data[index].operation}'),
                    trailing: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: data[index].status == Status.success
                            ? Colors.blue
                            : data[index].status == Status.pending
                            ? Colors.amber
                            : Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        style: TextStyle(color: Colors.white),
                        data[index].status == Status.success
                            ? "Success"
                            : data[index].status == Status.pending
                            ? "Pending"
                            : "Failed",
                      ),
                    ),
                    leading: CircleAvatar(child: Text('${index + 1}')),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
