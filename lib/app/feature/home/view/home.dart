import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_mode/app/feature/home/bloc/bookBloc/book_bloc.dart';
import 'package:offline_mode/app/feature/home/bloc/internetBloc/internet_bloc.dart';
import 'package:offline_mode/app/view/pul_to_refresh.dart';
import 'package:offline_mode/app/view/widget/alert_dialog_content.dart';
import 'package:offline_mode/route/route_name.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BookBloc()),
        BlocProvider(create: (context) => InternetBloc()),
      ],
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EasyRefreshController refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );
  @override
  void initState() {
    context.read<BookBloc>().add(GetBookEvent());
    BlocProvider.of<InternetBloc>(context).add(InternetObserve());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final internetBloc = BlocProvider.of<InternetBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Book"),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: BlocSelector<InternetBloc, InternetState, bool>(
            selector: (state) => state.isDisconnected,
            builder: (context, isDisconneected) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialogContent(
                        mainButtonMessage: 'Cek Status Internet',
                        colorMainButton: Colors.blue,
                        mainButton: () {
                          internetBloc.add(CheckInternet());
                          Navigator.pop(context);
                        },
                        title: "Status Internet",
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 24),
                            Text('Status Internet Anda Adalah'),
                            SizedBox(height: 4),
                            Text(
                              isDisconneected ? 'Offline' : 'Online',
                              style: TextStyle(
                                fontSize: 18,
                                color: isDisconneected
                                    ? Colors.red
                                    : Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 24),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: isDisconneected ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              );
            },
          ),
        ),
        actions: [IconButton(onPressed: () {
          Navigator.pushNamed(context, CREATEBOOK);
        }, icon: Icon(Icons.plus_one),), IconButton(onPressed: (){}, icon: Icon(Icons.exit_to_app),)],
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is BookFailed) {
            return Center(child: Text(state.message));
          } else if (state is BookSuccess) {
            final books = state.books.data;
            // final books = state.books.data!;
            if (books.isEmpty) {
              return Center(child: Text("Tidak ada buku."));
            }
            return PullToRefreshWidget(
              onRefresh: () {
                context.read<BookBloc>().add(GetBookEvent());
              },
              refreshController: refreshController,
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, DETAILBOOK,
                          arguments: books[index]);
                    },
                    subtitle: Text(books[index].author),
                    title: Text(books[index].title),
                    leading: CircleAvatar(child: Text((index + 1).toString())),
                  );
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
