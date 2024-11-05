import 'package:books_app/model/book_model.dart';

// List buku yg tersedia
List<BookModel> bookList = [];

class BookService {
  // Tambah buku ke list buku yg tersedia
  void addBook({
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

  // Hapus buku dari list buku yg tersedia
  void removeBook({
    required BookModel book,
  }) {
    bookList.remove(book);
  }
}
