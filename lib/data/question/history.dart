import 'package:quizix/models/question_model.dart';

Map<String, List<QuestionModel>> historyQuestion = {
  // ---------------- EASY ----------------
  "easy": [
    QuestionModel(
        question: "Siapa presiden pertama Indonesia?",
        options: ['Soekarno', 'Suharto', 'Jokowi', 'Habibie'],
        correctIndex: 0),
    QuestionModel(
        question: "Tanggal proklamasi kemerdekaan Indonesia?",
        options: ['17 Agustus 1945', '17 Agustus 1946', '10 November 1945', '1 Juni 1945'],
        correctIndex: 0),
    QuestionModel(
        question: "Siapa penulis teks proklamasi?",
        options: ['Soekarno', 'Muhammad Yamin', 'Hatta', 'Sutan Syahrir'],
        correctIndex: 0),
    QuestionModel(
        question: "Lambang negara Indonesia adalah...",
        options: ['Garuda Pancasila', 'Burung Rajawali', 'Macan', 'Garuda Wisnu'],
        correctIndex: 0),
    QuestionModel(
        question: "Bendera Indonesia terdiri dari warna...",
        options: ['Merah dan Putih', 'Merah dan Biru', 'Putih dan Biru', 'Merah, Putih, Biru'],
        correctIndex: 0),
    QuestionModel(
        question: "Sumpah Pemuda terjadi pada tahun...",
        options: ['1928', '1945', '1908', '1930'],
        correctIndex: 0),
    QuestionModel(
        question: "Siapa tokoh kemerdekaan yang dikenal sebagai Bapak Koperasi?",
        options: ['Mohammad Hatta', 'Soekarno', 'Ki Hajar Dewantara', 'Tan Malaka'],
        correctIndex: 0),
    QuestionModel(
        question: "Hari pahlawan diperingati pada tanggal...",
        options: ['10 November', '17 Agustus', '1 Juni', '20 Mei'],
        correctIndex: 0),
    QuestionModel(
        question: "Siapa pendiri Taman Siswa?",
        options: ['Ki Hajar Dewantara', 'Soekarno', 'Hatta', 'Tan Malaka'],
        correctIndex: 0),
    QuestionModel(
        question: "Proklamator kemerdekaan Indonesia adalah...",
        options: ['Soekarno & Hatta', 'Soekarno sendiri', 'Hatta sendiri', 'Sutan Syahrir'],
        correctIndex: 0),
  ],

  // ---------------- MEDIUM ----------------
  "medium": [
    QuestionModel(
        question: "Perjanjian Linggarjati menandai pengakuan Belanda terhadap wilayah...",
        options: ['Indonesia bagian barat', 'Indonesia bagian timur', 'Seluruh Indonesia', 'Sumatra saja'],
        correctIndex: 0),
    QuestionModel(
        question: "Peristiwa G30S terjadi pada tahun...",
        options: ['1965', '1945', '1971', '1960'],
        correctIndex: 0),
    QuestionModel(
        question: "Sistem pemerintahan RIS dianut setelah...",
        options: ['Konferensi Meja Bundar', 'Proklamasi 1945', 'Perjanjian Linggarjati', 'Sumpah Pemuda'],
        correctIndex: 0),
    QuestionModel(
        question: "Siapa yang menulis naskah proklamasi bersama Soekarno?",
        options: ['Hatta', 'Sutan Syahrir', 'Tan Malaka', 'Ahmad Yani'],
        correctIndex: 0),
    QuestionModel(
        question: "Konferensi Meja Bundar (KMB) berlangsung pada tahun...",
        options: ['1949', '1945', '1950', '1955'],
        correctIndex: 0),
    QuestionModel(
        question: "Revolusi fisik di Indonesia terjadi antara tahun...",
        options: ['1945-1949', '1945-1947', '1930-1945', '1950-1955'],
        correctIndex: 0),
    QuestionModel(
        question: "Hari Kebangkitan Nasional diperingati pada tanggal...",
        options: ['20 Mei', '10 November', '17 Agustus', '1 Juni'],
        correctIndex: 0),
    QuestionModel(
        question: "Sumpah Pemuda berisi tekad untuk...",
        options: ['Satu tanah air, satu bangsa, satu bahasa', 'Merdeka dari Belanda', 'Menjadi negara republik', 'Menghapus penjajah'],
        correctIndex: 0),
    QuestionModel(
        question: "Belanda menyerah secara resmi melalui...",
        options: ['Konferensi Meja Bundar', 'Perjanjian Linggarjati', 'Proklamasi', 'Sumpah Pemuda'],
        correctIndex: 0),
    QuestionModel(
        question: "Agresi Militer Belanda I terjadi pada tahun...",
        options: ['1947', '1945', '1949', '1950'],
        correctIndex: 0),
  ],

  // ---------------- HARD ----------------
  "hard": [
    QuestionModel(
        question: "Siapa perdana menteri pertama RIS?",
        options: ['Mohammad Hatta', 'Sutan Syahrir', 'Soekarno', 'Ahmad Yani'],
        correctIndex: 1),
    QuestionModel(
        question: "Deklarasi Djuanda berlangsung pada tahun...",
        options: ['1957', '1945', '1960', '1950'],
        correctIndex: 0),
    QuestionModel(
        question: "Perjanjian Renville ditandatangani antara Indonesia dan...",
        options: ['Belanda', 'Inggris', 'Amerika', 'Jepang'],
        correctIndex: 0),
    QuestionModel(
        question: "UU dasar 1945 diamandemen pertama kali pada tahun...",
        options: ['1999', '1945', '2000', '2002'],
        correctIndex: 0),
    QuestionModel(
        question: "Peristiwa Trikora berkaitan dengan wilayah...",
        options: ['Irian Barat', 'Aceh', 'Papua Nugini', 'Maluku'],
        correctIndex: 0),
    QuestionModel(
        question: "Peristiwa G30S menewaskan jenderal...",
        options: ['Ahmad Yani', 'Soeharto', 'Nasution', 'Suharto'],
        correctIndex: 0),
    QuestionModel(
        question: "Konferensi Asia-Afrika berlangsung di kota...",
        options: ['Bandung', 'Jakarta', 'Yogyakarta', 'Surabaya'],
        correctIndex: 0),
    QuestionModel(
        question: "Hari Pahlawan lahir dari peristiwa di kota...",
        options: ['Surabaya', 'Jakarta', 'Bandung', 'Malang'],
        correctIndex: 0),
    QuestionModel(
        question: "Sistem politik liberal diterapkan di Indonesia pada tahun...",
        options: ['1950-1959', '1945-1950', '1965-1966', '1959-1965'],
        correctIndex: 0),
    QuestionModel(
        question: "Deklarasi Kemerdekaan Filipina terjadi sebelum Indonesia, tahun...",
        options: ['1898', '1900', '1945', '1875'],
        correctIndex: 0),
  ],
};
