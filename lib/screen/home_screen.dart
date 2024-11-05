import 'dart:developer';

import 'package:books_app/service/book_service.dart';
import 'package:books_app/model/book_model.dart';
import 'package:books_app/screen/add_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // List buku dari booklist
    List<BookModel> books = List.of(bookList);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Books App",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Navigasi ke halaman tambah data lalu rebuild halaman home
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AddScreen(),
                ),
              ).then((value) => setState(() {}));
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: books.isEmpty
          ?
          // Jika books kosong
          const Center(
              child: Text("Data Kosong"),
            )
          :
          // Jika books tidak kosong
          Container(
              color: Colors.yellow,
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  log("Index ke : $index");
                  log("Nama buku : ${books[index].title}");
                  return Container(
                    color: Colors.blue,
                    child: ListTile(
                      title: Text("${books[index].id}: ${books[index].title}"),
                      subtitle:
                          Text("${books[index].author}, ${books[index].year}"),
                      // Hapus data dari books
                      trailing: IconButton(
                        onPressed: () {
                          BookService().removeBook(book: books[index]);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text(
                                "Data berhasil dihapus!",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.remove_circle),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
