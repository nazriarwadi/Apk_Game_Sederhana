import 'package:audioplayers/audioplayers.dart';
import 'package:gimix/memory_game/data/data.dart';
import 'package:flutter/material.dart';
import 'package:gimix/memory_game/model/title_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TileModel> gridViewTiles = <TileModel>[];
  List<TileModel> questionPairs = <TileModel>[];
  int points = 0;
  bool selected = false;
  bool showCongratulationMessage = false;
  bool showTryAgainMessage = false;
  int wrongAttempts = 0;
  String selectedTile = "";
  int? selectedIndex;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    reStart();
  }

  void reStart() {
    myPairs = getPairs();
    myPairs.shuffle();

    gridViewTiles = myPairs;
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        questionPairs = getQuestionPairs();
        gridViewTiles = questionPairs;
        selected = false;
      });
    });
  }

  void updatePoints() {
    setState(() {
      points = points + 100;
      if (points == 800) {
        showTryAgainMessage = false;
        player.play(AssetSource('audio/success.wav')); // Play victory sound // Play victory sound
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.transparent, // Set background color to transparent
              content: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.orange[500]!,
                      Colors.orange[900]!,
                      Colors.deepOrange[900]!,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white, width: 2),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Congratulations!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "You've completed the game!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        replayGame();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      child: const Text(
                        "Replay",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    });
  }

  void replayGame() {
    setState(() {
      points = 0;
      wrongAttempts = 0;
      showCongratulationMessage = false;
      showTryAgainMessage = false;
      reStart();
    });
  }

  Color _getChancesColor() {
    if (wrongAttempts >= 2) {
      return Colors.red;
    } else if (wrongAttempts >= 2) {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

  void _showGameOverDialog() {
    player.play(AssetSource('audio/tryAgain.wav')); // Play victory sound // Play defeat sound
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange[500]!,
                  Colors.orange[900]!,
                  Colors.deepOrange[900]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white, width: 2)
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Game Over",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "You've lost all your chances!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    replayGame();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:const BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const Text(
                    "Replay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void checkGameOver() {
    if (wrongAttempts >= 5) {
      setState(() {
        showTryAgainMessage = true;
        showCongratulationMessage = false;
        _showGameOverDialog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange[500]!,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.blue[800],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[700]!.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              const SizedBox(width: 4),
              const Text(
                'Score:',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '$points',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                '/ 800',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.orange[500]!,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange[500]!,
              Colors.orange[900]!,
              Colors.deepOrange[900]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Updated UI for "Chances remaining" text using RichText
              Card(
                color: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(color: Colors.white, width: 2),
                ),
                elevation: 6, // Added elevation for the shadow effect
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      children: [
                        const TextSpan(
                          text: 'Chances remaining: ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: '${6 - wrongAttempts}',
                          style: TextStyle(
                            color: _getChancesColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              points < 800
                  ? GridView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 10.0,
                        maxCrossAxisExtent: 100.0,
                      ),
                      children: List.generate(gridViewTiles.length, (index) {
                        return Tile(
                          imagePathUrl: gridViewTiles[index].getImageAssetPath(),
                          tileIndex: index,
                          parent: this,
                          updatePoints: () => updatePoints(),
                          selected: selected,
                        );
                      }),
                    )
                  : const Column(),
            ],
          ),
        ),
      ),
    );
  }
}

class Tile extends StatefulWidget {
  final String? imagePathUrl;
  final int? tileIndex;
  final _HomeState parent;
  final void Function() updatePoints;
  final bool selected;

  const Tile({
    Key? key,
    this.imagePathUrl,
    this.tileIndex,
    required this.parent,
    required this.updatePoints,
    required this.selected,
  }) : super(key: key);

  @override
  _TileState createState() => _TileState();
}

class _TileState extends State<Tile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.selected) {
          setState(() {
            myPairs[widget.tileIndex!].setIsSelected(true);
          });
          if (selectedTile != "") {
            if (selectedTile == myPairs[widget.tileIndex!].getImageAssetPath()) {
              points = points + 100;
              TileModel tileModel = TileModel();
              selected = true;
              Future.delayed(const Duration(seconds: 1), () {
                tileModel.setImageAssetPath("");
                myPairs[widget.tileIndex!] = tileModel;
                myPairs[selectedIndex!] = tileModel;
                widget.updatePoints();
                widget.parent.setState(() {});
                setState(() {
                  selected = false;
                });
                selectedTile = "";
              });
            } else {
              selected = true;
              Future.delayed(const Duration(seconds: 1), () {
                widget.parent.setState(() {
                  myPairs[widget.tileIndex!].setIsSelected(false);
                  myPairs[selectedIndex!].setIsSelected(false);
                });
                setState(() {
                  selected = false;
                });
                selectedTile = "";
                widget.parent.checkGameOver();
                widget.parent.wrongAttempts++;
              });
            }
          } else {
            setState(() {
              selectedTile = myPairs[widget.tileIndex!].getImageAssetPath()!;
              selectedIndex = widget.tileIndex;
            });
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.white, width: 2),
          color: widget.selected
              ? Colors.orange[500]
              : Colors.blue[800],
        ),
        child: Center(
          child: myPairs[widget.tileIndex!].getImageAssetPath() != ""
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    myPairs[widget.tileIndex!].getIsSelected()!
                        ? myPairs[widget.tileIndex!].getImageAssetPath()!
                        : widget.imagePathUrl!,
                    fit: BoxFit.fill,
                  ),
                )
              : Image.asset(
                  "assets/images/check.png",
                  fit: BoxFit.fitHeight,
                ),
        ),
      ),
    );
  }
}
