import 'package:flutter/material.dart';
import '/screens/connecter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Background Image
          Image.asset(
            'assets/background.jfif', // Replace with your actual image path
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.6, 1.0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Game Title
                const Text(
                  'ImunoWarriors',
                  style: TextStyle(
                    fontFamily: 'Roboto', // You can use a custom font
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Description Text
                const Text(
                  'Plongez au cœur de la bataille microscopique ! Votre armée immunitaire attend vos ordres pour repousser l\'invasion. Devenez le commandant qui mènera vos défenses à la victoire contre les menaces.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                const SizedBox(height: 40.0),
                // Play Button
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the game screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ConnecterScreen(),
                      ), // Replace with your actual game screen
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade300.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60.0,
                      vertical: 15.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'jouer maintenant',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
