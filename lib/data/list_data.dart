import 'package:quizix/models/list_model.dart';
import 'package:quizix/utils/app_images.dart';

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
      title: 'Science',
      route: '/question/science'
  ),
];



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