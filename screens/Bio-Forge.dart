import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/models/agent_pathogene.dart'; // Importez la classe AgentPathogene
import '/models/base_virale.dart';

class BioForgeScreen extends StatefulWidget {
  const BioForgeScreen({Key? key}) : super(key: key);

  @override
  _BioForgeScreenState createState() => _BioForgeScreenState();
}

class _BioForgeScreenState extends State<BioForgeScreen> {
  // Variables d'état pour la gestion de la Bio-Forge
  String nomBaseVirale = "Ma Base Virale";
  int bioMateriauxDisponibles = 30; // Exemple de valeur initiale
  List<AgentPathogene> pathogenesDisponibles = [
    Virus(
     nom: 'Coronavirus',
      pointsDeVieMax: 100,
     
      armure: 3,
      degats: 20,
      
      faiblesses:const [TypeAttaque.chimique],
      resistances:const [TypeAttaque.physique] ,
      typeAttaque: TypeAttaque.energetique,
      
      vitesseInitiative: 5,
    ),
    Virus(
      nom: 'Influenza Virus',
      pointsDeVieMax: 120,
      
     
      armure: 3,
      degats: 20,
      
      faiblesses:const [TypeAttaque.chimique],
      resistances:const [TypeAttaque.physique] ,
      
      
      typeAttaque: TypeAttaque.chimique,
      vitesseInitiative: 7,
    ),
      Bacterie(
      nom: 'mycobacterium tuberculois',
      pointsDeVieMax: 150,
      
     
      armure: 2,
      degats: 10,
      
      faiblesses:const [TypeAttaque.chimique],
      resistances:const [TypeAttaque.physique] ,
      
      
      typeAttaque: TypeAttaque.chimique,
      vitesseInitiative: 4,
    ),
          Champignon(
      nom: 'Candida albicans',
      pointsDeVieMax: 50,
      
     
      armure: 5,
      degats: 12,
      
      faiblesses:const [TypeAttaque.chimique],
      resistances:const [TypeAttaque.physique] ,
      
      
      typeAttaque: TypeAttaque.chimique,
      vitesseInitiative: 4,
    ),
       Champignon(
      nom: 'Coccidioides immitis',
      pointsDeVieMax: 60,
      
     
      armure: 8,
      degats: 14,
      
      faiblesses:const [TypeAttaque.chimique],
      resistances:const [TypeAttaque.physique] ,
      
      
      typeAttaque: TypeAttaque.chimique,
      vitesseInitiative: 5,
    ),
    Bacterie(
      nom: 'Aspergillus',
      pointsDeVieMax: 60,
      
     
      armure: 2,
      degats: 10,
      
      faiblesses:const [TypeAttaque.chimique],
      resistances:const [TypeAttaque.physique] ,
      
      
      typeAttaque: TypeAttaque.chimique,
      vitesseInitiative: 3,)
    // Ajoutez d'autres agents pathogènes disponibles ici
  ];
  List<AgentPathogene> pathogenesSelectionnes = [];

  // Méthode pour ajouter/retirer un pathogène de la sélection
    void togglePathogeneSelection(AgentPathogene pathogene) {
    setState(() {
      if (pathogenesSelectionnes.contains(pathogene)) {
        pathogenesSelectionnes.remove(pathogene);
      } else {
        // Vérifier si l'énergie nécessaire est disponible avant d'ajouter
        int energieNecessaire = pathogene.degats; // Exemple: coût basé sur les dégâts
        if (bioMateriauxDisponibles >= energieNecessaire) { // Bien vérifier la ressource ici
           pathogenesSelectionnes.add(pathogene);
        }
        else {
          //afficher un message d'erreur
           _afficherMessageErreur("Pas assez de bio-materiaux pour ajouter ${pathogene.nom}.");
        }
       
      }
    });
  }

  // Méthode pour sauvegarder la base virale
  void sauvegarderBaseVirale() {
    if (pathogenesSelectionnes.isEmpty) {
      _afficherMessageErreur("Veuillez sélectionner au moins un pathogène pour votre base virale.");
      return; // Ne pas continuer si aucun pathogène n'est sélectionné
    }
    // Créer une instance de BaseVirale avec les données sélectionnées
    BaseVirale nouvelleBase = BaseVirale(
      nom: nomBaseVirale,
      createur: "Joueur", // Le joueur est le créateur
      niveauDeMenace: 1, // Vous pouvez ajuster cela en fonction des pathogènes choisis
      vaguesPathogenes: [pathogenesSelectionnes], // Une seule vague pour simplifier
      recompensesPotentielles: {
        'bio-materiaux': 100,
        'points-recherche': 20
      }, // Valeurs par défaut
    );

    // TODO: Implémenter la logique pour sauvegarder cette base virale
    //  * Peut-être l'ajouter à une liste globale
    //  * Peut-être l'envoyer à un service de sauvegarde (Firestore, etc.)
    print('Base Virale Sauvegardée : ${nouvelleBase.nom} avec ${pathogenesSelectionnes.length} pathogènes.');

    // Afficher un message de succès
    _afficherMessageSauvegarde(nouvelleBase.nom);
  }

  void _afficherMessageSauvegarde(String nomBase) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Base Virale Sauvegardée'),
        content: Text('Votre base virale "$nomBase" a été sauvegardée avec succès !'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
             // Violet foncé
              Color.fromARGB(255, 47, 94, 79),
              Color.fromARGB(255, 40, 57, 87), // Bleu foncé
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView( // Ajouté pour gérer le dépassement de contenu
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                // Titre de la page
                const Text(
                  'Créer Votre Base Virale',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 20.0),
                // Affichage des ressources disponibles
                Text(
                  'Bio-Matériaux disponibles: $bioMateriauxDisponibles Unités',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                 const SizedBox(height: 20.0),
                // Section Nom de la Base
                TextField(
                  onChanged: (value) {
                    setState(() {
                      nomBaseVirale = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Nom de la Base',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orangeAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Titre de la section de sélection des pathogènes
                const Text(
                  'Sélectionner vos pathogènes',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orangeAccent,
                  ),
                ),
                const SizedBox(height: 10.0),
                // Liste des pathogènes disponibles
                Column(
                  children: pathogenesDisponibles.map((pathogene) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: CheckboxListTile(
                          title: Text(
                            pathogene.nom,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            'Energie ${pathogene.degats}/2000', // Exemple de coût
                            style: const TextStyle(color: Colors.grey),
                          ),
                          value: pathogenesSelectionnes.contains(pathogene),
                          onChanged: (bool? newValue) {
                            if (newValue != null) { //vérification null
                              togglePathogeneSelection(pathogene);
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
                // Affichage des pathogènes sélectionnés
                Text(
                  'Virus sélectionnés (${pathogenesSelectionnes.length})',
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white.withOpacity(0.1),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Text(
                    pathogenesSelectionnes.isEmpty
                        ? 'Aucun pathogène sélectionné'
                        : pathogenesSelectionnes.map((p) => p.nom).join(', '),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Boutons Sauvegarder et Déployer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Logique de sauvegarde de la base virale
                        sauvegarderBaseVirale();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 12.0),
                      ),
                      child: const Text(
                        'Sauvegarder',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implémenter la logique de déploiement de la base virale
                        if (pathogenesSelectionnes.isNotEmpty) {
                           print('Base Virale Déployée : $nomBaseVirale avec ${pathogenesSelectionnes.length} pathogènes.');
                        }
                        else{
                           _afficherMessageErreur("Veuillez sélectionner au moins un pathogène avant de déployer.");
                        }
                       
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 12.0),
                      ),
                      child: const Text(
                        'Déployer',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
