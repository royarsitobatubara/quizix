import 'package:quizix/models/question_model.dart';

Map<String, List<QuestionModel>> informaticsQuestion = {
  "easy": [
    QuestionModel(
        question: "Apa kepanjangan dari “HTML”",
        options: [
          'Hyperlinks and Text Markup Language',
          'Hyper Text Markup Language',
          'Home Tool Markup Language',
          'Hyper Transfer Markup Language'
        ],
        correctIndex: 1),
    QuestionModel(
        question: "Dalam pemrograman, variabel digunakan untuk...",
        options: [
          'Menampilkan data di layar',
          'Menyimpan nilai atau data',
          'Menghapus file',
          'Mengatur warna layar'
        ],
        correctIndex: 1),
    QuestionModel(
        question: "Operator ‘+’ dalam pemrograman biasanya digunakan untuk...",
        options: [
          'Membagi angka',
          'Mengalikan angka',
          'Menjumlahkan nilai',
          'Menghapus data'
        ],
        correctIndex: 2),
    QuestionModel(
        question: "Di bawah ini yang merupakan bahasa pemrograman adalah...",
        options: ['Chrome', 'Facebook', 'JavaScript', 'Google'],
        correctIndex: 2),
    QuestionModel(
        question: "Tipe data yang digunakan untuk menyimpan teks adalah...",
        options: ['int', 'bool', 'string', 'float'],
        correctIndex: 2),
    QuestionModel(
        question: "Simbol ‘==’ dalam pemrograman digunakan untuk...",
        options: ['Penjumlahan', 'Perbandingan kesamaan', 'Pengurangan', 'Pembagian'],
        correctIndex: 1),
    QuestionModel(
        question: "Fungsi utama dari perintah ‘print’ adalah...",
        options: ['Mencetak data ke layar', 'Menyimpan data ke file', 'Menghapus data', 'Mengulang program'],
        correctIndex: 0),
    QuestionModel(
        question: "Komentar dalam kode digunakan untuk...",
        options: ['Menambah error', 'Menjelaskan kode agar mudah dibaca', 'Menjalankan program lebih cepat', 'Menghapus baris kode'],
        correctIndex: 1),
    QuestionModel(
        question: "Apa hasil dari 5 % 2 dalam bahasa pemrograman?",
        options: ['2', '2.5', '1', '0'],
        correctIndex: 2),
    QuestionModel(
        question: "Bahasa pemrograman yang digunakan untuk membuat halaman web adalah...",
        options: ['Python', 'HTML', 'C++', 'Java'],
        correctIndex: 1),
  ],

  // ---------------- MEDIUM ----------------
  "medium": [
    QuestionModel(
        question: "Tipe data 'bool' digunakan untuk menyimpan...",
        options: ['Angka desimal', 'Nilai benar/salah', 'Teks', 'Angka bulat'],
        correctIndex: 1),
    QuestionModel(
        question: "Struktur kontrol yang digunakan untuk pengulangan adalah...",
        options: ['if', 'while', 'break', 'return'],
        correctIndex: 1),
    QuestionModel(
        question: "Apa output dari kode berikut: print(2 + 3 * 2)?",
        options: ['10', '8', '7', '12'],
        correctIndex: 1),
    QuestionModel(
        question: "Dalam Python, list didefinisikan menggunakan tanda...",
        options: ['{}', '[]', '()', '<>'],
        correctIndex: 1),
    QuestionModel(
        question: "Fungsi utama dari 'return' adalah...",
        options: ['Mengakhiri loop', 'Mengembalikan nilai dari fungsi', 'Menampilkan data', 'Menjalankan kondisi if'],
        correctIndex: 1),
    QuestionModel(
        question: "Dalam bahasa C, setiap perintah diakhiri dengan...",
        options: ['Tanda koma (,)', 'Tanda titik (.)', 'Tanda titik koma (;)', 'Tanda kurung ()'],
        correctIndex: 2),
    QuestionModel(
        question: "Operator logika '&&' berarti...",
        options: ['OR', 'NOT', 'AND', 'EQUAL'],
        correctIndex: 2),
    QuestionModel(
        question: "Apa fungsi dari keyword 'else'?",
        options: ['Menjalankan kode jika kondisi salah', 'Menghentikan program', 'Membuat perulangan', 'Mendefinisikan fungsi'],
        correctIndex: 0),
    QuestionModel(
        question: "Fungsi dari 'for' loop adalah...",
        options: ['Menjalankan perintah satu kali', 'Menjalankan perintah berulang kali', 'Mengakhiri fungsi', 'Menghapus variabel'],
        correctIndex: 1),
    QuestionModel(
        question: "Dalam pemrograman, apa itu 'array'?",
        options: ['Kumpulan nilai dengan tipe berbeda', 'Kumpulan nilai dengan tipe sama', 'Variabel tunggal', 'Kata kunci dalam bahasa C'],
        correctIndex: 1),
  ],

  // ---------------- HARD ----------------
  "hard": [
    QuestionModel(
        question: "Apa hasil dari operasi: (5 + 3) * 2 - 4 / 2?",
        options: ['12', '14', '10', '8'],
        correctIndex: 1),
    QuestionModel(
        question: "Big O notation digunakan untuk...",
        options: ['Menghitung jumlah variabel', 'Mengukur efisiensi algoritma', 'Menampilkan output', 'Mendeteksi bug'],
        correctIndex: 1),
    QuestionModel(
        question: "Apa fungsi dari 'recursion'?",
        options: ['Membuat fungsi memanggil dirinya sendiri', 'Mengulang tanpa batas', 'Menjalankan fungsi secara paralel', 'Membuat variabel global'],
        correctIndex: 0),
    QuestionModel(
        question: "Struktur data yang mengikuti prinsip LIFO adalah...",
        options: ['Queue', 'Stack', 'Array', 'Linked List'],
        correctIndex: 1),
    QuestionModel(
        question: "Dalam OOP, konsep 'encapsulation' berarti...",
        options: ['Menggabungkan data dan metode dalam satu kesatuan', 'Mewarisi sifat dari class lain', 'Mengganti metode parent', 'Membuat banyak objek sekaligus'],
        correctIndex: 0),
    QuestionModel(
        question: "Keyword 'static' dalam Java digunakan untuk...",
        options: ['Membuat variabel global', 'Membuat variabel/method yang dapat diakses tanpa instance', 'Membatasi akses class', 'Mendefinisikan konstanta'],
        correctIndex: 1),
    QuestionModel(
        question: "Apa fungsi utama dari garbage collector?",
        options: ['Menghapus variabel duplikat', 'Mengatur memori yang tidak digunakan lagi', 'Menjalankan ulang program', 'Menangani error runtime'],
        correctIndex: 1),
    QuestionModel(
        question: "Dalam SQL, perintah untuk mengambil data dari tabel adalah...",
        options: ['INSERT', 'UPDATE', 'SELECT', 'DELETE'],
        correctIndex: 2),
    QuestionModel(
        question: "Apa hasil dari 10 / 3 dalam bahasa pemrograman C?",
        options: ['3.3', '3', '4', 'Error'],
        correctIndex: 1),
    QuestionModel(
        question: "Konsep inheritance digunakan untuk...",
        options: ['Mengambil data dari file', 'Mewarisi sifat dan metode dari class lain', 'Menghapus variabel', 'Menjalankan fungsi lebih cepat'],
        correctIndex: 1),
  ],
};
