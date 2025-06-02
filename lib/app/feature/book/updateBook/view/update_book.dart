import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_mode/app/feature/book/updateBook/bloc/update_book_bloc.dart';
import 'package:offline_mode/utils/logger/logger.dart';

class UpdateBook extends StatelessWidget {
  final String serverId;
  const UpdateBook({super.key, required this.serverId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBookBloc(),
      child: UpdateBookView(serverId: serverId),
    );
  }
}

class UpdateBookView extends StatefulWidget {
  final String serverId;
  const UpdateBookView({super.key, required this.serverId});

  @override
  State<UpdateBookView> createState() => _UpdateBookViewState();
}

class _UpdateBookViewState extends State<UpdateBookView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController publishedAtController = TextEditingController();
  @override
  void initState() {
    context.read<UpdateBookBloc>().add(
      GetDetailBookforUpdate(serverId: widget.serverId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Book")),
      body: BlocConsumer<UpdateBookBloc, UpdateBookState>(
        listener: (context, state) {
          if (state is UpdateBookSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is UpdateBookLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UpdateBookLoadSuccess) {
            final data = state.data;
            titleController.text = data.title ?? "";
            authorController.text = data.author ?? "";
            descriptionController.text = data.description ?? "";
            publishedAtController.text = data.publishedAt ?? "";

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Update Book'),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(label: Text('Title Book')),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: authorController,
                      decoration: InputDecoration(label: Text('Author Book')),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        label: Text('Description Book'),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: publishedAtController,
                      decoration: InputDecoration(
                        label: Text('Published At Book'),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        logger.d('update');
                        context.read<UpdateBookBloc>().add(
                          UpdateBookSubmited(
                            isSync: data.isSynced,
                            title: titleController.text,
                            author: authorController.text,
                            decs: descriptionController.text,
                            publishedAt: publishedAtController.text,
                            id: widget.serverId,
                          ),
                        );
                      },
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
