import 'package:go_router/go_router.dart';
import 'package:quizix/screens/account_list_screen.dart';
import 'package:quizix/screens/create_on_screen.dart';
import 'package:quizix/screens/detail_history_screen.dart';
import 'package:quizix/screens/developer_screen.dart';
import 'package:quizix/screens/edit_name_screen.dart';
import 'package:quizix/screens/edit_password_screen.dart';
import 'package:quizix/screens/edit_picture_screen.dart';
import 'package:quizix/screens/games/guest_number_game.dart';
import 'package:quizix/screens/games/snake_game.dart';
import 'package:quizix/screens/games/xoxo_game.dart';
import 'package:quizix/screens/language_screen.dart';
import 'package:quizix/screens/layout/layout_home.dart';
import 'package:quizix/screens/login_screen.dart';
import 'package:quizix/screens/profile_screen.dart';
import 'package:quizix/screens/question_screen.dart';
import 'package:quizix/screens/question_setting_screen.dart';
import 'package:quizix/screens/register_screen.dart';
import 'package:quizix/screens/result_screen.dart';
import 'package:quizix/screens/setting_screen.dart';
import 'package:quizix/screens/splash_screen.dart';
import 'package:quizix/screens/validate_password_screen.dart';

class AppRoutes {
  final GoRouter router = GoRouter(
      initialLocation: '/splash',
      routes: [
        GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
        GoRoute(path: '/home', builder: (context, state) => LayoutHome()),

      // QUESTION
        GoRoute(path: '/question/:lesson', builder: (context, state) {
          final lesson = state.pathParameters['lesson']!.toString();
          return QuestionSettingScreen(lesson: lesson,);
        }),
        GoRoute(path: '/question/:lesson/:level', builder: (context, state) {
          final lesson = state.pathParameters['lesson']!.toString();
          final level = state.pathParameters['level']!.toString();
          return QuestionScreen(lesson: lesson, level: level,);
        }),
        GoRoute(
          path: '/result',
          builder: (context, state) {
            final data = state.extra as Map<String,  dynamic>;
            final correct = data['correct'];
            final wrong = data['wrong'];
            final score = data['score'];
            final skip = data['skip'];
            return ResultScreen(correct: correct, wrong: wrong, score: score,skip: skip,);
          },
        ),
        GoRoute(
          path: '/detail-history',
          builder: (context, state) {
            final data = state.extra as Map<String, String>;
            return DetailHistoryScreen(
              historyId: data['historyId'].toString(),
              image: data['image'].toString(),
              lesson: data['lesson'].toString(),
            );
          },
        ),

      // AUTH
        GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
        GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),

      // SETTING
        GoRoute(path: '/settings', builder: (context, state) => const SettingScreen()),
        GoRoute(path: '/create-on', builder: (context, state) => const CreateOnScreen()),
        GoRoute(path: '/developer', builder: (context, state) => const DeveloperScreen()),
        GoRoute(path: '/language', builder: (context, state) => LanguageScreen()),
        GoRoute(path: '/list-account', builder: (context, state) => AccountListScreen()),

      //  ACCOUNT
        GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
        GoRoute(path: '/edit-photo', builder: (context, state) => const EditPictureScreen()),
        GoRoute(path: '/edit-name', builder: (context, state) => const EditNameScreen()),
        GoRoute(path: '/edit-password', builder: (context, state) => const EditPasswordScreen()),
        GoRoute(path: '/validate-password', builder: (context, state){
          final data = state.extra as Map<String, String>;
          return ValidatePasswordScreen(email: data['email'].toString(), password: data['password'].toString());
        }),
        GoRoute(path: '/list-account', builder: (context, state) => AccountListScreen()),

      //  GAME
        GoRoute(path: '/game/xoxo', builder: (context, state) => const XoxoGame()),
        GoRoute(path: '/game/snake', builder: (context, state) => const SnakeGame()),
        GoRoute(path: '/game/guest-number', builder: (context, state) => const GuestNumberGame()),

      ]
  );
}