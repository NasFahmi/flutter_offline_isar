import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_mode/app/feature/home/model/get_list_book_model.dart'
    as book;
import 'package:offline_mode/app/feature/book/updateBook/bloc/update_book_bloc.dart';
import 'package:offline_mode/utils/logger/logger.dart';

class UpdateBook extends StatelessWidget {
  final book.Datum data;
  const UpdateBook({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBookBloc(),
      child: UpdateBookView(data: data),
    );
  }
}

class UpdateBookView extends StatefulWidget {
  final book.Datum data;
  const UpdateBookView({super.key, required this.data});

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
    titleController.text = widget.data.title;
    authorController.text = widget.data.author;
    descriptionController.text = widget.data.description;
    publishedAtController.text = widget.data.publishedAt;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Book")),
      body: Center(
        child: Column(
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
              decoration: InputDecoration(label: Text('Description Book')),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: publishedAtController,
              decoration: InputDecoration(label: Text('Published At Book')),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                logger.d('update');
                context.read<UpdateBookBloc>().add(
                  UpdateBookSubmited(
                    title: titleController.text,
                    author: authorController.text,
                    decs: descriptionController.text,
                    publishedAt: publishedAtController.text,
                    id: widget.data.id,
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
}
