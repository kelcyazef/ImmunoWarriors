/// Gère les ressources du joueur (Énergie, Bio-matériaux). [cite: 40]
class RessourcesDefensives {
  int energie;
  int bioMateriaux;
  // Taux de régénération, etc.

  RessourcesDefensives({this.energie = 100, this.bioMateriaux = 500});

  void regenerer() { /* ... */ }
  bool consommer(int coutEnergie, int coutBioMateriaux) { /* ... */ return false;}
}