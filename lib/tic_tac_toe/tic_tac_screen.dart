import 'package:gimix/tic_tac_toe/utils.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String playerXName;
  final String playerOName;

  const MainPage({
    Key? key,
    required this.playerXName,
    required this.playerOName,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class Player {
  static const none = '';
  static const X = 'X';
  static const O = 'O';
}

class _MainPageState extends State<MainPage> {
  static const countMatrix = 3;
  static const double size = 92;

  String lastMove = Player.none;
  late List<List<String>> matrix;
  int scoreX = 0;
  int scoreO = 0;

  bool isGameFinished = false;

  @override
  void initState() {
    super.initState();
    setEmptyFields();
  }

  void setEmptyFields() {
    setState(() {
      matrix = List.generate(
        countMatrix,
        (_) => List.generate(countMatrix, (_) => Player.none),
      );
      isGameFinished = false;
    });
  }

  Color getBackgroundColor() {
    final thisMove = lastMove == Player.X ? Player.O : Player.X;
    return getFieldColor(thisMove).withAlpha(150);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
    ),
    backgroundColor: getBackgroundColor(),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScoreCard(
              playerName: widget.playerXName,
              playerScore: scoreX,
              playerColor: Colors.red,
            ),
            const SizedBox(width: 20),
            ScoreCard(
              playerName: widget.playerOName,
              playerScore: scoreO,
              playerColor: Colors.blue,
            ),
          ],
        ),
        const SizedBox(height: 20),
        if (isGameFinished) // Tambahkan widget yang ingin ditampilkan jika permainan selesai
          const SizedBox(height: 16),
        ...Utils.modelBuilder(matrix, (x, value) => buildRow(x)),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              colors: [Colors.red, Colors.blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: ElevatedButton(
            onPressed: resetScore,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.transparent, // Set the button background to transparent
              elevation: 0, // Set the elevation to 0 to remove the shadow
            ),
            child: const Text(
              'Reset Score',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // You can set the text color here.
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget buildRow(int x) {
    final values = matrix[x];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: Utils.modelBuilder(
        values,
        (y, value) => buildField(x, y),
      ),
    );
  }

  Color getFieldColor(String value) {
    switch (value) {
      case Player.O:
        return Colors.blue;
      case Player.X:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  Widget buildField(int x, int y) {
    final value = matrix[x][y];
    final color = getFieldColor(value);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          minimumSize: const Size(size, size),
          elevation: 0.0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.black, width: 2),
          ),
        ),
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          if (!isGameFinished) {
            selectField(value, x, y);
          }
        },
      ),
    );
  }

  void selectField(String value, int x, int y) {
    if (value == Player.none) {
      final newValue = lastMove == Player.X ? Player.O : Player.X;

      setState(() {
        lastMove = newValue;
        matrix[x][y] = newValue;
      });

      if (isWinner(newValue, x, y)) {
        showEndDialog('Selamat ${getPlayerName(newValue)} Menang!');
        updateScore(newValue);
      } else if (isEnd()) {
        showEndDialog('Permainan Seri');
      }
    }
  }

  void updateScore(String winner) {
    setState(() {
      if (winner == Player.X) {
        scoreX++;
      } else if (winner == Player.O) {
        scoreO++;
      }
    });
  }

  bool isEnd() =>
      matrix.every((values) => values.every((value) => value != Player.none));

  bool isWinner(String player, int x, int y) {
    const n = countMatrix;

    var col = 0, row = 0, diag = 0, rdiag = 0;
    for (int i = 0; i < n; i++) {
      if (matrix[x][i] == player) col++;
      if (matrix[i][y] == player) row++;
      if (matrix[i][i] == player) diag++;
      if (matrix[i][n - i - 1] == player) rdiag++;
    }

    return row == n || col == n || diag == n || rdiag == n;
  }

  String getPlayerName(String player) {
    if (player == Player.X) {
      return widget.playerXName;
    } else if (player == Player.O) {
      return widget.playerOName;
    } else {
      return '';
    }
  }

  String getLastMovePlayerName() {
    return getPlayerName(lastMove);
  }

  void showEndDialog(String title) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.white, width: 3),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [
                  Colors.red,
                  Colors.blue,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Tekan untuk Mengulang Permainan',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.red, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: ElevatedButton(
                      onPressed: resetGame,
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.transparent, elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        'Restart',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ).then((_) {
      if (isGameFinished) {
        resetGame();
      }
    });
  }

  void resetGame() {
    setState(() {
      setEmptyFields();
      lastMove = Player.none;
      isGameFinished = false;
    });
    Navigator.pop(context);
  }

  void resetScore() {
    setState(() {
      scoreX = 0;
      scoreO = 0;
    });
  }

  int getPlayerScore(String playerName) {
    if (widget.playerXName == playerName) {
      return scoreX;
    } else if (widget.playerOName == playerName) {
      return scoreO;
    } else {
      return 0;
    }
  }
}

class ScoreCard extends StatelessWidget {
  final String playerName;
  final int playerScore;
  final Color playerColor;

  const ScoreCard({
    Key? key,
    required this.playerName,
    required this.playerScore,
    required this.playerColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140, // Set a fixed width for the container to ensure consistent size
      height: 45,
      decoration: BoxDecoration(
        color: playerColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [BoxShadow(color: Colors.black, blurRadius: 3, spreadRadius: 0)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                playerName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                width: playerName.length * 8.0, // Adjust the multiplier as needed
                height: 2,
                color: Colors.white,
              ),
            ],
          ),
          Text(
            playerScore.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
