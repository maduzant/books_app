import 'package:books_app/service/book_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController judulBukuController = TextEditingController();
  TextEditingController penulisBukuController = TextEditingController();
  TextEditingController tahunBukuController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    judulBukuController.dispose();
    penulisBukuController.dispose();
    tahunBukuController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Book",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: judulBukuController,
              decoration: InputDecoration(
                hintText: "Judul Buku",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: penulisBukuController,
              decoration: InputDecoration(
                hintText: "Penulis Buku",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              controller: tahunBukuController,
              decoration: InputDecoration(
                hintText: "Tahun Terbit",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text("Simpan"),
              onPressed: () {
                // Cek semua form kosong atau tidak
                if (judulBukuController.text.isEmpty ||
                    penulisBukuController.text.isEmpty ||
                    tahunBukuController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        "Mohon isi semua data!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  // Jika form tidak kosong
                  BookService().enqueueBook(
                    judulBuku: judulBukuController.text,
                    penulisBuku: penulisBukuController.text,
                    tahunBuku: int.parse(tahunBukuController.text),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                        "Berhasil tambah data!",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
