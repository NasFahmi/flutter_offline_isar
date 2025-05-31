import 'package:flutter/material.dart';
import 'package:offline_mode/app/feature/home/model/get_list_book_model.dart'
    as book;
import 'package:offline_mode/route/route_name.dart';

class DetailBook extends StatelessWidget {
  final book.Datum data;
  const DetailBook({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Book")),
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 8,
            children: [
              Text("Detail Book"),
              Text("Book Name : ${data.title} "),
              Text("Author : ${data.author}"),
              Text("Description : ${data.description}"),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, UPDATEBOOK, arguments: data);
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
