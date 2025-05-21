import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/models/agent_pathogene.dart'; // Importez la classe AgentPathogene
import '/models/anticorps.dart';
import '/models/base_virale.dart';
import '/models/ressources_defensives.dart';
import '/models/combat_manager.dart';
class CombatScreen extends StatefulWidget {
  final BaseVirale baseAttaquee;

  const CombatScreen({Key? key, required this.baseAttaquee}) : super(key: key);

  @override
  _CombatScreenState createState() => _CombatScreenState();
}

class _CombatScreenState extends State<CombatScreen> {
  // Variables d'état pour la gestion du combat
  List<Anticorps> anticorpsDisponibles = [
    Anticorps(
      nom: 'Lymphocyte T cytotoxique',
      type: TypeAnticorps.specifique,
      pointsDeVieMax: 150,
      degats: 30,
      typeAttaque: TypeAttaque.perforante,
      coutRessources: 100, // Exemple de coût
      tempsProduction: 5, // Exemple de temps de production
      vitesseInitiative: 5,
    ),
    Anticorps(
      nom: 'Natural Killer Cell',
      type: TypeAnticorps.generaliste,
      pointsDeVieMax: 120,
      degats: 25,
      typeAttaque: TypeAttaque.energetique,
      coutRessources: 80,
      tempsProduction: 3,
      vitesseInitiative: 7,
    ),
    // Ajoutez d'autres anticorps disponibles ici
  ];
  List<Anticorps> anticorpsSelectionnes = [];
  RessourcesDefensives ressources = RessourcesDefensives(
      energie: 2000,
      bioMateriaux:
          1000); // Exemple de valeurs initiales, à récupérer du joueur
  List<AgentPathogene> ennemis = []; // Liste des ennemis à combattre
  bool combatEnCours =
      false; // Indique si le combat est en cours (pour désactiver les sélections)

  // Méthode pour ajouter/retirer un anticorps de la sélection
  void toggleAnticorpsSelection(Anticorps anticorps) {
    setState(() {
      if (combatEnCours) return; // Empêcher la sélection pendant le combat

      if (anticorpsSelectionnes.contains(anticorps)) {
        anticorpsSelectionnes.remove(anticorps);
      } else {
        // Vérifier si les ressources sont suffisantes avant d'ajouter
        if (ressources.energie >= anticorps.coutRessources &&
            ressources.bioMateriaux >= anticorps.coutRessources) {
          anticorpsSelectionnes.add(anticorps);
        } else {
          _afficherMessageErreur(
              "Ressources insuffisantes pour sélectionner ${anticorps.nom}.");
        }
      }
    });
  }

  // Méthode pour démarrer le combat
  void demarrerCombat() {
    setState(() {
      if (anticorpsSelectionnes.isEmpty) {
        _afficherMessageErreur(
            "Veuillez sélectionner au moins un anticorps pour démarrer le combat.");
        return; // Ne pas démarrer le combat si aucun anticorps n'est sélectionné
      }
      combatEnCours = true;
      ennemis = List.from(
          widget.baseAttaquee.pathogenesVagueActuelle); // Récupérer les ennemis de la base
      // TODO: Implémenter la logique de combat (CombatManager)
      print('Combat démarré avec ${anticorpsSelectionnes.length} anticorps contre ${ennemis.length} ennemis.');
      // Créer un CombatManager et démarrer le combat (exemple)
      final combatManager = CombatManager(
        escouadeJoueur: anticorpsSelectionnes,
        ennemis: ennemis,
      );
      combatManager.demarrerCombat();
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

  @override
  void initState() {
    super.initState();
    // Initialiser les ennemis avec les pathogènes de la base attaquée
    ennemis = List.from(widget.baseAttaquee.pathogenesVagueActuelle);
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
              Color.fromARGB(255, 40, 57, 87), // Bleu foncé
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                // Titre de la page
                const Text(
                  'Base de Détection',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Affichage des ressources disponibles
                Text(
                  'Énergie: ${ressources.energie} / Bio-Matériaux: ${ressources.bioMateriaux}',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                const SizedBox(height: 20.0),
                // Section Virus Détectés
                const Text(
                  'Virus Détectés',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 10.0),
                // Affichage des virus ennemis
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: ennemis.map((ennemi) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.2)),
                      ),
                      child: Text(
                        '${ennemi.nom} (Energie: ${ennemi.pointsDeVieMax} / Résistant: ${ennemi.armure})', // Exemple
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20.0),
                // Section Sélectionner vos Anticorps
                const Text(
                  'Sélectionnez vos Anticorps',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 10.0),
                // Liste des anticorps disponibles
                Column(
                  children: anticorpsDisponibles.map((anticorps) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.2)),
                        ),
                        child: CheckboxListTile(
                          title: Text(
                            anticorps.nom,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Energie: ${anticorps.coutRessources} / Bio-Matériaux: ${anticorps.coutRessources}', // Exemple
                            style: const TextStyle(color: Colors.grey),
                          ),
                          value:
                              anticorpsSelectionnes.contains(anticorps),
                          onChanged: combatEnCours
                              ? null
                              : (bool? newValue) {
                                  if (newValue != null) {
                                    toggleAnticorpsSelection(anticorps);
                                  }
                                },
                          checkColor: Colors.black,
                          activeColor: Colors.greenAccent,
                          tileColor: Colors.transparent,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20.0),
                // Affichage des anticorps sélectionnés
                Text(
                  'Anticorps sélectionnés (${anticorpsSelectionnes.length})',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Text(
                    anticorpsSelectionnes.isEmpty
                        ? 'Aucun anticorps sélectionné'
                        : anticorpsSelectionnes
                            .map((a) => a.nom)
                            .join(', '),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Bouton Démarrer
                Center(
                  child: ElevatedButton(
                    onPressed: combatEnCours ? null : demarrerCombat,
                    // Désactiver pendant le combat
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 12.0),
                    ),
                    child: Text(
                      combatEnCours ? 'Combat en cours...' : 'Start',
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

