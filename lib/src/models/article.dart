class Article {
  String description;
  int quantite;
  double prixUnitaire;

  Article({
    this.description = '',
    this.quantite = 1,
    this.prixUnitaire = 0,
  });

  double get totalHT => quantite * prixUnitaire;

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'quantite': quantite,
      'prixUnitaire': prixUnitaire,
      'totalHT': totalHT,
    };
  }
} 