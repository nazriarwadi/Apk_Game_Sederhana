import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'item_model.dart';

// ignore: constant_identifier_names
enum Result { Awesome, TryAgain }

class FirstGameScreen extends StatefulWidget {
  const FirstGameScreen({Key? key}) : super(key: key);

  @override
  _FirstGameScreenState createState() => _FirstGameScreenState();
}

class _FirstGameScreenState extends State<FirstGameScreen> {
  late List<ItemModel> items;
  late List<ItemModel> items2;
  late int score;
  late bool gameOver;
  final AudioPlayer player = AudioPlayer();

  void checkGameStatus() {
    if (score >= 140) {
      // Player wins
      _showGameDialog(Result.Awesome);
      player.play(AssetSource('audio/success.wav')); // Play victory sound
    } else if (items.isEmpty && items2.isEmpty) {
      // Player loses
      _showGameDialog(Result.TryAgain);
      player.play(AssetSource('audio/tryAgain.wav')); // Play victory sound
    }
  }

  void _showGameDialog(Result result) {
    String title = '';
    String message = '';

    switch (result) {
      case Result.Awesome:
        title = 'Congratulations!';
        message = 'You\'ve completed the game!';
        break;
      case Result.TryAgain:
        title = 'Game Over';
        message = 'You lost the game!';
        break;
    }
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 2),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    resetGame();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrangeAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side:const BorderSide(color: Colors.white, width: 2)
                    ),
                  ),
                  child: const Text(
                    'Restart',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  initGame() {
    gameOver = false;
    score = 0;
    items = [
      ItemModel(value: 'cat', name: 'Cat', img: 'assets/images/cat.png'),
      ItemModel(value: 'chicken', name: 'Chicken', img: 'assets/images/chicken.png'),
      ItemModel(value: 'cow', name: 'Cow', img: 'assets/images/cow.png'),
      ItemModel(value: 'crocodile', name: 'Crocodile', img: 'assets/images/crocodile.png'),
      ItemModel(value: 'dog', name: 'Dog', img: 'assets/images/dog.png'),
      ItemModel(value: 'elephant', name: 'Elephant', img: 'assets/images/elephant.png'),
      ItemModel(value: 'giraffe', name: 'Giraffe', img: 'assets/images/giraffe.png'),
      ItemModel(value: 'goat', name: 'Goat', img: 'assets/images/goat.png'),
      ItemModel(value: 'horse', name: 'Horse', img: 'assets/images/horse.png'),
      ItemModel(value: 'panda_bear', name: 'Panda', img: 'assets/images/panda-bear.png'),
      ItemModel(value: 'penguin', name: 'Penguin', img: 'assets/images/penguin.png'),
      ItemModel(value: 'snake', name: 'Snake', img: 'assets/images/snake.png'),
      ItemModel(value: 'whale', name: 'Whale', img: 'assets/images/whale.png'),
      ItemModel(value: 'zebra', name: 'Zebra', img: 'assets/images/zebra.png'),
      // ... (rest of the item models)
    ];
    items2 = List<ItemModel>.from(items);

    items.shuffle();
    items2.shuffle();
  }

  @override
  void initState() {
    super.initState();
    initGame();
  }

  void resetGame() {
    setState(() {
      initGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[900],
        elevation: 0.0,
        actions: [
          Expanded(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 6,
                      offset: const Offset(3, 6),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Score: $score',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // IconButton(
          //   icon: const Icon(Icons.restart_alt),
          //   onPressed: resetGame,
          // ),
        ],
      ),
      backgroundColor: Colors.indigo[900]!,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo[900]!,
              Colors.blue[900]!,
              Colors.lightBlue[700]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                if (!gameOver) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildDraggableItems(),
                      buildDragTargets(),
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDraggableItems() {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            return Draggable<ItemModel>(
              data: items[index],
              childWhenDragging: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(items[index].img!),
              ),
              feedback: SizedBox(
                height: 100,
                width: 100,
                child: Image.asset(items[index].img!),
              ),
              child: SizedBox(
                height: 100,
                width: 100,
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(items[index].img!),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildDragTargets() {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: items2.length,
            itemBuilder: (context, index) {
              return DragTarget<ItemModel>(
                onAccept: (receivedItem) {
                  if (items2[index].value == receivedItem.value) {
                    setState(() {
                      items.remove(receivedItem);
                      items2.removeAt(index);
                    });
                    score += 10;
                    player.play(AssetSource('audio/true.wav')); // Play victory sound
                    if (items.isEmpty && items2.isEmpty) {
                      setState(() {
                        gameOver = true;
                        checkGameStatus(); // Add this line to check game status after all items are matched
                      });
                    } else{
                      checkGameStatus(); // Add this line to check game status after each move
                    }
                  } else {
                    setState(() {
                      score -= 5;
                    });
                    player.play(AssetSource('audio/false.wav')); // Play victory sound
                    checkGameStatus(); // Add this line to check game status after each move
                  }
                },
                onWillAccept: (receivedItem) {
                  return true;
                },
                onLeave: (receivedItem) {},
                builder: (context, acceptedItems, rejectedItems) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: items2[index].accepting ? Colors.blue[800] : Colors.blue[300],
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 50, 47, 47).withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 6,
                            offset: const Offset(3, 6),
                          ),
                        ],
                      ),
                      child: Text(
                        items2[index].name!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
