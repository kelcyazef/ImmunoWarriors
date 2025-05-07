// ignore_for_file: unused_element

// Assurez-vous d'importer TypeAttaque si ce n'est pas dans le même fichier
 import 'agent_pathogene.dart'; // Si TypeAttaque y est défini

/// Énumération des types d'anticorps.
enum TypeAnticorps {
  specifique,
  generaliste,
}

/// Classe représentant un Anticorps.
///
/// Attributs:
/// - `nom`: Le nom de l'anticorps.
/// - `type`: Le type d'anticorps (spécifique, généraliste)[cite: 38].
/// - `pointsDeVie`: Les PV actuels de l'anticorps[cite: 38].
/// - `pointsDeVieMax`: Les PV maximum de l'anticorps.
/// - `typeAttaque`: Le type d'attaque de l'anticorps[cite: 38].
/// - `degats`: Les dégâts de base infligés par l'anticorps[cite: 38].
/// - `coutRessources`: Le coût pour produire cet anticorps[cite: 38].
/// - `tempsProduction`: Le temps nécessaire pour produire cet anticorps[cite: 38].
/// - `vitesseInitiative`: Pour déterminer l'ordre d'action (non spécifié directement mais utile pour le CombatManager).
class Anticorps {
  final String nom;
  final TypeAnticorps type;
  int pointsDeVie;
  final int pointsDeVieMax;
  final TypeAttaque typeAttaque;
  final int degats;
  final int coutRessources;
  final int tempsProduction;
  final int vitesseInitiative; // Ajouté pour la logique de combat

  Anticorps({
    required this.nom,
    required this.type,
    required this.pointsDeVieMax,
    required this.typeAttaque,
    required this.degats,
    required this.coutRessources,
    required this.tempsProduction,
    required this.vitesseInitiative,
  }) : pointsDeVie = pointsDeVieMax;

  /// Applique des dégâts à l'anticorps.
  void recevoirDegats(int quantite, TypeAttaque typeDegatsRecus) {
    // Les anticorps n'ont pas de faiblesses/résistances spécifiées,
    // mais vous pourriez en ajouter si le game design évolue.
    pointsDeVie -= quantite;
    if (pointsDeVie < 0) pointsDeVie = 0;
    print('$nom (Anticorps) subit $quantite points de dégâts. PV restants: $pointsDeVie');
  }

  /// Méthode pour que l'anticorps attaque une cible (un AgentPathogene).
  void attaquer(AgentPathogene cible) {
    print('$nom (Anticorps) attaque ${cible.nom} avec ${typeAttaque} pour ${degats} dégâts.');
    cible.recevoirDegats(degats, typeAttaque);
  }

  /// Vérifie si l'anticorps est éliminé (PV <= 0).
  bool estElimine() => pointsDeVie <= 0;

  /// Capacité spéciale de l'anticorps.
  /// Au moins 1-2 types de capacités spéciales[cite: 39].
  /// Exemples: SalvoToxique (attaque de zone), ReparationCellulaire (soin léger),
  /// MarquagePrioritaire (augmente dégâts subis par la cible).
  void utiliserCapaciteSpeciale(dynamic cibleOuSelf) {
    // À implémenter avec des logiques spécifiques
    // Par exemple, pour ReparationCellulaire:
    // if (this.nom == 'AnticorpsSoigneur') { // Ou une propriété/type spécifique
    //   int soin = 15;
    //   this.pointsDeVie += soin;
    //   if (this.pointsDeVie > this.pointsDeVieMax) this.pointsDeVie = this.pointsDeVieMax;
    //   print('$nom utilise ReparationCellulaire et récupère $soin PV.');
    // }
    print('$nom (Anticorps) utilise une capacité spéciale.');
  }
}

// Vous pourriez créer des sous-classes d'Anticorps si leurs capacités sont très différentes
// ou si vous voulez une structure plus formelle pour les types de capacités.
// Exemple:
// class AnticorpsAttaqueDeZone extends Anticorps { ... }
// class AnticorpsSoigneur extends Anticorps { ... }