import 'package:flutter/material.dart';
// Importez les classes de données nécessaires
import '/models/laboratoire_recherche.dart'; // Assurez-vous que le chemin est correct
import '/models/ressources_defensives.dart'; // Assurez-vous que le chemin est correct


class LaboratoireRechercheScreen extends StatefulWidget {
  const LaboratoireRechercheScreen({Key? key}) : super(key: key);

  @override
  _LaboratoireRechercheScreenState createState() =>
      _LaboratoireRechercheScreenState();
}

class _LaboratoireRechercheScreenState extends State<LaboratoireRechercheScreen> {
  // Instance du LaboratoireRecherche (à récupérer ou initialiser globalement)
  final LaboratoireRecherche laboratoire = LaboratoireRecherche(
    pointsDeRechercheJoueur: 100, // Exemple: Valeur initiale des points de recherche
    technologiesDisponibles: [
      Technologie(
        id: 'capacite_base_anticorps',
        nom: 'Capacité de base des anticorps',
        description: 'Améliore la capacité de base des anticorps.',
        coutPointsRecherche: 20,
      ),
      Technologie(
        id: 'capacite_avancee_anticorps',
        nom: 'Capacité avancée des anticorps',
        description: 'Débloque des améliorations avancées pour les anticorps.',
        coutPointsRecherche: 30,
      ),
      Technologie(
        id: 'ameliorer_ressources',
        nom: 'Améliorer énergie et bio-matériaux',
        description: 'Augmente la production et le stockage de ressources.',
        coutPointsRecherche: 15,
      ),
      Technologie(
        id: 'capacite_ressources_avancee',
        nom: 'Capacité de ressources avancée',
        description: 'Débloque une capacité de ressources avancée.',
        coutPointsRecherche: 35,
      ),
    ],
  );

  // Instance des RessourcesDefensives (à récupérer ou initialiser globalement)
  final RessourcesDefensives ressources = RessourcesDefensives(
    energie: 2000, // Exemple: Valeur initiale de l'énergie
    bioMateriaux: 1000, // Exemple: Valeur initiale des bio-matériaux
  );

  // Méthode pour débloquer une technologie
  void debloquerTechnologie(Technologie technologie) {
    setState(() {
      if (laboratoire.peutDebloquer(technologie)) {
        laboratoire.debloquerTechnologie(technologie);
        // Mettre à jour les ressources du joueur (points de recherche)
        laboratoire.pointsDeRechercheJoueur -= technologie.coutPointsRecherche;
        // Mettre à jour les bonus/capacités (à implémenter selon la logique du jeu)
        _appliquerEffetTechnologie(technologie.id);
        _afficherMessageTechnologieDebloquee(technologie.nom); //Message de confirmation
      } else {
        _afficherMessageErreur("Points de recherche insuffisants pour débloquer ${technologie.nom}.");
      }
    });
  }

    void _afficherMessageErreur(String message) {
     showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Erreur'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _afficherMessageTechnologieDebloquee(String nomTechnologie) {
     showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Technologie Débloquée'),
        content: Text('La technologie "$nomTechnologie" a été débloquée !'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Méthode pour appliquer les effets d'une technologie (à adapter)
  void _appliquerEffetTechnologie(String technologieId) {
    // Implémentez la logique pour modifier les stats du joueur, débloquer des capacités, etc.
    switch (technologieId) {
      case 'capacite_base_anticorps':
        // Exemple: Augmenter les dégâts de base des anticorps
        // ressources.degatsAnticorpsBase += 5; // Ceci est un exemple, adaptez-le à votre classe RessourcesDefensives
        print('Capacité de base des anticorps améliorée !');
        break;
      case 'capacite_avancee_anticorps':
        // Exemple : Débloquer une nouvelle capacité d'anticorps
        // ressources.capaciteSpecialeAnticorpsDebloquee = true;
        print('Capacité avancée des anticorps débloquée !');
        break;
      case 'ameliorer_ressources':
        // Exemple: Augmenter la capacité de stockage des ressources
        ressources.energie += 500; // Assurez-vous que ceci est défini dans RessourcesDefensives
        ressources.bioMateriaux += 500; // Assurez-vous que ceci est défini.
        print('Capacité de stockage des ressources améliorée !');
        break;
       case 'capacite_ressources_avancee':
        // Exemple : Débloquer une nouvelle capacité de ressources
        // ressources.nouvelleCapaciteRessourcesDebloquee = true;
        print('Capacité avancée des ressources débloquée !');
        break;
      default:
        break;
    }
  }

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
              Color.fromARGB(255, 40, 57, 87),  // Bleu foncé
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20.0),
              // Titre de la page
              const Text(
                'Laboratoire de Recherche',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 20.0),
              // Affichage des ressources du joueur
              Text(
                'Points de Recherche: ${laboratoire.pointsDeRechercheJoueur}',
                style: const TextStyle(fontSize: 16.0, color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              // Liste des technologies disponibles
              Expanded(
                child: ListView.builder(
                  itemCount: laboratoire.technologiesDisponibles.length,
                  itemBuilder: (context, index) {
                    final technologie =
                        laboratoire.technologiesDisponibles[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.2)),
                        ),
                        child: ListTile(
                          title: Text(
                            technologie.nom,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            technologie.description,
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: ElevatedButton(
                            onPressed: technologie.estDebloquee
                                ? null // Désactiver si déjà débloquée
                                : () => debloquerTechnologie(technologie),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: technologie.estDebloquee
                                  ? Colors
                                      .grey // Style pour désactivé
                                  : Colors.greenAccent, // Style pour actif
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              technologie.estDebloquee
                                  ? 'Débloqué'
                                  : 'Débloquer',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: technologie.estDebloquee
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          leading: Icon(
                            // Afficher une icône différente selon si la technologie est débloquée
                            technologie.estDebloquee
                                ? Icons.check_circle // Icône de succès
                                : Icons
                                    .lock_open, // Icône de cadenas ouvert
                            color: technologie.estDebloquee
                                ? Colors.greenAccent
                                : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

