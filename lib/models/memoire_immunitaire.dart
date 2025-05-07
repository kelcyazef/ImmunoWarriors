import 'agent_pathogene.dart'; // Pour TypePathogene ou signatures spécifiques

/// Stocke les "signatures" des pathogènes vaincus. [cite: 41]
/// Applique des bonus passifs contre les pathogènes connus.
class MemoireImmunitaire {
  Set<TypePathogene> signaturesConnues; // Simplifié, pourrait être plus détaillé

  MemoireImmunitaire({this.signaturesConnues = const {}});

  void ajouterSignature(TypePathogene type) { /* ... */ }
  double getBonusContre(TypePathogene type) { /* ... */ return 0.0;} // Ex: 0.1 pour 10% bonus
  // Vulnérable aux mutations majeures (logique à définir) [cite: 41]
}