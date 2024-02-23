import 'package:flutter/material.dart';
import 'package:gimix/first_game/first_game_screen.dart';
import 'package:gimix/memory_game/screen/home.dart';
import 'package:gimix/tic_tac_toe/player_name_screen.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin, RouteAware {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          //padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5433FF), // Purple
                Color(0xFF20BDFF), // Blue
                Color(0xFFA5FECB), // Light Green
                // Colors.black[900]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 50),
              SlideTransition(
                position: _slideAnimation,
                child: buildGameCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirstGameScreen(),
                      ),
                    );
                  },
                  imageAsset: 'assets/images/drag.png',
                  gameTitle: 'Drag and Drop Game',
                  backgroundColor: const Color.fromARGB(255, 255, 112, 91), // Coral color
                ),
              ),
              const SizedBox(height: 20), // Added spacing between game cards
              SlideTransition(
                position: _slideAnimation,
                child: buildGameCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  },
                  imageAsset: 'assets/images/memory.png',
                  gameTitle: 'Memory Game',
                  backgroundColor: const Color.fromARGB(255, 255, 190, 0), // Gold color
                ),
              ),
              const SizedBox(height: 20), // Added spacing between game cards
              SlideTransition(
                position: _slideAnimation,
                child: buildGameCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PlayerNamePage(),
                      ),
                    );
                  },
                  imageAsset: 'assets/images/ttt.png',
                  gameTitle: 'Tic Tac Toe Game',
                  backgroundColor: const Color.fromARGB(255, 255, 27, 27),
                ),
              ),
              const SizedBox(height: 20), // Added spacing between game cards
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGameCard({
    required VoidCallback onTap,
    required String imageAsset,
    required String gameTitle,
    required Color backgroundColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 300,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [backgroundColor, backgroundColor.withOpacity(0.8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(
            color: Colors.white, // Set border color to white
            width: 2, // Set border width
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imageAsset),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  gameTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    shadows: [BoxShadow(color: Colors.black, blurRadius: 3)],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}