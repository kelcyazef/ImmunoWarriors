// ignore_for_file: unused_element

/// Énumération des types d'attaques possibles dans le jeu.
enum TypeAttaque {
  corrosive,
  perforante,
  physique, // TP ICT218, 3.8 [cite: 74]
  chimique, // TP ICT218, 3.8 [cite: 74]
  energetique, // TP ICT218, 3.8 [cite: 74]
  // Ajoutez d'autres types si nécessaire
}

/// Énumération des types d'agents pathogènes.
enum TypePathogene {
  virus,
  bacterie,
  champignon,
}

/// Classe de base pour tous les agents pathogènes.
///
/// Attributs:
/// - `nom`: Le nom de l'agent pathogène (pour affichage ou identification).
/// - `type`: Le type d'agent pathogène (Virus, Bactérie, Champignon)[cite: 36].
/// - `pointsDeVie`: Les points de vie actuels de l'agent[cite: 36].
/// - `pointsDeVieMax`: Les points de vie maximum de l'agent.
/// - `armure`: La valeur d'armure ou de résistance de l'agent[cite: 36].
/// - `typeAttaque`: Le type d'attaque principal de l'agent[cite: 36].
/// - `degats`: Les dégâts de base infligés par l'agent[cite: 36].
/// - `vitesseInitiative`: Détermine l'ordre d'action en combat[cite: 36].
/// - `faiblesses`: Une liste des types d'attaques contre lesquels cet agent est faible[cite: 38].
/// - `resistances`: Une liste des types d'attaques contre lesquels cet agent est résistant.
abstract class AgentPathogene {
  final String nom;
  final TypePathogene type;
  int pointsDeVie;
  final int pointsDeVieMax;
  final int armure;
  final TypeAttaque typeAttaque;
  final int degats;
  final int vitesseInitiative;
  final List<TypeAttaque> faiblesses;
  final List<TypeAttaque> resistances;

  AgentPathogene({
    required this.nom,
    required this.type,
    required this.pointsDeVieMax,
    this.armure = 0,
    required this.typeAttaque,
    required this.degats,
    required this.vitesseInitiative,
    this.faiblesses = const [],
    this.resistances = const [],
  }) : pointsDeVie = pointsDeVieMax;

  /// Applique des dégâts à l'agent pathogène.
  /// Prend en compte l'armure et les faiblesses/résistances.
  void recevoirDegats(int quantite, TypeAttaque typeDegats) {
    double multiplicateur = 1.0;
    if (faiblesses.contains(typeDegats)) {
      multiplicateur = 1.5; // Dégâts x1.5 si faiblesse [cite: 75]
    } else if (resistances.contains(typeDegats)) {
      multiplicateur = 0.5; // Dégâts x0.5 si résistance [cite: 75]
    }

    int degatsInfliges = (quantite * multiplicateur).round() - armure;
    if (degatsInfliges < 0) degatsInfliges = 0; // Ne pas soigner avec les dégâts

    pointsDeVie -= degatsInfliges;
    if (pointsDeVie < 0) pointsDeVie = 0;
    print('$nom subit $degatsInfliges points de dégâts de type $typeDegats. PV restants: $pointsDeVie');
  }

  /// Méthode pour que l'agent pathogène attaque une cible (un anticorps).
  /// La cible devra avoir une méthode `recevoirDegats`.
  void attaquer(dynamic cible) { // `dynamic` à remplacer par `Anticorps` une fois défini
    print('$nom attaque avec ${typeAttaque} pour ${degats} dégâts.');
     cible.recevoirDegats(degats, typeAttaque); // Logique à implémenter dans Anticorps
  }

  /// Vérifie si l'agent pathogène est éliminé (PV <= 0).
  bool estElimine() => pointsDeVie <= 0;

  /// Capacité spéciale de l'agent pathogène.
  /// Doit être implémentée par les sous-classes.
  void utiliserCapaciteSpeciale(dynamic cible); // `dynamic` à remplacer par `Anticorps` ou `List<Anticorps>`
}

