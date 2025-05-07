import 'package:flutter_test/flutter_test.dart';
import 'package:immuno_warriors/models/combat_manager.dart';
import 'package:immuno_warriors/models/anticorps.dart';
import 'package:immuno_warriors/models/agent_pathogene.dart';

void main() {
  group('CombatManager', () {
    late CombatManager combatManager;
    late List<Anticorps> escouade;
    late List<AgentPathogene> ennemis;

    setUp(() {
      // Créer des instances pour les tests
      escouade = [
        Anticorps(nom: 'A1', pointsDeVieMax: 100, degats: 20, vitesseInitiative: 5, type: TypeAnticorps.generaliste, typeAttaque: TypeAttaque.physique, coutRessources: 10, tempsProduction: 1),
        Anticorps(nom: 'A2', pointsDeVieMax: 80, degats: 15, vitesseInitiative: 7, type: TypeAnticorps.specifique, typeAttaque: TypeAttaque.chimique, coutRessources: 10, tempsProduction: 1),
      ];
      ennemis = [
        Virus(nom: 'V1', pointsDeVieMax: 50, degats: 10, vitesseInitiative: 6, faiblesses: [TypeAttaque.chimique]),
        Bacterie(nom: 'B1', pointsDeVieMax: 70, degats: 8, vitesseInitiative: 4, armure: 5),
      ];
      combatManager = CombatManager(escouadeJoueur: escouade, ennemis: ennemis);
    });

    test('Initialisation correcte du combat et ordre d\'action', () {
      combatManager.demarrerCombat(); // Démarre aussi le premier tour
      expect(combatManager.tourActuel, greaterThanOrEqualTo(1));
      expect(combatManager.ordreAction, isNotEmpty);
      // Vérifier si l'ordre est correct basé sur la vitesse
      // A2 (7), V1 (6), A1 (5), B1 (4)
      expect(combatManager.ordreAction.map((u) => u.nom).toList(), equals(['A2', 'V1', 'A1', 'B1']));
    });

    test('Déroulement simple d\'un combat jusqu\'à la victoire du joueur', () {
      // Simplifions les PV pour un test rapide
      escouade = [Anticorps(nom: 'SuperA', pointsDeVieMax: 200, degats: 50, vitesseInitiative: 10, type: TypeAnticorps.generaliste, typeAttaque: TypeAttaque.physique, coutRessources: 10, tempsProduction: 1)];
      ennemis = [Virus(nom: 'MiniV', pointsDeVieMax: 40, degats: 5, vitesseInitiative: 1)];
      combatManager = CombatManager(escouadeJoueur: escouade, ennemis: ennemis);
      
      combatManager.demarrerCombat(); // Cela va lancer les tours automatiquement dans la version actuelle

      // Attendre la fin du combat (dans un vrai test, il faudrait peut-être mocker le temps ou
      // avoir une version du CombatManager qui ne boucle pas automatiquement les tours)
      // Pour cette structure simple, on vérifie le résultat après l'appel
      expect(combatManager.combatTermine, isTrue);
      expect(combatManager.vainqueur, equals('joueur'));
      expect(ennemis.first.estElimine(), isTrue);
    });

     test('Déroulement simple d\'un combat jusqu\'à la victoire des ennemis', () {
      escouade = [Anticorps(nom: 'FaibleA', pointsDeVieMax: 10, degats: 1, vitesseInitiative: 1, type: TypeAnticorps.generaliste, typeAttaque: TypeAttaque.physique, coutRessources: 10, tempsProduction: 1)];
      ennemis = [Virus(nom: 'FortV', pointsDeVieMax: 100, degats: 20, vitesseInitiative: 10)];
      combatManager = CombatManager(escouadeJoueur: escouade, ennemis: ennemis);
      
      combatManager.demarrerCombat();

      expect(combatManager.combatTermine, isTrue);
      expect(combatManager.vainqueur, equals('ennemis'));
      expect(escouade.first.estElimine(), isTrue);
    });

    // Plus de tests:
    // - Ciblage (ennemi avec le moins de PV)
    // - Effet des faiblesses/résistances pendant un combat géré par le manager
    // - Utilisation des capacités spéciales si le CombatManager les déclenche
  });
}