import 'package:flutter/material.dart';
// Importez les fichiers de vos écrans
import 'homescreen.dart'; // Assurez-vous que le chemin est correct
import 'bio-forge.dart'; // Assurez-vous que le chemin est correct (nom du fichier en minuscules)
import 'scannerscreen.dart'; // Assurez-vous que le chemin est correct
import 'laboratoire.dart'; // Importez le LaboratoireRechercheScreen
import '/screens/selection.dart'; // Importez le nouvel écran de sélection
import 'archive.dart';

class TableauScreen extends StatelessWidget {
  const TableauScreen({super.key});

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
              Color.fromARGB(255, 40, 57, 87),   // Bleu foncé
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(height: 20.0),
                    // Ressources Défensives
                    GestureDetector( // Rendre cliquable
                      onTap: () {
                        // Naviguer vers l'écran des ressources défensives
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RessourcesDefensivesScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ressources Défensives',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Energie   1500/2000',
                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                            ),
                            Text(
                              'Bio-Materiaux   1500/2000',
                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Mémoire Immunitaire
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mémoire Immunitaire',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'signatures connues   2',
                            style: TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          Text(
                            'points recherche   10',
                            style: TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // BaseVirale
                    GestureDetector( // Rendre cliquable pour naviguer vers SelectionScreen
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SelectionScreen(), // Naviguer vers SelectionScreen
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alerte! BaseVirale 'ViroX' vous a attaqué! - Défense réussie.",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.yellowAccent),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Nouvelle BaseVirale détectée',
                              style: TextStyle(fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // Conseil de l'Analyste IA (Gemini)
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Conseil de l\'Analyste IA (Gemini)',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyanAccent,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Votre défense est solide, mais pensez à améliorer vos Anticorps Rapides dans le Laboratoire R&D.',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Barre de navigation inférieure
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.0,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const HomeScreen(), // Utiliser la classe HomeScreen
                        ),
                      );
                    },
                    child: _buildBottomNavBarItem(
                      icon: 'assets/home.webp',
                      label: 'Accueil',
                      isActive: true,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ScannerScreen(), // Utiliser la classe ScannerScreen
                        ),
                      );
                    },
                    child: _buildBottomNavBarItem(
                      icon: 'assets/lens.webp',
                      label: 'Scanner',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Laisser la navigation actuelle (pas de changement spécifique ici)
                      // ou naviguer vers une page de combat si vous en avez une.
                      // Exemple:
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CombatScreen(), // Si vous avez une classe CombatScreen
                        ),
                      );
                      */
                    },
                    child: _buildBottomNavBarItem(
                      icon: 'assets/swaur.webp',
                      label: 'Combat',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const BioForgeScreen(), // Utiliser la classe BioForgeScreen
                        ),
                      );
                    },
                    child: _buildBottomNavBarItem(
                      icon: 'assets/tube.webp',
                      label: 'Bio-Forge',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const LaboratoireRechercheScreen(), // Utiliser la classe LaboratoireRechercheScreen
                        ),
                      );
                    },
                    child: _buildBottomNavBarItem(
                      icon: 'assets/laboratoire.webp',
                      label: 'laboratoire',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ArchivesScreen(), 
                        ),
                      );
                    },
                    child: _buildBottomNavBarItem(
                      icon: 'assets/archive.webp',
                      label: 'Archives',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBarItem({
    required String icon,
    required String label,
    bool isActive = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          icon,
          height: 24.0,
          width: 24.0,
          // Pas de modification de couleur ici, on affiche la couleur d'origine
        ),
        const SizedBox(height: 4.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            color: isActive
                ? Colors.blueAccent
                : const Color.fromARGB(255, 132, 149, 187),
          ),
        ),
      ],
    );
  }
}



class RessourcesDefensivesScreen extends StatelessWidget {
  const RessourcesDefensivesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ressources Défensives')),
      body: const Center(child: Text('Contenu des Ressources Défensives')),
    );
  }
}

// Placeholder pour SelectionScreen (à déplacer dans selection_screen.dart)
class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Écran de Sélection')),
      body: const Center(child: Text('Contenu de l\'écran de sélection')),
    );
  }
}
