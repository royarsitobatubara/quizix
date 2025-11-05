import 'package:quizix/models/question_model.dart';

Map<String, List<QuestionModel>> mathematicsQuestion = {
  // ---------------- EASY ----------------
  "easy": [
    QuestionModel(
        question: "Berapakah 5 + 7?",
        options: ['10', '11', '12', '13'],
        correctIndex: 2),
    QuestionModel(
        question: "Berapakah 9 - 4?",
        options: ['5', '6', '4', '3'],
        correctIndex: 0),
    QuestionModel(
        question: "Berapakah 3 × 4?",
        options: ['7', '12', '14', '9'],
        correctIndex: 1),
    QuestionModel(
        question: "Berapakah 16 ÷ 4?",
        options: ['2', '4', '8', '6'],
        correctIndex: 1),
    QuestionModel(
        question: "Berapakah nilai 7 + 3 × 2?",
        options: ['20', '13', '17', '14'],
        correctIndex: 1),
    QuestionModel(
        question: "Berapakah hasil dari 15 % 4?",
        options: ['3', '2', '4', '1'],
        correctIndex: 0),
    QuestionModel(
        question: "Berapakah akar kuadrat dari 49?",
        options: ['7', '6', '8', '9'],
        correctIndex: 0),
    QuestionModel(
        question: "Berapakah 5²?",
        options: ['10', '20', '25', '30'],
        correctIndex: 2),
    QuestionModel(
        question: "Berapakah 0 + 0?",
        options: ['0', '1', '2', '-1'],
        correctIndex: 0),
    QuestionModel(
        question: "Berapakah 100 ÷ 25?",
        options: ['2', '4', '5', '6'],
        correctIndex: 2),
  ],

  // ---------------- MEDIUM ----------------
  "medium": [
    QuestionModel(
        question: "Berapakah 12 × 12?",
        options: ['124', '144', '154', '134'],
        correctIndex: 1),
    QuestionModel(
        question: "Berapakah 45 ÷ 5 + 3?",
        options: ['12', '11', '10', '13'],
        correctIndex: 3),
    QuestionModel(
        question: "Jika x = 5, berapakah 2x + 7?",
        options: ['15', '17', '20', '12'],
        correctIndex: 1),
    QuestionModel(
        question: "Berapakah 3³?",
        options: ['6', '9', '27', '18'],
        correctIndex: 2),
    QuestionModel(
        question: "Berapakah 50% dari 200?",
        options: ['50', '100', '150', '200'],
        correctIndex: 1),
    QuestionModel(
        question: "Jika y = 4, berapakah y² + 2y?",
        options: ['20', '24', '16', '18'],
        correctIndex: 0),
    QuestionModel(
        question: "Berapakah hasil dari 7 × 8 - 10?",
        options: ['46', '56', '50', '52'],
        correctIndex: 2),
    QuestionModel(
        question: "Berapakah nilai dari 3 × (4 + 5)?",
        options: ['27', '21', '25', '30'],
        correctIndex: 0),
    QuestionModel(
        question: "Berapakah 81 ÷ 9?",
        options: ['8', '9', '7', '10'],
        correctIndex: 1),
    QuestionModel(
        question: "Jika 2x = 14, berapakah x?",
        options: ['6', '7', '8', '12'],
        correctIndex: 1),
  ],

  // ---------------- HARD ----------------
  "hard": [
    QuestionModel(
        question: "Berapakah akar kuadrat dari 256?",
        options: ['14', '16', '18', '20'],
        correctIndex: 1),
    QuestionModel(
        question: "Berapakah 5³ - 4²?",
        options: ['101', '121', '105', '125'],
        correctIndex: 0),
    QuestionModel(
        question: "Jika x + 5 = 12, berapakah nilai x?",
        options: ['5', '7', '8', '6'],
        correctIndex: 1),
    QuestionModel(
        question: "Berapakah 2³ × 3²?",
        options: ['36', '72', '18', '24'],
        correctIndex: 1),
    QuestionModel(
        question: "Berapakah 7² + 24 ÷ 6?",
        options: ['53', '52', '49', '50'],
        correctIndex: 1),
    QuestionModel(
        question: "Jika 3x - 7 = 11, berapakah x?",
        options: ['5', '6', '7', '8'],
        correctIndex: 3),
    QuestionModel(
        question: "Berapakah hasil dari 15 × (2 + 3) ÷ 5?",
        options: ['12', '15', '10', '8'],
        correctIndex: 2),
    QuestionModel(
        question: "Berapakah log₂ 8?",
        options: ['2', '3', '4', '1'],
        correctIndex: 1),
    QuestionModel(
        question: "Jika y² = 49, berapakah y?",
        options: ['6', '7', '-7 & 7', '8'],
        correctIndex: 2),
    QuestionModel(
        question: "Berapakah hasil dari 100 ÷ (5 × 2)?",
        options: ['5', '8', '10', '12'],
        correctIndex: 2),
  ],
};
