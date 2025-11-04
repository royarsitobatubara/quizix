import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quizix/utils/app_colors.dart';

class XoxoGame extends StatefulWidget {
  const XoxoGame({super.key});

  @override
  State<XoxoGame> createState() => _XoxoGameState();
}

class _XoxoGameState extends State<XoxoGame> with SingleTickerProviderStateMixin {
  // board: '' = empty, 'X' or 'O'
  final List<String> _board = List.filled(9, '');
  bool _xTurn = true;
  bool _gameOver = false;
  List<int> _winningLine = [];

  // optional simple scores
  int _scoreX = 0;
  int _scoreO = 0;
  int _draws = 0;

  void _resetBoard({bool keepScore = true}) {
    setState(() {
      for (var i = 0; i < _board.length; i++) {
        _board[i] = '';
      }
      _xTurn = true;
      _gameOver = false;
      _winningLine = [];
      if (!keepScore) {
        _scoreX = 0;
        _scoreO = 0;
        _draws = 0;
      }
    });
  }

  void _makeMove(int index) {
    if (_board[index] != '' || _gameOver) return;

    setState(() {
      _board[index] = _xTurn ? 'X' : 'O';
      _xTurn = !_xTurn;
      final winner = _checkWinner();
      if (winner != null) {
        _gameOver = true;
        if (winner == 'X') _scoreX++;
        if (winner == 'O') _scoreO++;
        _showResultDialog('$winner menang!');
      } else if (!_board.contains('')) {
        // draw
        _gameOver = true;
        _draws++;
        _showResultDialog('Seri!');
      }
    });
  }

  String? _checkWinner() {
    // winning index triplets
    const lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var line in lines) {
      final a = line[0], b = line[1], c = line[2];
      if (_board[a] != '' && _board[a] == _board[b] && _board[a] == _board[c]) {
        setState(() => _winningLine = [a, b, c]);
        return _board[a];
      }
    }
    return null;
  }

  void _showResultDialog(String message) {
    // small delay so user sees final move
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(message),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Score: X $_scoreX  •  O $_scoreO  •  Seri $_draws'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetBoard();
              },
              child: const Text('Main lagi'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetBoard(keepScore: true);
              },
              child: const Text('Reset board'),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCell(int index) {
    final value = _board[index];
    final isWinnerCell = _winningLine.contains(index);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _makeMove(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: isWinnerCell ? (value == 'X' ? Colors.blue[100] : Colors.red[100]) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isWinnerCell ? (value == 'X' ? Colors.blue : Colors.red) : Colors.grey.shade300,
            width: isWinnerCell ? 2.4 : 1.0,
          ),
        ),
        child: Center(
          child: AnimatedScale(
            scale: value == '' ? 1.0 : 1.05,
            duration: const Duration(milliseconds: 180),
            child: Text(
              value,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: value == 'X' ? Colors.blue.shade700 : Colors.red.shade700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _resetBoard();
  }

  // ---------------------------
  // Tambahkan fungsi ini:
  // ---------------------------
  Widget _buildTurnIndicator() {
    final turnLabel = _xTurn ? 'X' : 'O';
    final turnColor = _xTurn ? Colors.blue : Colors.red;
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, anim) => ScaleTransition(scale: anim, child: child),
      child: Row(
        key: ValueKey(turnLabel),
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: turnColor.withValues(alpha: .14),
            child: Text(
              turnLabel,
              style: TextStyle(color: turnColor, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Giliran: $turnLabel',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }
  // ---------------------------

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
        title: const Text('X O - Tic Tac Toe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () => _resetBoard(keepScore: true),
            tooltip: 'Reset board',
            icon: const Icon(Icons.refresh, color: Colors.white),
          ),
          IconButton(
            onPressed: () => _resetBoard(keepScore: false),
            tooltip: 'Reset scores & board',
            icon: const Icon(Icons.delete_forever, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Info bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildScoreChip('X', _scoreX, Colors.blue),
                  _buildTurnIndicator(),
                  _buildScoreChip('O', _scoreO, Colors.red),
                ],
              ),
              const SizedBox(height: 20),
              // Board
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .03), blurRadius: 8)],
                  ),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: 9,
                    itemBuilder: (_, i) => _buildCell(i),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _xTurn = true;
                        _resetBoard(keepScore: true);
                      });
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Mulai ulang (X)'),
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.lightBlue),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _xTurn = false;
                        _resetBoard(keepScore: true);
                      });
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Mulai ulang (O)'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text('Seri: $_draws', style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreChip(String label, int score, Color color) {
    return Chip(
      backgroundColor: color.withValues(alpha: .12),
      label: Row(
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Text('$score', style: TextStyle(color: color)),
        ],
      ),
    );
  }
}
