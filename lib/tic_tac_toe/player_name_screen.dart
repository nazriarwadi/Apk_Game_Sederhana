import 'package:flutter/material.dart';
import 'dart:async';
import 'package:gimix/tic_tac_toe/tic_tac_screen.dart';

class PlayerNamePage extends StatefulWidget {
  const PlayerNamePage({Key? key}) : super(key: key);

  @override
  _PlayerNamePageState createState() => _PlayerNamePageState();
}

class _PlayerNamePageState extends State<PlayerNamePage> {
  final TextEditingController _playerXController = TextEditingController();
  final TextEditingController _playerOController = TextEditingController();

  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[800]!,
        elevation: 0.0,
      ),
      backgroundColor: Colors.red[800]!,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red[800]!,
              Colors.red[300]!,
              Colors.blue[800]!,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center( // Center content vertically and horizontally
          child: SingleChildScrollView( // Wrap the content with SingleChildScrollView
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
                children: [
                  const Text(
                    'Tic Tac Toe',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 8,
                              blurRadius: 16,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/ttt.png',
                        width: 120,
                        height: 120,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _playerXController,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: 'Nama Pemain X',
                      labelStyle: const TextStyle(color: Colors.black87),
                      filled: true,
                      fillColor: Colors.white10, // Slightly darker shade of grey
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 2), // Green border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 2), // Green border when focused
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red, width: 2), // Red border when there's an error
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red, width: 2), // Red border when there's an error and focused
                      ),
                      // Custom suffix icon to add a clear button
                      suffixIcon: IconButton(
                        onPressed: () {
                          _playerXController.clear();
                        },
                        icon: const Icon(Icons.clear, color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _playerOController,
                    style: const TextStyle(color: Colors.black87),
                    decoration: InputDecoration(
                      labelText: 'Nama Pemain O',
                      labelStyle: const TextStyle(color: Colors.black87),
                      filled: true,
                      fillColor: Colors.white10, // Slightly darker shade of grey
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 2), // Green border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white, width: 2), // Green border when focused
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red, width: 2), // Red border when there's an error
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red, width: 2), // Red border when there's an error and focused
                      ),
                      // Custom suffix icon to add a clear button
                      suffixIcon: IconButton(
                        onPressed: () {
                          _playerOController.clear();
                        },
                        icon: const Icon(Icons.clear, color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (errorText.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        errorText,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  const SizedBox(height: 18),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [
                          Colors.red,
                          Colors.blue,
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      border: Border.all(width: 2, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        final String playerXName = _playerXController.text;
                        final String playerOName = _playerOController.text;
                        if (playerXName.isEmpty || playerOName.isEmpty) {
                          setState(() {
                            errorText = 'Anda tidak bisa memulai permainan jika belum mengisi nama pemain';
                          });
                          // Start a timer to hide the error message after 5 seconds
                          Timer(const Duration(seconds: 3), () {
                            setState(() {
                              errorText = '';
                            });
                          });
                        } else {
                          setState(() {
                            errorText = '';
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(
                                playerXName: playerXName,
                                playerOName: playerOName,
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Set the button background to transparent
                        elevation: 0, // Set the elevation to 0 to remove the shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Start',
                        style: TextStyle(
                          fontSize: 20, // Slightly increased font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),     
    );
  }

  @override
  void dispose() {
    _playerXController.dispose();
    _playerOController.dispose();
    super.dispose();
  }
}