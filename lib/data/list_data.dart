import 'package:quizix/models/list_model.dart';
import 'package:quizix/utils/app_images.dart';
import 'package:quizix/data/question/biology.dart';
import 'package:quizix/data/question/chemistry.dart';
import 'package:quizix/data/question/history.dart';
import 'package:quizix/data/question/informatics.dart';
import 'package:quizix/data/question/physics.dart';
import 'package:quizix/data/question/mathematics.dart';
import 'package:quizix/data/question/science.dart';
import 'package:quizix/models/question_model.dart';

// LIST BOOKMARK SCREEN
final List<ListModel> allQuestion = [
  ListModel(
      image: AppImages.informatics,
      title: 'informatics',
      route: '/question/informatics'
  ),
  ListModel(
      image: AppImages.chemistry,
      title: 'chemistry',
      route: '/question/chemistry'
  ),
  ListModel(
      image: AppImages.physics,
      title: 'physics',
      route: '/question/physics'
  ),
  ListModel(
      image: AppImages.biology,
      title: 'biology',
      route: '/question/biology'
  ),
  ListModel(
      image: AppImages.mathematics,
      title: 'mathematics',
      route: '/question/mathematics'
  ),
  ListModel(
      image: AppImages.history,
      title: 'history',
      route: '/question/history'
  ),
  ListModel(
      image: AppImages.science,
      title: 'science',
      route: '/question/science'
  ),
];

List<QuestionModel> getQuestion(String category, String level) {
  final categoryMap = {
    "informatics": informaticsQuestion,
    "biology": biologyQuestion,
    "physics": physicsQuestion,
    "mathematics": mathematicsQuestion,
    "chemistry": chemistryQuestion,
    "history": historyQuestion,
    "science": scienceQuestion
  };
  final selectedCategory = categoryMap[category];
  if (selectedCategory == null) return [];

  return selectedCategory[level] ?? [];
}

// LIST HOME SCREEN
final List<ListModel> allQuestionPrimary = [
  ListModel(
      image: AppImages.informatics,
      title: 'informatics',
      route: '/question/informatics'
  ),
  ListModel(
      image: AppImages.mathematics,
      title: 'mathematics',
      route: '/question/mathematics'
  ),
  ListModel(
      image: AppImages.physics,
      title: 'physics',
      route: '/question/physics'
  ),
  ListModel(
      image: AppImages.chemistry,
      title: 'chemistry',
      route: '/question/chemistry'
  ),
];

// BUAT DAFTAR GAME
final List<ListModel> gameList = [
  ListModel(
      image: AppImages.xoxo,
      title: 'tictactoe',
      route: '/game/xoxo'
  ),
  ListModel(
      image: AppImages.guestNumber,
      title: 'guest_number',
      route: '/game/guest-number'
  ),
  ListModel(
      image: AppImages.snake,
      title: 'snake',
      route: '/game/snake'
  ),
];