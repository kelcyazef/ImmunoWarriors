import 'package:flutter/material.dart';
import 'tableau_screen.dart'; // Importez le fichier tableau.dart
import '/screens/inscrire.dart';

class ConnecterScreen extends StatelessWidget {
  const ConnecterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
            Color.fromARGB(255, 47, 94, 79),
              Color.fromARGB(255, 40, 57, 87),  // Couleur de fin de gradient (bleu foncé)
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Se Connecter',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrangeAccent, // Couleur du titre
                ),
              ),
              const SizedBox(height: 40.0),
              // Champ Email
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Entrez votre Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                      filled: true,
                  fillColor: const Color(0xFF3058A2), // Couleur de fond modifiée
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.email, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              // Champ Mot de passe
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  hintText: 'Entrez votre mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF3058A2), // Fond semi-transparent
                  labelStyle: const TextStyle(color: Colors.white),
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.lock, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30.0),
              // Bouton Se Connecter
              ElevatedButton(
                onPressed: () {
                  // Utiliser Navigator.push pour aller à l'écran TableauScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const TableauScreen(), // Utilisez TableauScreen ici
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent, // Couleur du bouton
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Se Connecter',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              // Lien Inscription
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Pas de compte ? ',
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Utiliser Navigator.push pour aller à l'écran SinscrireScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SinscrireScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'S\'inscrire',
                      style: TextStyle(
                        color: Colors.blue, // Couleur du lien
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
