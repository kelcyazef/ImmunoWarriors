/// Gère l'état de la recherche du joueur. [cite: 45, 66]
class Technologie {
  final String id;
  final String nom;
  final String description;
  final int coutPointsRecherche;
  bool estDebloquee;
  // Effets de la technologie (pourraient être des callbacks ou des modificateurs de stats)

  Technologie({
    required this.id,
    required this.nom,
    required this.description,
    required this.coutPointsRecherche,
    this.estDebloquee = false,
  });
}

class LaboratoireRecherche {
  List<Technologie> technologiesDisponibles;
  int pointsDeRechercheJoueur;

  LaboratoireRecherche({this.technologiesDisponibles = const [], this.pointsDeRechercheJoueur = 0});

  bool peutDebloquer(Technologie tech) { /* ... */ return false;}
  void debloquerTechnologie(Technologie tech) { /* ... */ }
}