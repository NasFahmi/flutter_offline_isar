import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_mode/app/feature/book/detailBook/bloc/deleteBookBloc/delete_book_bloc.dart';
import 'package:offline_mode/app/feature/book/detailBook/bloc/detailBookBloc/detail_book_bloc.dart';
import 'package:offline_mode/route/route_name.dart';

class DetailBook extends StatelessWidget {
  final String id;
  const DetailBook({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteBookBloc(),
      child: BlocProvider(
        create: (context) => DetailBookBloc(),
        child: DetailBookView(id: id),
      ),
    );
  }
}

class DetailBookView extends StatefulWidget {
  final String id;
  const DetailBookView({super.key, required this.id});

  @override
  State<DetailBookView> createState() => _DetailBookViewState();
}

class _DetailBookViewState extends State<DetailBookView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBookBloc, DetailBookState>(
      builder: (context, state) {
        if (state is DetailBookLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is DetailBookLocalSuccess) {
          return Scaffold(
            appBar: AppBar(title: const Text("Detail Book")),
            body: SafeArea(
              child: Center(
                child: Column(
                  spacing: 8,
                  children: [
                    Text("Detail Book"),
                    Text("Book Name : ${state.book.title} "),
                    Text("Author : ${state.book.author}"),
                    Text("Description : ${state.book.description}"),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          UPDATEBOOK,
                          arguments: state.book.serverId,
                        );
                      },
                      child: Text("Update"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<DeleteBookBloc>().add(
                          DeleteBookById(id: state.book.serverId ?? ''),
                        );
                      },
                      child: Text("Delete"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
