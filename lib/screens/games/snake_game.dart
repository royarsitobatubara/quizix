import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/utils/app_colors.dart';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  static const int _rowCount = 20;
  static const int _colCount = 20;
  static const Duration _tick = Duration(milliseconds: 200);

  List<Point<int>> _snake = [const Point(10, 10)];
  Point<int> _food = const Point(5, 5);
  String _direction = "right";
  int _score = 0;
  Timer? _timer;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      _snake = [const Point(10, 10)];
      _food = _randomFood();
      _direction = "right";
      _score = 0;
      _gameOver = false;
    });

    _timer?.cancel();
    _timer = Timer.periodic(_tick, (_) => _moveSnake());
  }

  Point<int> _randomFood() {
    final rand = Random();
    Point<int> newFood;
    do {
      newFood = Point(rand.nextInt(_colCount), rand.nextInt(_rowCount));
    } while (_snake.contains(newFood));
    return newFood;
  }

  void _moveSnake() {
    if (_gameOver) return;

    final head = _snake.first;
    Point<int> newHead;

    switch (_direction) {
      case "up":
        newHead = Point(head.x, head.y - 1);
        break;
      case "down":
        newHead = Point(head.x, head.y + 1);
        break;
      case "left":
        newHead = Point(head.x - 1, head.y);
        break;
      default:
        newHead = Point(head.x + 1, head.y);
        break;
    }

    // Check collision
    if (
    newHead.x < 0 || newHead.y < 0 ||
        newHead.x >= _colCount || newHead.y >= _rowCount ||
        _snake.contains(newHead)
    ) {
      _endGame();
      return;
    }

    setState(() {
      _snake.insert(0, newHead);
      if (newHead == _food) {
        _score++;
        _food = _randomFood();
      } else {
        _snake.removeLast();
      }
    });
  }

  void _endGame() {
    _timer?.cancel();
    setState(() => _gameOver = true);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Game Over 😢"),
        content: Text("Skor kamu: $_score"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startGame();
            },
            child: const Text("Main Lagi"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.pop(); // balik ke menu
            },
            child: const Text("Keluar"),
          ),
        ],
      ),
    );
  }

  void _changeDirection(String newDirection) {
    if (_gameOver) return;
    // mencegah balik arah 180 derajat langsung
    if ((_direction == "up" && newDirection == "down") ||
        (_direction == "down" && newDirection == "up") ||
        (_direction == "left" && newDirection == "right") ||
        (_direction == "right" && newDirection == "left")) {
      return;
    }
    setState(() => _direction = newDirection);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildGrid() {
    List<Widget> cells = [];
    for (int y = 0; y < _rowCount; y++) {
      for (int x = 0; x < _colCount; x++) {
        final point = Point(x, y);
        Color color;
        if (_snake.first == point) {
          color = Colors.greenAccent.shade400;
        } else if (_snake.contains(point)) {
          color = Colors.green.shade600;
        } else if (_food == point) {
          color = Colors.redAccent;
        } else {
          color = Colors.grey.shade200;
        }
        cells.add(Container(
          margin: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ));
      }
    }
    return GridView.count(
      crossAxisCount: _colCount,
      physics: const NeverScrollableScrollPhysics(),
      children: cells,
    );
  }

  Widget _buildControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          iconSize: 40,
          onPressed: () => _changeDirection("up"),
          icon: const Icon(Icons.keyboard_arrow_up),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 40,
              onPressed: () => _changeDirection("left"),
              icon: const Icon(Icons.keyboard_arrow_left),
            ),
            const SizedBox(width: 30),
            IconButton(
              iconSize: 40,
              onPressed: () => _changeDirection("right"),
              icon: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
        IconButton(
          iconSize: 40,
          onPressed: () => _changeDirection("down"),
          icon: const Icon(Icons.keyboard_arrow_down),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.lightBlue,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 26, color: Colors.white),
        ),
        title: const Text('🐍 Snake Game', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text("Skor: $_score", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: _buildGrid(),
              ),
            ),
            const SizedBox(height: 10),
            _buildControls(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
