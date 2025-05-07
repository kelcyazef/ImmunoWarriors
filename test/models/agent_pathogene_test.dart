import 'package:flutter_test/flutter_test.dart';
// Adaptez le chemin d'importation selon la structure de votre projet
import 'package:immuno_warriors/models/agent_pathogene.dart';

void main() {
  group('AgentPathogene et ses sous-classes', () {
    // Test pour la classe Virus
    group('Virus', () {
      late Virus virusTest;

      setUp(() {
        virusTest = Virus(
          nom: 'Testovirus',
          pointsDeVieMax: 100,
          degats: 10,
          vitesseInitiative: 5,
          typeAttaque: TypeAttaque.corrosive,
          faiblesses: [TypeAttaque.chimique],
          // resistances: par défaut [TypeAttaque.physique]
        );
      });

      test('Initialisation correcte des PV', () {
        expect(virusTest.pointsDeVie, equals(100));
      });

      test('Recevoir des dégâts (avec résistance par défaut à physique)', () {
        // Le virusTest a une résistance par défaut à physique (x0.5), armure 0
        virusTest.recevoirDegats(20, TypeAttaque.physique); 
        expect(virusTest.pointsDeVie, equals(100 - (20 * 0.5).round())); // 100 - 10 = 90
      });

      test('Recevoir des dégâts avec faiblesse', () {
        // Faiblesse à chimique (x1.5), armure 0
        virusTest.recevoirDegats(20, TypeAttaque.chimique); 
        expect(virusTest.pointsDeVie, equals(100 - (20 * 1.5).round())); // 100 - 30 = 70
      });

      test('Recevoir des dégâts avec résistance explicite (exemple pour confirmation)', () {
        final virusResistant = Virus(
          nom: 'ResistoVirus',
          pointsDeVieMax: 100, degats: 10, vitesseInitiative: 5,
          typeAttaque: TypeAttaque.corrosive,
          resistances: [TypeAttaque.physique] // Explicitement
        );
        virusResistant.recevoirDegats(20, TypeAttaque.physique); // Résistance x0.5, armure 0
        expect(virusResistant.pointsDeVie, equals(100 - (20 * 0.5).round())); // 100 - 10 = 90
      });

      test('Vérification élimination (compte tenu de la résistance)', () {
        expect(virusTest.estElimine(), isFalse);
        // Résistance à physique (x0.5), armure 0. PV initiaux 100.
        // Pour infliger 100 dégâts réels, il faut 200 dégâts de base.
        virusTest.recevoirDegats(200, TypeAttaque.physique); 
        expect(virusTest.pointsDeVie, equals(0));
        expect(virusTest.estElimine(), isTrue);
      });

      test('Utiliser capacité spéciale (MutationRapide)', () {
        final initialFaiblesses = List<TypeAttaque>.from(virusTest.faiblesses);
        virusTest.utiliserCapaciteSpeciale(null); // Cible non pertinente ici
        // Test simple: vérifier que la liste a pu changer (si elle n'était pas vide)
        // Pour un test plus robuste, il faudrait une logique de mutation plus prédictible
        // ou vérifier un effet secondaire (ex: un log spécifique)
        if (initialFaiblesses.isNotEmpty) {
          // Ce test est basique, il ne garantit pas que la mutation a eu l'effet désiré,
          // seulement qu'elle a potentiellement modifié la liste.
           print('Faiblesses après MutationRapide: ${virusTest.faiblesses}');
        }
        // On pourrait aussi vérifier le print:
        // expect(() => virusTest.utiliserCapaciteSpeciale(null), prints(contains('MutationRapide')));
      });
    });

    // Test pour la classe Bacterie
    group('Bacterie', () {
      late Bacterie bacterieTest;

      setUp(() {
        bacterieTest = Bacterie(
          nom: 'Testobacterie',
          pointsDeVieMax: 120,
          // armure: par défaut 5
          // degats: par défaut 8
          // vitesseInitiative: par défaut 3
          // typeAttaque: par défaut TypeAttaque.physique
          // faiblesses: par défaut [TypeAttaque.energetique]
          // resistances: par défaut [TypeAttaque.chimique]
        );
      });

      test('Initialisation correcte des PV et armure par défaut', () {
        expect(bacterieTest.pointsDeVie, equals(120));
        expect(bacterieTest.armure, equals(5));
      });

      test('Recevoir des dégâts normaux (type neutre, avec armure)', () {
        // TypeAttaque.corrosive (neutre pour cette bactérie par défaut)
        // Armure 5
        bacterieTest.recevoirDegats(30, TypeAttaque.corrosive);
        // Dégâts infligés = (30 * 1.0).round() - 5 = 25
        expect(bacterieTest.pointsDeVie, equals(120 - 25)); // 95
      });

      test('Recevoir des dégâts avec faiblesse (avec armure)', () {
        // Faiblesse à energetique (x1.5), armure 5
        bacterieTest.recevoirDegats(30, TypeAttaque.energetique);
        // Dégâts infligés = (30 * 1.5).round() - 5 = 45 - 5 = 40
        expect(bacterieTest.pointsDeVie, equals(120 - 40)); // 80
      });

      test('Recevoir des dégâts avec résistance (avec armure)', () {
        // Résistance à chimique (x0.5), armure 5
        bacterieTest.recevoirDegats(30, TypeAttaque.chimique);
        // Dégâts infligés = (30 * 0.5).round() - 5 = 15 - 5 = 10
        expect(bacterieTest.pointsDeVie, equals(120 - 10)); // 110
      });
      
      test('Recevoir des dégâts où armure absorbe tout (ou presque)', () {
        bacterieTest.recevoirDegats(5, TypeAttaque.corrosive); // 5 * 1.0 - 5 = 0 dégâts
        expect(bacterieTest.pointsDeVie, equals(120));
        bacterieTest.recevoirDegats(3, TypeAttaque.corrosive); // 3 * 1.0 - 5 = -2, donc 0 dégâts
        expect(bacterieTest.pointsDeVie, equals(120));
      });

      test('Vérification élimination (compte tenu de la faiblesse et armure)', () {
        expect(bacterieTest.estElimine(), isFalse);
        // Faiblesse à energetique (x1.5), armure 5. PV initiaux 120.
        // Pour infliger 120 dégâts réels: (QuantiteBase * 1.5) - 5 = 120
        // (QuantiteBase * 1.5) = 125
        // QuantiteBase = 125 / 1.5 = 83.33 -> round to 84
        // (84 * 1.5).round() - 5 = 126 - 5 = 121 dégâts
        bacterieTest.recevoirDegats(84, TypeAttaque.energetique);
        expect(bacterieTest.pointsDeVie, equals(0)); // 120 - 121 -> 0
        expect(bacterieTest.estElimine(), isTrue);
      });

      test('Utiliser capacité spéciale (BouclierBiofilm)', () {
        // L'effet de BouclierBiofilm est un print pour l'instant.
        // On peut tester que la méthode s'exécute sans erreur et le print.
        // Pour tester un effet réel (ex: augmentation d'armure), il faudrait modifier la classe.
        expect(
          () => bacterieTest.utiliserCapaciteSpeciale(null), // Cible non pertinente ici
          prints(contains('${bacterieTest.nom} active BouclierBiofilm !')),
        );
      });
    });

    // Test pour la classe Champignon
    group('Champignon', () {
      late Champignon champignonTest;

      setUp(() {
        champignonTest = Champignon(
          nom: 'Testochampignon',
          pointsDeVieMax: 80,
          // armure: par défaut 2
          // degats: par défaut 12
          // vitesseInitiative: par défaut 2
          // typeAttaque: par défaut TypeAttaque.chimique
          // faiblesses: par défaut [TypeAttaque.physique]
          // resistances: par défaut [TypeAttaque.energetique]
        );
      });

      test('Initialisation correcte des PV et armure par défaut', () {
        expect(champignonTest.pointsDeVie, equals(80));
        expect(champignonTest.armure, equals(2));
      });

      test('Recevoir des dégâts normaux (type neutre, avec armure)', () {
        // TypeAttaque.corrosive (neutre pour ce champignon par défaut)
        // Armure 2
        champignonTest.recevoirDegats(20, TypeAttaque.corrosive);
        // Dégâts infligés = (20 * 1.0).round() - 2 = 18
        expect(champignonTest.pointsDeVie, equals(80 - 18)); // 62
      });

      test('Recevoir des dégâts avec faiblesse (avec armure)', () {
        // Faiblesse à physique (x1.5), armure 2
        champignonTest.recevoirDegats(20, TypeAttaque.physique);
        // Dégâts infligés = (20 * 1.5).round() - 2 = 30 - 2 = 28
        expect(champignonTest.pointsDeVie, equals(80 - 28)); // 52
      });

      test('Recevoir des dégâts avec résistance (avec armure)', () {
        // Résistance à energetique (x0.5), armure 2
        champignonTest.recevoirDegats(20, TypeAttaque.energetique);
        // Dégâts infligés = (20 * 0.5).round() - 2 = 10 - 2 = 8
        expect(champignonTest.pointsDeVie, equals(80 - 8)); // 72
      });

      test('Vérification élimination (compte tenu de la faiblesse et armure)', () {
        expect(champignonTest.estElimine(), isFalse);
        // Faiblesse à physique (x1.5), armure 2. PV initiaux 80.
        // Pour infliger 80 dégâts réels: (QuantiteBase * 1.5) - 2 = 80
        // (QuantiteBase * 1.5) = 82
        // QuantiteBase = 82 / 1.5 = 54.66 -> round to 55
        // (55 * 1.5).round() - 2 = 82.5.round() - 2 = 83 - 2 = 81 dégâts
        champignonTest.recevoirDegats(55, TypeAttaque.physique);
        expect(champignonTest.pointsDeVie, equals(0)); // 80 - 81 -> 0
        expect(champignonTest.estElimine(), isTrue);
      });

      test('Utiliser capacité spéciale (InvisibilitéSporadique)', () {
        // L'effet est un print pour l'instant.
        expect(
          () => champignonTest.utiliserCapaciteSpeciale(null), // Cible non pertinente
          prints(contains('${champignonTest.nom} utilise InvisibilitéSporadique !')),
        );
      });
    });
  });
}