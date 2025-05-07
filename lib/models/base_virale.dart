import 'agent_pathogene.dart';

/// Représente une base ennemie ou celle du joueur. [cite: 1, 43]
///
/// Contient une liste d'AgentPathogene (potentiellement par vagues) et des défenses passives optionnelles. [cite: 44]
class BaseVirale {
  final String nom;
  String createur; // Nom du créateur (pour les bases adverses) [cite: 51]
  int niveauDeMenace; // Niveau de menace estimé [cite: 51]
  // Récompenses potentielles (pourrait être une classe/map plus complexe) [cite: 51]
  Map<String, int> recompensesPotentielles; 

  List<List<AgentPathogene>> vaguesPathogenes; // Liste de vagues, chaque vague est une liste de pathogènes
  int vagueActuelleIndex;
  // List<DefensePassive> defensesPassives; // Optionnel [cite: 44]

  BaseVirale({
    required this.nom,
    this.createur = "Inconnu",
    this.niveauDeMenace = 1,
    this.recompensesPotentielles = const {'bio-materiaux': 100, 'points-recherche': 10},
    required this.vaguesPathogenes,
    // this.defensesPassives = const [],
  }) : vagueActuelleIndex = 0 {
    if (vaguesPathogenes.isEmpty) {
      //throw ArgumentError('Une base virale doit avoir au moins une vague de pathogènes.');
       // Pour l'instant, on permet une base vide pour la Bio-Forge du joueur [cite: 55]
       print("Attention: Base virale créée sans pathogènes.");
    }
  }

  /// Retourne la liste des pathogènes pour la vague actuelle.
  List<AgentPathogene> get pathogenesVagueActuelle {
    if (vaguesPathogenes.isEmpty || vagueActuelleIndex >= vaguesPathogenes.length) {
      return [];
    }
    return vaguesPathogenes[vagueActuelleIndex];
  }

  /// Fait progresser à la prochaine vague de pathogènes.
  /// Retourne `true` s'il y a une prochaine vague, `false` sinon.
  bool lancerProchaineVague() {
    if (vagueActuelleIndex < vaguesPathogenes.length - 1) {
      vagueActuelleIndex++;
      print('Nouvelle vague de pathogènes ($vagueActuelleIndex) pour la base $nom !');
      return true;
    }
    print('Toutes les vagues de la base $nom ont été déployées.');
    return false;
  }

  /// Ajoute un pathogène à la première vague (ou une vague spécifique).
  /// Principalement pour la Bio-Forge du joueur. [cite: 55]
  void ajouterPathogene(AgentPathogene pathogene, {int vagueCible = 0}) {
    if (vaguesPathogenes.isEmpty) {
        vaguesPathogenes.add([]);
    }
    while (vagueCible >= vaguesPathogenes.length) {
        vaguesPathogenes.add([]);
    }
    vaguesPathogenes[vagueCible].add(pathogene);
    print('${pathogene.nom} ajouté à la vague $vagueCible de la base $nom.');
  }

  /// TODO: Méthodes pour la gestion par le joueur (sauvegarde Firestore sera gérée par Dev 3) [cite: 55]
}

// Classe optionnelle pour les défenses passives
// class DefensePassive {
//   final String nom;
//   final String effet;
//   DefensePassive({required this.nom, required this.effet});
// }