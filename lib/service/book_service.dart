import 'dart:developer';

import 'package:books_app/model/book_model.dart';

// List buku
List<BookModel> bookList = [
  BookModel(
      id: 1, title: "Cantik Itu Luka", author: "Eka Kurniawan", year: 2016),
  BookModel(
      id: 2, title: "Laut Bercerita", author: "Leila S.Chudori", year: 2020),
  BookModel(id: 3, title: "Saman", author: "Ayu Utami", year: 2000)
];

class BookService {
  // Enqueue buku ke bookList
  void enqueueBook({
    required String judulBuku,
    required String penulisBuku,
    required int tahunBuku,
  }) {
    int newId = bookList.isEmpty ? 1 : bookList.last.id + 1;
    bookList.add(
      BookModel(
        id: newId,
        title: judulBuku,
        author: penulisBuku,
        year: tahunBuku,
      ),
    );
  }

  // Dequeue buku dari bookList
  void dequeueBook() {
    bookList.removeAt(0);
  }

  // Linier Search menggunakan title
  int linierSearch({required String search}) {
    for (int i = 0; i < bookList.length; i++) {
      if (bookList[i].title.toLowerCase() == search.toLowerCase()) {
        // Mengembalikan index jika nilainya sama
        return i;
      }
    }
    // Mengembalikan -1 jika nilainya tidak sama
    return -1;
  }

  // Insertion Sortir berdasarkan tahun
  List<BookModel> insertionSort() {
    // Buat salinan dari bookList
    List<BookModel> result = List.from(bookList);
    for (var i = 1; i < result.length; i++) {
      var j = i;
      while (j > 0 && result[j].year < result[j - 1].year) {
        // Tukar elemen jika tahun lebih kecil
        BookModel tmp = result[j - 1];
        result[j - 1] = result[j];
        result[j] = tmp;
        j--;
      }
    }
    // Mengembalikan result (salinan dari bookList yang udah dirubah)
    return result;
  }
}