/// Sous-classe représentant un Virus.
class Virus extends AgentPathogene {
  final String specificiteVirus; // Exemple de propriété spécifique

  Virus({
    required String nom,
    required int pointsDeVieMax,
    int armure = 0,
    TypeAttaque typeAttaque = TypeAttaque.corrosive, // Exemple
    int degats = 10,
    int vitesseInitiative = 5,
    List<TypeAttaque> faiblesses = const [TypeAttaque.chimique], // Exemple
    List<TypeAttaque> resistances = const [TypeAttaque.physique], // Exemple
    this.specificiteVirus = 'MutationRapide',
  }) : super(
          nom: nom,
          type: TypePathogene.virus,
          pointsDeVieMax: pointsDeVieMax,
          armure: armure,
          typeAttaque: typeAttaque,
          degats: degats,
          vitesseInitiative: vitesseInitiative,
          faiblesses: faiblesses,
          resistances: resistances,
        );

  @override
  void utiliserCapaciteSpeciale(dynamic cible) {
    // Exemple: MutationRapide - change de faiblesse [cite: 37]
    print('$nom utilise MutationRapide !');
    // Logique pour changer une faiblesse ou une résistance aléatoirement
    // (simplifié ici, nécessiterait une logique plus complexe)
    if (faiblesses.isNotEmpty) {
      faiblesses.removeAt(0); // Simpliste
      print('$nom a modifié ses faiblesses.');
    }
  }
}

/// Sous-classe représentant une Bactérie.
class Bacterie extends AgentPathogene {
  Bacterie({
    required String nom,
    required int pointsDeVieMax,
    int armure = 5, // Les bactéries peuvent être plus blindées [cite: 21]
    TypeAttaque typeAttaque = TypeAttaque.physique, // Exemple
    int degats = 8,
    int vitesseInitiative = 3,
    List<TypeAttaque> faiblesses = const [TypeAttaque.energetique], // Exemple
    List<TypeAttaque> resistances = const [TypeAttaque.chimique], // Exemple
  }) : super(
          nom: nom,
          type: TypePathogene.bacterie,
          pointsDeVieMax: pointsDeVieMax,
          armure: armure,
          typeAttaque: typeAttaque,
          degats: degats,
          vitesseInitiative: vitesseInitiative,
          faiblesses: faiblesses,
          resistances: resistances,
        );

  @override
  void utiliserCapaciteSpeciale(dynamic cible) {
    // Exemple: BouclierBiofilm - réduit dégâts subis [cite: 37]
    print('$nom active BouclierBiofilm !');
    // Pourrait augmenter temporairement l'armure ou réduire les prochains dégâts
    // super.armure += 5; // Attention: mutable, ou alors un effet temporaire
  }
}

/// Sous-classe représentant un Champignon.
class Champignon extends AgentPathogene {
  Champignon({
    required String nom,
    required int pointsDeVieMax,
    int armure = 2,
    TypeAttaque typeAttaque = TypeAttaque.chimique, // Spores corrosives [cite: 21]
    int degats = 12,
    int vitesseInitiative = 2,
    List<TypeAttaque> faiblesses = const [TypeAttaque.physique], // Exemple
    List<TypeAttaque> resistances = const [TypeAttaque.energetique], // Exemple
  }) : super(
          nom: nom,
          type: TypePathogene.champignon,
          pointsDeVieMax: pointsDeVieMax,
          armure: armure,
          typeAttaque: typeAttaque,
          degats: degats,
          vitesseInitiative: vitesseInitiative,
          faiblesses: faiblesses,
          resistances: resistances,
        );

  @override
  void utiliserCapaciteSpeciale(dynamic cible) {
    // Exemple: InvisibilitéSporadique - évite des attaques [cite: 37]
    print('$nom utilise InvisibilitéSporadique !');
    // Logique pour avoir une chance d'éviter la prochaine attaque
  }
}