import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_mode/app/feature/book/createBook/bloc/create_book_bloc.dart';

class CreateBook extends StatelessWidget {
  const CreateBook({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateBookBloc(),
      child: CreateBookView(),
    );
  }
}

class CreateBookView extends StatefulWidget {
  const CreateBookView({super.key});

  @override
  State<CreateBookView> createState() => _CreateBookViewState();
}

class _CreateBookViewState extends State<CreateBookView> {
  TextEditingController titleController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController publishedAtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Book")),
      body: Center(
        child: Column(
          children: [
            Text('Create Book'),
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
                context.read<CreateBookBloc>().add(
                  CreateBookSubmited(
                    title: titleController.text,
                    author: authorController.text,
                    decs: descriptionController.text,
                    publishedAt: publishedAtController.text,
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
