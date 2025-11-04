import 'package:quizix/models/question_model.dart';

Map<String, List<QuestionModel>> physicsQuestion = {
  // ------------------- EASY -------------------
  "easy": [
    QuestionModel(
      question: "Besaran pokok SI untuk waktu adalah...",
      options: ["Sekon", "Meter", "Kilogram", "Candela"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Gaya diukur menggunakan satuan...",
      options: ["Joule", "Newton", "Watt", "Pascal"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Alat ukur panjang adalah...",
      options: ["Termometer", "Jangka sorong", "Barometer", "Higrometer"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Energi yang tersimpan disebut...",
      options: ["Potensial", "Kinetik", "Termal", "Listrik"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Gaya gravitasi bekerja ke arah...",
      options: ["Atas", "Samping", "Bawah", "Tidak tentu"],
      correctIndex: 2,
    ),
    QuestionModel(
      question: "Kecepatan adalah perpindahan per satuan...",
      options: ["Massa", "Gaya", "Waktu", "Energi"],
      correctIndex: 2,
    ),
    QuestionModel(
      question: "Hukum I Newton disebut juga...",
      options: ["Hukum aksi-reaksi", "Hukum kelembaman", "Hukum energi", "Hukum cahaya"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Satuan listrik arus adalah...",
      options: ["Volt", "Ohm", "Coulomb", "Ampere"],
      correctIndex: 3,
    ),
    QuestionModel(
      question: "Gaya gesek terjadi pada permukaan yang...",
      options: ["Kasar", "Licin", "Rata", "Tidak bermassa"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Energi kinetik bergantung pada kecepatan dan...",
      options: ["Volume", "Massa", "Tekanan", "Usaha"],
      correctIndex: 1,
    ),
  ],

  // ------------------- MEDIUM -------------------
  "medium": [
    QuestionModel(
      question: "Usaha didefinisikan sebagai gaya dikali...",
      options: ["Kecepatan", "Jarak", "Massa", "Waktu"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Momentum bergantung pada kecepatan dan...",
      options: ["Volume", "Massa", "Usaha", "Energi"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Jenis lensa untuk rabun jauh adalah...",
      options: ["Cembung", "Cekung", "Plano", "Datar"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Hukum Ohm menyatakan V =...",
      options: ["I / R", "IR", "R / I", "I + R"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Konversi energi pada kipas angin adalah...",
      options: ["Listrik ke gerak", "Gerak ke panas", "Kimia ke cahaya", "Panas ke bunyi"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Hambatan listrik diukur dalam satuan...",
      options: ["Ohm", "Volt", "Ampere", "Newton"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Hukum kekekalan energi menyatakan bahwa...",
      options: ["Energi hilang", "Energi dapat diciptakan", "Energi kekal", "Energi menjadi massa"],
      correctIndex: 2,
    ),
    QuestionModel(
      question: "Pada bidang miring, keuntungan mekanik dapat...",
      options: ["Menaikkan gaya", "Mengurangi usaha", "Membuat lebih cepat", "Mengurangi massa"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Perpindahan panas secara perambatan disebut...",
      options: ["Konduksi", "Konveksi", "Radiasi", "Difusi"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Kecepatan akhir benda jatuh bebas dipengaruhi oleh...",
      options: ["Waktu", "Warna", "Bentuk", "Jenis bahan"],
      correctIndex: 0,
    ),
  ],

  // ------------------- HARD -------------------
  "hard": [
    QuestionModel(
      question: "Usaha bernilai nol jika arah gaya terhadap perpindahan...",
      options: ["Sejajar", "Berlawanan", "Tegak lurus", "Searah"],
      correctIndex: 2,
    ),
    QuestionModel(
      question: "Frekuensi berbanding terbalik dengan...",
      options: ["Amplitudo", "Waktu", "Periode", "Fase"],
      correctIndex: 2,
    ),
    QuestionModel(
      question: "Hukum Newton III menyatakan...",
      options: [
        "F = ma",
        "Aksi = reaksi",
        "Energi kekal",
        "Momentum tetap"
      ],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Gelombang longitudinal merambat...",
      options: [
        "Sejajar arah getaran",
        "Tegak lurus arah getaran",
        "Berlawanan arah getaran",
        "Tanpa arah"
      ],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Arus listrik disebabkan oleh aliran...",
      options: ["Neutron", "Elektron", "Proton", "Ion positif"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Intensitas bunyi berbanding terbalik dengan...",
      options: ["Suhu", "Jarak kuadrat", "Massa", "Volume"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Induksi elektromagnetik ditemukan oleh...",
      options: ["Faraday", "Curie", "Bohr", "Pascal"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Transformator bekerja berdasarkan...",
      options: ["Induksi", "Konduksi", "Konveksi", "Radiasi"],
      correctIndex: 0,
    ),
    QuestionModel(
      question: "Energi mekanik adalah gabungan energi kinetik dan...",
      options: ["Massa", "Potensial", "Volume", "Tekanan"],
      correctIndex: 1,
    ),
    QuestionModel(
      question: "Kecepatan gelombang = ...",
      options: ["Frekuensi x panjang gelombang", "Amplitudo x panjang", "Massa x kecepatan", "Usaha / waktu"],
      correctIndex: 0,
    ),
  ],
};
