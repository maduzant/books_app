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
  // Salinan  dari booklist
  List<BookModel> books = List.of(bookList);
  TextEditingController searchController = TextEditingController();
  bool isSorting = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Button dequeue
        leading: Visibility(
          visible: books.isNotEmpty,
          child: IconButton(
            onPressed: () {
              BookService().dequeueBook();
              books = List.of(bookList);
              setState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Berhasil dihapus!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
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
      body: bookList.isEmpty
          ?
          // Jika bookList kosong
          const Center(
              child: Text("Data Kosong"),
            )
          :
          // Jika bookList tidak kosong
          Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      // Form search
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration:
                              const InputDecoration(hintText: "Search Title"),
                        ),
                      ),
                      // Button Linier Search
                      IconButton(
                          onPressed: () {
                            if (searchController.text.isNotEmpty) {
                              int index = BookService()
                                  .linierSearch(search: searchController.text);
                              if (index != -1) {
                                books = [bookList[index]];
                              } else {
                                books = [];
                              }
                            } else {
                              
                              books = List.of(bookList);
                            }
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                // Button Insertion Sort
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (!isSorting) {
                        log("Masuk if");
                        books = BookService().insertionSort();
                      } else {
                        log("Masuk else");
                        books = List.of(bookList);
                      }
                      isSorting = !isSorting;
                      setState(() {});
                    },
                    icon: const Icon(Icons.sort_rounded),
                    label: isSorting
                        ? const Text('Cancel')
                        : const Text(
                            'Sort by Year',
                          ),
                  ),
                ),
                Expanded(
                  child: books.isNotEmpty
                      ? ListView.builder(
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                  "${books[index].id}: ${books[index].title}"),
                              subtitle: Text(
                                  "${books[index].author}, ${books[index].year}"),
                            );
                          },
                        )
                      : const Center(
                          child: Text('Data Tidak Ditemukan'),
                        ),
                ),
              ],
            ),
    );
  }
}
