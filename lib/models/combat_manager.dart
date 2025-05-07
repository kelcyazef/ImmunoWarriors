import 'agent_pathogene.dart';
import 'anticorps.dart';
// Importer d'autres modèles si nécessaire (ex: MemoireImmunitaire)

/// Gère la logique du combat tour par tour. [cite: 1]
///
/// Orchestre la simulation de combat selon les règles définies en 3.8 du TP ICT218. [cite: 42]
class CombatManager {
  List<Anticorps> escouadeJoueur;
  List<AgentPathogene> ennemis;
  List<dynamic> ordreAction = []; // Contiendra des instances d'Anticorps ou AgentPathogene
  int tourActuel = 0;
  bool combatTermine = false;
  String? vainqueur; // Pourrait être 'joueur' ou 'ennemis'

  CombatManager({
    required this.escouadeJoueur,
    required this.ennemis,
  });

  /// Initialise et démarre le combat.
  void demarrerCombat() {
    tourActuel = 1;
    combatTermine = false;
    vainqueur = null;
    print('Le combat commence !');

    // Phase Préparation: Le joueur sélectionne son escouade (géré en amont) [cite: 78]
    // Ici, on suppose que `escouadeJoueur` et `ennemis` sont déjà prêts.

    // Déterminer l'ordre d'action basé sur Vitesse/Initiative [cite: 79]
    ordreAction.addAll(escouadeJoueur);
    ordreAction.addAll(ennemis);
    ordreAction.sort((a, b) => b.vitesseInitiative.compareTo(a.vitesseInitiative));

    print('Ordre d\'action: ${ordreAction.map((u) => u.nom).join(', ')}');
    prochainTour();
  }

  /// Gère la logique d'un tour de combat.
  void prochainTour() {
    if (combatTermine) return;
    print('\n--- Tour $tourActuel ---');

    for (var unite in ordreAction) {
      if (unite.estElimine()) continue; // Passer si l'unité a été éliminée ce tour-ci

      if (unite is Anticorps) {
        // Logique pour un anticorps
        AgentPathogene? cible = trouverCibleEnnemie(unite, ennemis);
        if (cible != null) {
          // TODO: IA simple pour décider d'utiliser une capacité spéciale ou une attaque normale [cite: 81]
          unite.attaquer(cible);
          if (cible.estElimine()) {
            print('${cible.nom} a été vaincu !');
            // Mettre à jour la mémoire immunitaire (logique à ajouter) [cite: 41, 83]
          }
        }
      } else if (unite is AgentPathogene) {
        // Logique pour un agent pathogène
        Anticorps? cible = trouverCibleAnticorps(unite, escouadeJoueur);
        if (cible != null) {
          // TODO: IA simple pour décider d'utiliser une capacité spéciale ou une attaque normale [cite: 81]
          unite.attaquer(cible);
          if (cible.estElimine()) {
            print('${cible.nom} (Anticorps) a été neutralisé !');
          }
        }
      }
      verifierFinCombat();
      if (combatTermine) break;
    }

    if (!combatTermine) {
      tourActuel++;
      prochainTour(); // Boucle pour le prochain tour (pour un combat automatisé)
                      // Pour un jeu interactif, on attendrait une action du joueur.
    }
  }

  /// IA de ciblage simple: attaque l'ennemi avec le moins de PV restants[cite: 80].
  AgentPathogene? trouverCibleEnnemie(Anticorps attaquant, List<AgentPathogene> ciblesPossibles) {
    AgentPathogene? cibleChoisie;
    ciblesPossibles.removeWhere((p) => p.estElimine()); // Filtrer les morts
    if (ciblesPossibles.isEmpty) return null;

    ciblesPossibles.sort((a, b) => a.pointsDeVie.compareTo(b.pointsDeVie));
    cibleChoisie = ciblesPossibles.first;
    return cibleChoisie;
  }

  /// IA de ciblage simple pour les pathogènes.
  Anticorps? trouverCibleAnticorps(AgentPathogene attaquant, List<Anticorps> ciblesPossibles) {
    Anticorps? cibleChoisie;
    ciblesPossibles.removeWhere((a) => a.estElimine()); // Filtrer les morts
    if (ciblesPossibles.isEmpty) return null;
    
    ciblesPossibles.sort((a, b) => a.pointsDeVie.compareTo(b.pointsDeVie));
    cibleChoisie = ciblesPossibles.first;
    return cibleChoisie;9
  }

  /// Vérifie si le combat est terminé et détermine le vainqueur.
  void verifierFinCombat() {
    bool tousEnnemisElimines = ennemis.every((e) => e.estElimine());
    bool tousAnticorpsElimines = escouadeJoueur.every((a) => a.estElimine());

    if (tousEnnemisElimines) {
      combatTermine = true;
      vainqueur = 'joueur';
      print('\nVictoire du joueur ! Tous les pathogènes ont été éliminés.');
      resoudreCombat();
    } else if (tousAnticorpsElimines) {
      combatTermine = true;
      vainqueur = 'ennemis';
      print('\nDéfaite... Tous les anticorps ont été neutralisés.');
      resoudreCombat();
    }
  }

  /// Résolution post-combat. [cite: 83]
  void resoudreCombat() {
    if (!combatTermine) return;
    print('--- Résolution du Combat ---');
    if (vainqueur == 'joueur') {
      print('Récompenses: ... (logique à implémenter)'); // Ressources, points de recherche
      print('Mise à jour Mémoire Immunitaire: ... (logique à implémenter)');
    } else {
      print('Aucune récompense.');
    }
    // Déclenchement de la génération de la Chronique Gemini (sera géré par Dev 4) [cite: 83]
    print('Le combat est terminé.');
  }
}