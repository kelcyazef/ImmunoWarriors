import 'package:flutter_test/flutter_test.dart';
import 'package:immuno_warriors/models/anticorps.dart';
import 'package:immuno_warriors/models/agent_pathogene.dart'; // Pour TypeAttaque et les cibles

void main() {
  group('Anticorps', () {
    late Anticorps anticorpsTest;
    late Virus cibleTest; // Exemple de cible

    setUp(() {
      anticorpsTest = Anticorps(
        nom: 'Testicorps',
        type: TypeAnticorps.specifique,
        pointsDeVieMax: 150,
        typeAttaque: TypeAttaque.physique,
        degats: 25,
        coutRessources: 50,
        tempsProduction: 2,
        vitesseInitiative: 6,
      );
      cibleTest = Virus(nom: 'Ciblovirus', pointsDeVieMax: 80, degats: 5, vitesseInitiative: 3);
    });

    test('Initialisation correcte', () {
      expect(anticorpsTest.pointsDeVie, 150);
    });

     test('Attaquer une cible', () {
      final pvCibleAvant = cibleTest.pointsDeVie; // pvCibleAvant est 80
      anticorpsTest.attaquer(cibleTest);
      // Ciblovirus (Virus) a une résistance par défaut à physique (0.5)
      // Dégâts infligés = (25 * 0.5).round() = 13
      expect(cibleTest.pointsDeVie, equals(pvCibleAvant - 13)); // Soit 80 - 13 = 67
      // Ou directement :
      // expect(cibleTest.pointsDeVie, equals(67));
    });
    test('Recevoir des dégâts', () {
      anticorpsTest.recevoirDegats(30, TypeAttaque.corrosive);
      expect(anticorpsTest.pointsDeVie, equals(120));
    });

    test('Vérification élimination', () {
      expect(anticorpsTest.estElimine(), isFalse);
      anticorpsTest.recevoirDegats(200, TypeAttaque.energetique);
      expect(anticorpsTest.estElimine(), isTrue);
    });

    // Tests pour les capacités spéciales (plus complexes)
  });
}