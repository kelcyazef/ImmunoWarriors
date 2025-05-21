import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Importez les fichiers nécessaires pour les classes de données du jeu
import '/models/base_virale.dart'; // Importez la classe BaseVirale
import '/models/agent_pathogene.dart'; // Importez la classe AgentPathogene
import '/models/combat_manager.dart'; // Importez CombatManager pour la navigation

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Création d'instances de BaseVirale pour la démonstration
    // Dans un jeu réel, ces données proviendraient de Firestore ou d'une autre source de données
    final agentPathogene1 = Virus(
      nom: 'Coronavirus',
      pointsDeVieMax: 100,
     
      armure: 3,
      degats: 20,
      
      faiblesses:const [TypeAttaque.chimique],
      resistances:const [TypeAttaque.physique] ,
      typeAttaque: TypeAttaque.energetique,
      
      vitesseInitiative: 5,
    );
    final agentPathogene2 = Bacterie(
      nom: 'Grippe',
      pointsDeVieMax: 80,
      armure: 3,
      degats: 20,
      typeAttaque: TypeAttaque.physique,
      faiblesses:const [TypeAttaque.chimique],
      resistances:const [TypeAttaque.physique] ,
      vitesseInitiative: 3,
    );
    final agentPathogene3 = Champignon(
      nom: 'Influenza virus',
      pointsDeVieMax: 120,
      armure: 3,
      faiblesses:const [TypeAttaque.chimique],
      resistances:const [TypeAttaque.physique] ,
      typeAttaque: TypeAttaque.chimique,
      degats: 30,
      vitesseInitiative: 7,
    );

    // Définition des vagues de pathogènes pour chaque base virale
    final vague1BaseA = [agentPathogene1];
    final vague1BaseB = [agentPathogene3];

    // Création des instances de BaseVirale
    final baseViraleA = BaseVirale(
      nom: 'Base Virale A',
      createur: 'Inconnu', // Nom du créateur (ennemi ou joueur)
      niveauDeMenace: 3, // Correction : Ajout du paramètre niveauDeMenace
      vaguesPathogenes: [vague1BaseA],
      recompensesPotentielles: {'bio-materiaux': 200, 'points-recherche': 50},
    );

    final baseViraleB = BaseVirale(
      nom: 'Base Virale B',
      createur: 'Ennemi', // Nom du créateur
      niveauDeMenace: 4, // Correction : Ajout du paramètre niveauDeMenace
      vaguesPathogenes: [vague1BaseB],
      recompensesPotentielles: {'bio-materiaux': 400, 'points-recherche': 100},
    );
    
    // Liste des bases virales à afficher dans le scanner
    final List<BaseVirale> basesVirales = [baseViraleA, baseViraleB];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
            Color.fromARGB(255, 47, 94, 79),
              Color.fromARGB(255, 40, 57, 87),  // Bleu foncé
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Ligne corrigée
            children: <Widget>[
              const SizedBox(height: 20.0),
              // Titre de la page
              const Text(
                'SCANNER DE MENACES',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 20.0),
              // Bouton pour déclencher la détection des menaces
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implémenter la logique de détection des menaces (interaction avec Firestore)
                  print('Détecter les menaces cliqué');
                  // Exemple d'appel de fonction pour récupérer les bases virales depuis Firestore
                  // _recupererBasesVirales();
                },
                icon: const Icon(Icons.search, color: Colors.black),
                label: const Text(
                  'Détecter les menaces',
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
              const SizedBox(height: 30.0),
              // Affichage des bases virales récupérées
              // Utilisation de ListView.builder pour gérer une liste potentiellement longue
              Expanded(
                child: ListView.builder(
                  itemCount: basesVirales.length,
                  itemBuilder: (context, index) {
                    final baseVirale = basesVirales[index];
                    return _buildBaseViraleCard(context, baseVirale);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Fonction pour construire la carte d'une base virale.
  /// Cette fonction prend maintenant un objet BaseVirale pour afficher ses propriétés.
  Widget _buildBaseViraleCard(BuildContext context, BaseVirale baseVirale) {
    // Affiche le premier agent pathogène de la vague actuelle, ou un message si vide.
    String virusDetectes = baseVirale.pathogenesVagueActuelle.isNotEmpty
        ? baseVirale.pathogenesVagueActuelle.first.nom
        : "Aucun virus détecté";
    int niveauMenace = baseVirale.niveauDeMenace;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white.withOpacity(0.1),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            baseVirale.nom,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            'Virus détectés',
            style: const TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/virus.svg', // Remplacez par le chemin de votre icône de virus
                height: 20.0,
                width: 20.0,
                color: Colors.greenAccent, // Couleur de l'icône du virus
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                virusDetectes,
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Text(
                'Niveau de menace',
                style: TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
              const SizedBox(
                width: 5,
              ),
              Row(
                children: List.generate(
                  5, // Nombre total d'étoiles
                  (index) => Icon(
                    Icons.star,
                    size: 16.0,
                    color: index < niveauMenace
                        ? Colors.yellowAccent // Étoiles remplies
                        : Colors.grey, // Étoiles vides
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              
              const SizedBox(
                width: 5,
              ),
              Text(
                'Récompense',
                style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.green,
                ),
                child: const Text(
                  '\$',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                baseVirale.recompensesPotentielles['bio-materiaux'].toString(),
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implémenter la logique d'attaque (navigation vers l'Holo-Simulateur)
                  print('Attaquer ${baseVirale.nom} cliqué');
                  // Exemple de navigation vers le simulateur de combat
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => HoloSimulateurCombat(baseVirale: baseVirale),
                  //   ),
                  // );
                  // Créer un CombatManager et démarrer le combat (exemple)
                  final combatManager = CombatManager(
                    escouadeJoueur: [], // Remplacez par la véritable escouade du joueur
                    ennemis: baseVirale.pathogenesVagueActuelle,
                  );
                  combatManager.demarrerCombat();

                  // Naviguer vers l'écran de combat (à implémenter)
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => CombatScreen(combatManager: combatManager)),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                ),
                child: Row(
                  children: const [
                    
                    SizedBox(width: 5),
                    Text(
                      'ATTAQUER',
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

